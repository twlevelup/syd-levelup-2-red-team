require 'presets'

BackgroundSound = {}
BackgroundSound.__index = BackgroundSound

function BackgroundSound:new(game)

    newBackgroundSound = {
        sound = {
            source = "assets/sounds/on-cloud.wav" -- Music free version from PlayOnLoop.com CCBy3.0 Licence
        },
        love = game,
        repeats = false
    }

    if game.audio ~= nil then
        newBackgroundSound.sound.sample = game.audio.newSource(newBackgroundSound.sound.source)
        newBackgroundSound.sound.sample:setLooping(true)
    end

	return setmetatable(newBackgroundSound, self)
end

function BackgroundSound:play()
    self.sound.sample:play()
end

function BackgroundSound:stop()
    self.sound.sample:stop()
end