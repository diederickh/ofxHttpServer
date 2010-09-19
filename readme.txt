Forked http://github.com/arturoc/ofxHttpServer and updated ofxHttpServer
to use libmicrohttpd >= 0.9 which has some extra handy features. Added
- ofxHttpServersResponse.getParameter(std::string sName)
- redirect feature

Creating static libs from libmicrohttpd
========================================

Mac OSX
--------------------------------------------------------------------------------
The file create.sh compiles the latest libmicrohttpd version from SVN 
on MAC. Make sure to copy the libmicrohttpd.a file after compiling
from: microhttpd/stage/lib/

Windows Vista: Creating a static lib from libmicrohttpd source code:
--------------------------------------------------------------------------------

- Install MingW to C:\MinGW:
	- Goto http://sourceforge.net/projects/mingw/files/
	- Download mingw-get-inst-20100909.exe
	- Run mingw-get-inst-20100909.exe, click next, make sure to select
	  "Use pre-packaged repository catalogues" 
	  and select at least this components:
	  * C Compiler
	  * C++ Compiler
	  * MSYS Basic System
	  * MinGW Developer Toolkit
	  
	- Install the pthread library:
		- Open the MinGW/MSYS shell: C:\MinGW\msys\1.0\msys.bat
		- Type: mingw-get update
		- Find the pthread library in the catalogue which we need to install
		  manually, so type:
		 
		  $ grep "package name" /mingw/var/lib/mingw-get/data/*.xml | grep pthread
		  
		  You'll see something like, which tells you the names of the 
		  pthread package you need to intall:
		  /mingw/var/lib/mingw-get/data/mingw32-pthreads-w32.xml:    <package name="mingw32-pthreads-w32" alias="pthreads-w32 pthreads">
		  /mingw/var/lib/mingw-get/data/mingw32-pthreads-w32.xml:    <package name="mingw32-libpthread" alias="libpthread">

		- Then type:
		  $ mingw-get install mingw32-pthreads-w32
		  
		- This will install pthread in you MinGW environment. You can check if
		  this file was installed;
		  C:\MinGW\lib\libpthread.dll.a
		  
	- Now, download ftp://ftp.nluug.nl/pub/gnu/libmicrohttpd/libmicrohttpd-0.9.1.tar.gz
	  and extract it somewhere on your Windows computer.
	  
	- Next we need to install PlibC 0.1.5
		- Download http://sourceforge.net/projects/plibc/files/plibc/0.1.5/plibc-0.1.5.zip/download
		- Extract it, and just copy the "bin, include" and "lib" directories into your
		  C:\MinGW\ directory.
	  
	- Then compile using the same shell you just opened (C:\MinGW\msys\1.0\msys.bat):
	  - go to the directory where you extracted the libmicrohttpd-0.9.1.tar.gz file.
	  - type: 
	  	$ /configure --enable-static --disable-https --disable-messages
	  	$ make
	  	
	  - Now you've got a static libmicrohttpd.a file in:
	  	libmicrohttpd-0.9.1\src\deamon\.libs\libmicrohttpd.a
	
	 ++++++++++++++++
	 Some openFrameworks related notes only while creating a static lib for 
	 libmicrohttpd
	 ++++++++++++++++
	 + Copy these files to the src directory of ofxHttpServer\src\
	 	- libmicrohttpd-0.9.1\src\include\microhttpd.h
	 	- libmicrohttpd-0.9.1\src\include\platform.h
	 	- libmicrohttpd-0.9.1\src\include\plibc\plibc.h (also just to src)
	 + 	To use libmicrohttpd in a Code::blocks project I had to add this before
	 	I included the microhttpd.h file:
	 	
	 	#if defined( __WIN32__ ) || defined( _WIN32 )
			#define MHD_PLATFORM_H
			#include <ws2tcpip.h>
			#include <stdint.h>
		#else
			#include <sys/socket.h>
		#endif
	 	
Windows Vista: using ofxHttpServer in a openFrameworks project using Code::blocks
--------------------------------------------------------------------------------
- Download ofxHttpServer from github: http://github.com/roxlu/ofxHttpServer
  to a new directory in your openFrameworks dir: "addons_diederick/ofxHttpServer"
- Copy the emptyExample directory from the apps\examples dir (you can find 
this where you installed openFrameworks-0.061)
- Open the emptyExample.cbp in Code::Blocks
- Try to compile it.. if it fails now, check the openFrameworks forum for more
info.
- Copy these files:
	- C:\MinGW\lib\libpthread.dll > Codeblocks_mingw_dir\lib\
	- C:\MinGW\lib\libplibc.dll.a >  Codeblocks_mingw_dir\lib\
	- C:\MinGW\include\pthread.h > Codeblocks_mingw_dir\include\
	
- Next we need to add the ofxHttpServer to our project:
	- 	Right click on the project name > add files recursively, and browse 
	 	to the directory whith ofxHttpServer\src
	-	Right click project > build options > Search directories > Compiler (make sure the
		project name is selected in the left pane (not release or debug).
		Click "Add" to add two search directories:
		..\..\..\addons_diederick\ofxHttpServer\src
		..\..\..\addons_diederick\ofxHttpServer\libs\microhttpd\include
		
	- Right click project > build options > linker settings, and add (add 
		these libs to the "left" pane:
		..\..\..\addons_diederick\ofxHttpServer\libs\microhttpd\lib\win32\libmicrohttpd.a
		C:\Program Files\CodeBlocks\MinGW\lib\libpthread.a
		C:\Program Files\CodeBlocks\MinGW\lib\libplibc.dll.a
		C:\Program Files\CodeBlocks10\MinGW\lib\libws2_32.a
	
		
Some tips
----------
While trying to compile libmicrohttpd on Windows Vista I had to figure out
lots of compilation errors/problems. Some things I learned while compiling this:

- MinGW is awesome!

- Use: C:\MinGW\msys\1.0\msys.bat to get a shell in which you compile your 
  libraries 
  
- To find out how to fix "undefined reference to ..." errors I used the "nm"
  util from MinGW. To use it, open C:\MinGW\msys\1.0\msys.bat, go to the lib
  dir: cd /mingw/lib
  and type: nm -A --defined-only /mingw/lib/*.a
  
