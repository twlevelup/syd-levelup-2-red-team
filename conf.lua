-- Set DEBUG_MODE to true to enable useful debugging output
-- such as drawing the bounding box
--DEBUG_MODE = true

-- See https://love2d.org/wiki/Config_Files for the full list of configuration
-- options and defaults.

require 'presets'

function love.conf(config)
    config.title = GAME_NAME
    config.modules.joystick = false
    config.modules.mouse = false
    config.modules.physics = false
    config.screen.width = GAME_WIDTH
    config.screen.height = GAME_HEIGHT
end
