#!/bin/bash

source variables.sh


function uninstall_lua() {
  echo "Uninstalling Lua..."
  rm -rf $BUILD_PATH/$LUA_PACKAGE
  rm /usr/bin/lua
  echo "Bye-bye Lua!"
}


function uninstall_love() {
  echo "Uninstalling Love..."

  rm -rf $BUILD_PATH/$LOVE_PACKAGE
	rm /usr/bin/love 
	rm /Applications/love.app
	echo "Bye-bye Love!"


}

uninstall_lua
uninstall_love

