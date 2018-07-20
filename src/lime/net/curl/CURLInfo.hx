package lime.net.curl; #if (!lime_doc_gen || lime_curl)


@:enum abstract CURLInfo(Int) from Int to Int from UInt to UInt {

	var NONE = 0;
	var EFFECTIVE_URL = 0x100000 + 1;
	var RESPONSE_CODE = 0x200000 + 2;
	var TOTAL_TIME = 0x300000 + 3;
	var NAMELOOKUP_TIME = 0x300000 + 4;
	var CONNECT_TIME = 0x300000 + 5;
	var PRETRANSFER_TIME = 0x300000 + 6;
	var SIZE_UPLOAD = 0x300000 + 7;
	var SIZE_UPLOAD_T = 0x600000 + 7;
	var SIZE_DOWNLOAD = 0x300000 + 8;
	var SIZE_DOWNLOAD_T = 0x600000 + 8;
	var SPEED_DOWNLOAD = 0x300000 + 9;
	var SPEED_DOWNLOAD_T = 0x600000 + 9;
	var SPEED_UPLOAD = 0x300000 + 10;
	var SPEED_UPLOAD_T = 0x600000 + 10;
	var HEADER_SIZE = 0x200000 + 11;
	var REQUEST_SIZE = 0x200000 + 12;
	var SSL_VERIFYRESULT = 0x200000 + 13;
	var FILETIME = 0x200000 + 14;
	var CONTENT_LENGTH_DOWNLOAD = 0x300000 + 15;
	var CONTENT_LENGTH_DOWNLOAD_T = 0x600000 + 15;
	var CONTENT_LENGTH_UPLOAD = 0x300000 + 16;
	var CONTENT_LENGTH_UPLOAD_T = 0x300000 + 16;
	var STARTTRANSFER_TIME = 0x300000 + 17;
	var CONTENT_TYPE = 0x100000 + 18;
	var REDIRECT_TIME = 0x300000 + 19;
	var REDIRECT_COUNT = 0x200000 + 20;
	var PRIVATE = 0x100000 + 21;
	var HTTP_CONNECTCODE = 0x200000 + 22;
	var HTTPAUTH_AVAIL = 0x200000 + 23;
	var PROXYAUTH_AVAIL = 0x200000 + 24;
	var OS_ERRNO = 0x200000 + 25;
	var NUM_CONNECTS = 0x200000 + 26;
	var SSL_ENGINES = 0x400000 + 27;
	var COOKIELIST = 0x400000 + 28;
	var LASTSOCKET = 0x200000 + 29;
	var FTP_ENTRY_PATH = 0x100000 + 30;
	var REDIRECT_URL = 0x100000 + 31;
	var PRIMARY_IP = 0x100000 + 32;
	var APPCONNECT_TIME = 0x300000 + 33;
	var CERTINFO = 0x400000 + 34;
	var CONDITION_UNMET = 0x200000 + 35;
	var RTSP_SESSION_ID = 0x100000 + 36;
	var RTSP_CLIENT_CSEQ = 0x200000 + 37;
	var RTSP_SERVER_CSEQ = 0x200000 + 38;
	var RTSP_CSEQ_RECV = 0x200000 + 39;
	var PRIMARY_PORT = 0x200000 + 40;
	var LOCAL_IP = 0x100000 + 41;
	var LOCAL_PORT = 0x200000 + 42;
	var TLS_SESSION = 0x400000 + 43;
	var ACTIVESOCKET = 0x500000 + 44;
	var TLS_SSL_PTR = 0x400000 + 45;
	var HTTP_VERSION = 0x200000 + 46;
	var PROXY_SSL_VERIFYRESULT = 0x200000 + 47;
	var PROTOCOL = 0x200000 + 48;
	var SCHEME = 0x100000 + 49;

}


#end