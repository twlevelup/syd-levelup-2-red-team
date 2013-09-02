-- Set DEBUG_MODE to true to enable useful debugging output
-- such as drawing the bounding box
--DEBUG_MODE = true

-- See https://love2d.org/wiki/Config_Files for the full list of configuration
-- options and defaults.

function love.conf(config)
    config.title = "Nyancat to the rescue"
    config.modules.joystick = false
    config.modules.mouse = false
    config.modules.physics = false
end
