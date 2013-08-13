#!/bin/bash

source variables.sh


function uninstall_lua() {
  echo "Uninstalling Lua..."
  rm $BUILD_PATH/lua52
  rm /usr/bin/lua
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

