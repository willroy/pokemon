local menu = {}

local menuImage = love.graphics.newImage("/assets/menu.png")
local menuPress = love.graphics.newImage("/assets/press.png")

local timer = 0
local displayStart = true

function menu.load() 
  	love.window.setTitle("Pokemon - Menu")
end

function menu.update(dt)
	timer = timer + 1
	if timer == 20 then 
		timer = 0 
		displayStart = not displayStart
	end
end

function menu.draw()
	love.graphics.setColor(1, 1, 1)
	love.graphics.draw(menuImage, 0, 0)
	if displayStart then love.graphics.draw(menuPress, 346, 445) end
end

function menu.mousepressed(x, y, button, istouch)
end

function menu.keypressed(key, code)
end

function menu.wheelmoved(x, y)
end

return menu