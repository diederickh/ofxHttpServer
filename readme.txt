Forked http://github.com/arturoc/ofxHttpServer and updated ofxHttpServer
to use libmicrohttpd >= 0.9 which has some extra handy features. Added
- ofxHttpServersResponse.getParameter(std::string sName)
- redirect feature

The file create.sh compiles the latest libmicrohttpd version from SVN 
on MAC. Make sure to copy the libmicrohttpd.a file after compiling
from: microhttpd/stage/lib/
