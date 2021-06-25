local game = {}

local area = require("src/game/area")
local battle = require("src/game/battle")

local icon = love.image.newImageData("/assets/icon.png");

local inBattle = false

function game.load() 
  	love.window.setTitle("Pokemon")
	love.window.setMode(960, 640)
  	love.graphics.setBackgroundColor(1,1,1)
  	love.window.setIcon(icon);
end

function game.update(dt)
	if inBattle then battle.update(dt)
	else area.update(dt) end
end

function game.draw() 
	if inBattle then battle.draw() 
	else area.draw() end
end

function game.mousepressed(x, y, button, istouch)
	if inBattle then battle.mousepressed(x, y, button, istouch)
	else area.mousepressed(x, y, button, istouch) end
end

function game.keypressed(key, code)
	if inBattle then battle.keypressed(key, code)
	else area.keypressed(key, code) end
end

function game.wheelmoved(x, y)
	if inBattle then battle.wheelmoved(x, y)
	else area.wheelmoved(x, y) end
end

return game