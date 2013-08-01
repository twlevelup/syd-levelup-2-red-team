#!/bin/bash

source variables.sh


function uninstall_lua() {
  echo "Uninstalling Lua..."

  cd $BUILD_PATH/$LUA_PACKAGE
  make uninstall
  rm -rf $BUILD_PATH/$LUA_PACKAGE
	echo "Bye-bye Lua!"
}


function uninstall_love() {
  echo "Uninstalling Love..."

  rm -rf $BUILD_PATH/$LOVE_PACKAGE
	rm /usr/bin/love 
	echo "Bye-bye Love!"


}

uninstall_lua
uninstall_love

