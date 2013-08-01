#!/bin/bash

source variables.sh

mkdir -p $BUILD_PATH

function install_lua() {
    echo "Installing Lua..."
		
		curl -o $BUILD_PATH/$LUA_PACKAGE.tar.gz -R -O $LUA_URL/$LUA_PACKAGE.tar.gz
 	 cd $BUILD_PATH
	 tar zxf $LUA_PACKAGE.tar.gz
	 cd $LUA_PACKAGE
	 make macosx test
	 make install

	 lua -v
	 if [[ $? -ne 0 ]]; then
		echo "Failed"
	 fi
}


install_love() {
	echo "Installing Love..."
	curl -o $BUILD_PATH/$LOVE_PACKAGE.zip -R -O $LOVE_URL/$LOVE_PACKAGE.zip
	cd $BUILD_PATH
	unzip -of $LOVE_PACKAGE.zip
	ln -s $BUILD_PATH/love.app/Contents/MacOS/love /usr/bin/love
	echo "Love Installed"
}


install_lua
install_love
