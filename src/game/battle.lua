local battle = {}

local icon = love.image.newImageData("/assets/icon.png");

function battle.load() 
  	love.window.setTitle("Pokemon")
	love.window.setMode(960, 640)
  	love.graphics.setBackgroundColor(1,1,1)
  	love.window.setIcon(icon);
end

function battle.update(dt)
end

function battle.draw() 
end

function battle.mousepressed(x, y, button, istouch)
end

function battle.keypressed(key, code)
end

function battle.wheelmoved(x, y)
end

return battle