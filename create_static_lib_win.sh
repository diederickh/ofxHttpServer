#!/bin/sh
# tiny helper to compile libmicrohttpd on windows using MinGW/MSYS, and the 
# C:\MinGW\msys\1.0\msys.bat shell (execute that bat to get the shell!)
#
# We assume that you've downloaded the libmicrohttpd-0.9.1.tar.gz file!
dir=${PWD}
if [ ! -f libmicrohttpd-0.9.1.tar.gz ] ; then
	echo "First download ftp://ftp.gnu.org/gnu/libmicrohttpd/libmicrohttpd-0.9.1.tar.gz to this directory"
	exit
fi

if [ "${1}" = "" ] ; then 
	rm -rf libmicrohttpd-0.9.1
	tar -zxvf libmicrohttpd-0.9.1.tar.gz
fi
if [ "$1" = "svn" ] ; then
	rm -rf libmicrohttpd-0.9.1
	svn checkout -r 12577 https://gnunet.org/svn/libmicrohttpd/ libmicrohttpd-0.9.1
fi

cd ${dir}/libmicrohttpd-0.9.1
if [ "$1" = "svn" ] ; then
	./bootstrap
fi
./configure --enable-static \
	--disable-https \
	--disable-messages
	
		
	
