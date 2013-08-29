ThoughtWorks LevelUp project starter kit
=========================

## Getting started
### OSX

1. You'll need a version of gcc installed, so you'll need to install XCode with it's command line tools.
2. Install [Lua](http://www.lua.org/) & [Loverocks](http://luarocks.org/) via [homebrew](http://brew.sh/) (if you're not using homebrew, you probably should be): 

        brew install lua 
        brew install loverocks

3. Install [LÖVE](http://love2d.org/) to your applications folder.
4. Add an alias in your ~/.bash_profile (or your shell of choice's config) to LÖVE:

        alias love="/Applications/love.app/Contents/MacOS/love"

5. Install [Busted](http://olivinelabs.com/busted/):

        sudo luarocks install busted

### Ubuntu (or other debian derived system)

1. Install [Lua](http://www.lua.org/), [Loverocks](http://luarocks.org/), and [LÖVE](http://love2d.org/):

        sudo apt-get install lua5.1 luarocks love

2. Install [Busted](http://olivinelabs.com/busted/):

        sudo luarocks install busted

### OSX via our script

You may also be able to get set up via our script though it is untested for general use so your mileage may vary. From the project root, you can try your luck with:

    ./setup/install.sh

### Windows

We don't use Windows, so you're on your own. We recommend checking out the [Lua website](http://www.lua.org), the [Loverocks website](http://luarocks.org/), and the [LÖVE website](http://love2d.org/) for more information. Google is also your friend.

### Making it go

Now after cd'ing into the project directory, you should be able to run your tests. Running

     busted

should output something like:

    ●●●●●●●●●●●●●●●●●●●●●
    21 successes / 0 failures / 0 pending : 0.004726 seconds.

You should also be able to run:

    love .

and see a happy little nyancat.

