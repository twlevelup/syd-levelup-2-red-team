require 'presets'

local clock = os.clock
function sleep(seconds)
	local t0 = clock()
	while clock() - t0 <= seconds do end
end
sleep(GAME_OVER_SECONDS)
thread = love.thread.getThread()
thread:set('ready', true)