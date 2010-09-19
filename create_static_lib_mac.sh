#!/bin/sh
# this file creates the static lib for libmicrohttpd on a mac
if [ "$1" = "reset" ] ; then 
	echo "Reset"
	if [ -d microhttpd ] ; then 
		echo "remove!"
		rm -rf microhttpd	
	fi
	svn checkout -r 12577 https://gnunet.org/svn/libmicrohttpd/ microhttpd
	mkdir microhttpd/stage
fi

if [ ! -d ${PWD}/microhttpd ] ; then
	echo "First use: ${0} reset"
	exit
fi

dir=${PWD}/microhttpd/stage
cd microhttpd
./bootstrap
./configure --prefix=${dir} \
	--enable-static \
	--disable-https \
	CC="gcc -arch i386 " \
	CXX="g++ -arch i386 " \
	CPP="gcc -E" CXXCPP="g++ -E"  
	
make clean
make
make install
