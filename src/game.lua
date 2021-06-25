local game = {}

local map = require("src/game/map")
local battle = require("src/game/battle")

local inBattle = false

function game.load() 
  	love.window.setTitle("Pokemon")
  	map.load()
end

function game.update(dt)
	if inBattle then battle.update(dt)
	else map.update(dt) end
end

function game.draw() 
	if inBattle then battle.draw() 
	else map.draw() end
end

function game.mousepressed(x, y, button, istouch)
	if inBattle then battle.mousepressed(x, y, button, istouch)
	else map.mousepressed(x, y, button, istouch) end
end

function game.keypressed(key, code)
	if inBattle then battle.keypressed(key, code)
	else map.keypressed(key, code) end
end

function game.wheelmoved(x, y)
	if inBattle then battle.wheelmoved(x, y)
	else map.wheelmoved(x, y) end
end

return game