local area = {}

local icon = love.image.newImageData("/assets/icon.png");

function area.load() 
  	love.window.setTitle("Pokemon")
	love.window.setMode(960, 640)
  	love.graphics.setBackgroundColor(1,1,1)
  	love.window.setIcon(icon);
end

function area.update(dt)
end

function area.draw() 
end

function area.mousepressed(x, y, button, istouch)
end

function area.keypressed(key, code)
end

function area.wheelmoved(x, y)
end

return area