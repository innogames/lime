package lime;


#if macro
import haxe.macro.Compiler;
import haxe.macro.Context;
#else
import haxe.PosInfos;
import lime.utils.Log;
#end

#if !lime_debug
@:fileXml('tags="haxe,release"')
@:noDebug
#end


class Lib {
	
	
	#if macro
	public static function extraParams ():Void {
		
		if (!Context.defined ("tools") && !Context.defined ("nocffi")) {
			
			if (!Context.defined ("flash") && (!Context.defined ("js") || Context.defined ("nodejs"))) {
				
				Compiler.define ("lime-cffi");
				Compiler.define ("native");
				Compiler.define ("lime-curl");
				Compiler.define ("lime-vorbis");
				
			}
			
			if (Context.defined ("js") && !Context.defined ("nodejs") && !Context.defined ("display")) {
				
				Compiler.define ("html5");
				Compiler.define ("web");
				Compiler.define ("lime-opengl");
				
			}
			
		}
		
	}
	#else
	
	@:noCompletion private static var __sentWarnings = new Map<String, Bool> ();
	
	public static function notImplemented (api:String, ?posInfo:PosInfos):Void {
		
		if (!__sentWarnings.exists (api)) {
			
			__sentWarnings.set (api, true);
			
			Log.warn (api + " is not implemented", posInfo);
			
		}
		
	}
	#end
	
	
}
