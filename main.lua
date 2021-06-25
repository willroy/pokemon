game = require("game")
menu = require("menu")

local icon = love.image.newImageData("assets/icon.png");

local state = "game"

function love.load() 
  	love.window.setTitle("Pokemon")
	love.window.setMode(1300, 1000)
  	love.graphics.setBackgroundColor(1,1,1)
  	love.window.setIcon(icon);
end

function love.update(dt)
	if scene == "game" then game.update(dt) end
	if scene == "menu" then menu.update(dt) end
end

function love.draw() 
	if scene == "game" then game.draw() end
	if scene == "menu" then menu.draw() end
end

function love.mousepressed(x, y, button, istouch)
	if scene == "game" then game.mousepressed(x, y, button, istouch) end
	if scene == "menu" then menu.mousepressed(x, y, button, istouch) end
end

function love.keypressed(key, code)
	if scene == "game" then game.keypressed(key, code) end
	if scene == "menu" then menu.keypressed(key, code) end
end

function love.wheelmoved(x, y)
	if scene == "game" then game.wheelmoved(x, y) end
	if scene == "menu" then menu.wheelmoved(x, y) end
end