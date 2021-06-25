local menu = {}

local icon = love.image.newImageData("/assets/icon.png");

function menu.load() 
  	love.window.setTitle("Pokemon - Menu")
	love.window.setMode(960, 640)
  	love.graphics.setBackgroundColor(1,1,1)
  	love.window.setIcon(icon);
end

function menu.update(dt)
end

function menu.draw() 
end

function menu.mousepressed(x, y, button, istouch)
end

function menu.keypressed(key, code)
end

function menu.wheelmoved(x, y)
end

return menu