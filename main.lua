local game = require("src/game")
local menu = require("src/menu")

local icon = love.image.newImageData("assets/icon.png");

local state = "game"
local loadGame = false
local loadMenu = false

function love.load() 
  	love.window.setTitle("Pokemon")
	love.window.setMode(960, 640)
  	love.graphics.setBackgroundColor(1,1,1)
  	love.window.setIcon(icon)
  	io.stdout:setvbuf("no")
end

function love.update(dt)
	if state == "game" then 
		if loadGame == false then
			game.load()
			loadGame = true
		end
		game.update(dt) 
	end
	if state == "menu" then 
		if loadMenu == false then
			menu.load()
			loadMenu = true
		end
		menu.update(dt) 
	end
end

function love.draw() 
	if state == "game" then game.draw() end
	if state == "menu" then menu.draw() end
end

function love.mousepressed(x, y, button, istouch)
	if state == "game" then game.mousepressed(x, y, button, istouch) end
	if state == "menu" then menu.mousepressed(x, y, button, istouch) end
end

function love.keypressed(key, code)
	if state == "game" then game.keypressed(key, code) end
	if state == "menu" then menu.keypressed(key, code) end
end

function love.wheelmoved(x, y)
	if state == "game" then game.wheelmoved(x, y) end
	if state == "menu" then menu.wheelmoved(x, y) end
end