package;


import haxe.io.Path;
import lime.project.Haxelib;
import sys.io.File;
import sys.io.Process;
import sys.FileSystem;
import lime.tools.helpers.FileHelper;
import lime.tools.helpers.HaxelibHelper;
import lime.tools.helpers.LogHelper;
import lime.tools.helpers.PathHelper;
import lime.tools.helpers.PlatformHelper;
import lime.tools.helpers.ProcessHelper;


class RunScript {
	
	
	private static function rebuildTools (rebuildBinaries = true):Void {
		
		var limeDirectory = HaxelibHelper.getPath (new Haxelib ("lime"), true);
		var toolsDirectory = PathHelper.combine (limeDirectory, "tools");
		/*var extendedToolsDirectory = HaxelibHelper.getPath (new Haxelib ("lime-extended"), false);
		
		if (extendedToolsDirectory != null && extendedToolsDirectory != "") {
			
			var buildScript = File.getContent (PathHelper.combine (extendedToolsDirectory, "tools.hxml"));
			buildScript = StringTools.replace (buildScript, "\r\n", "\n");
			buildScript = StringTools.replace (buildScript, "\n", " ");
			
			ProcessHelper.runCommand (toolsDirectory, "haxe", buildScript.split (" "));
			
		} else {*/
			
			ProcessHelper.runCommand (toolsDirectory, "haxe", [ "tools.hxml" ]);
			
		//}
		
		if (!rebuildBinaries) return;
		
		var platforms = [ "Windows", "Mac", "Mac64", "Linux", "Linux64" ];
		
		for (platform in platforms) {
			
			var source = PathHelper.combine (limeDirectory, "ndll/" + platform + "/lime.ndll");
			//var target = PathHelper.combine (toolsDirectory, "ndll/" + platform + "/lime.ndll");
			
			if (!FileSystem.exists (source)) {
				
				var args = [ "tools/tools.n", "rebuild", "lime", "-release", "-nocffi" ];
				
				if (LogHelper.verbose) {
					
					args.push ("-verbose");
					
				}
				
				if (!LogHelper.enableColor) {
					
					args.push ("-nocolor");
					
				}
				
				switch (platform) {
					
					case "Windows":
						
						if (PlatformHelper.hostPlatform == WINDOWS) {
							
							ProcessHelper.runCommand (limeDirectory, "neko", args.concat ([ "windows", toolsDirectory ]));
							
						}
					
					case "Mac":
						
						if (PlatformHelper.hostPlatform == MAC && PlatformHelper.hostArchitecture != X64) {
							
							ProcessHelper.runCommand (limeDirectory, "neko", args.concat ([ "mac", "-32", toolsDirectory ]));
							
						}
					
					case "Mac64":
						
						if (PlatformHelper.hostPlatform == MAC && PlatformHelper.hostArchitecture == X64) {
							
							ProcessHelper.runCommand (limeDirectory, "neko", args.concat ([ "mac", "-64", toolsDirectory ]));
							
						}
					
					case "Linux":
						
						if (PlatformHelper.hostPlatform == LINUX && PlatformHelper.hostArchitecture != X64) {
							
							ProcessHelper.runCommand (limeDirectory, "neko", args.concat ([ "linux", "-32", toolsDirectory ]));
							
						}
					
					case "Linux64":
						
						if (PlatformHelper.hostPlatform == LINUX && PlatformHelper.hostArchitecture == X64) {
							
							ProcessHelper.runCommand (limeDirectory, "neko", args.concat ([ "linux", "-64", toolsDirectory ]));
							
						}
					
				}
				
			}
			
			if (!FileSystem.exists (source)) {
				
				if (LogHelper.verbose) {
					
					LogHelper.warn ("", "Source path \"" + source + "\" does not exist");
					
				}
				
			} else {
				
				//FileHelper.copyIfNewer (source, target);
				
			}
			
		}
		
	}
	
	
	public static function runCommand (path:String, command:String, args:Array<String>, throwErrors:Bool = true):Int {
		
		var oldPath:String = "";
		
		if (path != null && path != "") {
			
			oldPath = Sys.getCwd ();
			
			try {
				
				Sys.setCwd (path);
				
			} catch (e:Dynamic) {
				
				LogHelper.error ("Cannot set current working directory to \"" + path + "\"");
				
			}
			
		}
		
		var result:Dynamic = Sys.command (command, args);
		
		if (oldPath != "") {
			
			Sys.setCwd (oldPath);
			
		}
		
		if (throwErrors && result != 0) {
			
			Sys.exit (1);
			
		}
		
		return result;
		
	}
	
	
	public static function main () {
		
		var args = Sys.args ();
		
		if (args.length > 2 && args[0] == "rebuild" && args[1] == "tools") {
			
			var lastArgument = new Path (args[args.length - 1]).toString ();
			var cacheDirectory = Sys.getCwd ();
			
			if (((StringTools.endsWith (lastArgument, "/") && lastArgument != "/") || StringTools.endsWith (lastArgument, "\\")) && !StringTools.endsWith (lastArgument, ":\\")) {
				
				lastArgument = lastArgument.substr (0, lastArgument.length - 1);
				
			}
			
			if (FileSystem.exists (lastArgument) && FileSystem.isDirectory (lastArgument)) {
				
				Sys.setCwd (lastArgument);
				
			}
			
			HaxelibHelper.workingDirectory = Sys.getCwd ();
			
			for (arg in args) {
				
				var equals = arg.indexOf ("=");
				
				if (equals > -1 && StringTools.startsWith (arg, "--")) {
					
					var argValue = arg.substr (equals + 1);
					var field = arg.substr (2, equals - 2);
					
					if (StringTools.startsWith (field, "haxelib-")) {
						
						var name = field.substr (8);
						HaxelibHelper.pathOverrides.set (name, PathHelper.tryFullPath (argValue));
						
					}
					
				}
				
			}
			
			LogHelper.verbose = args.indexOf ("-v") > -1 || args.indexOf ("-verbose") > -1;
			LogHelper.enableColor = args.indexOf ("-nocolor") > -1;
			var rebuildBinaries = args.indexOf ("-nocffi") == -1;
			rebuildTools (rebuildBinaries);
			
			if (args.indexOf ("-openfl") > -1) {
				
				Sys.setCwd (cacheDirectory);
				
			} else {
				
				Sys.exit (0);
				
			}
			
		}
		
		if (!FileSystem.exists ("tools/tools.n") || args.indexOf ("-rebuild") > -1) {
			
			var rebuildBinaries = args.indexOf ("-nocffi") == -1;
			rebuildTools (rebuildBinaries);
			
		}
		
		var args = [ "tools/tools.n" ].concat (args);
		Sys.exit (runCommand ("", "neko", args));
		
	}
	
	
}