#!/bin/bash

source variables.sh

mkdir -p $BUILD_PATH

function install_lua() {
    echo "Installing Lua..."
	 tar xf $LUA_PACKAGE.tar -C $BUILD_PATH
	 ln -s $BUILD_PATH/lua52 /usr/bin/lua
	 lua -v
	 if [[ $? -ne 0 ]]; then
		echo "Failed"
	 fi
}


install_love() {
	echo "Installing Love..."
	curl -o $BUILD_PATH/$LOVE_PACKAGE.zip -R -O $LOVE_URL/$LOVE_PACKAGE.zip
	cd $BUILD_PATH
	unzip -o $LOVE_PACKAGE.zip
	ln -s $BUILD_PATH/love.app/Contents/MacOS/love /usr/bin/love
	echo "Love Installed"
}


install_lua
install_love
