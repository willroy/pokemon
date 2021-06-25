local map = {}

local tiles
local chunks
local loadedChunks
local mapPath

function map.load() 
  	love.window.setTitle("Pokemon")
  	map.getTiles()
  	map.getChunks()
end

function map.update(dt)
	if love.keyboard.isDown("w") then
		map.loadChunks()
	end
	if love.keyboard.isDown("a") then
		map.loadChunks()
	end
	if love.keyboard.isDown("s") then
		map.loadChunks()
	end
	if love.keyboard.isDown("d") then
		map.loadChunks()
	end
end

function map.draw() 
end

function map.mousepressed(x, y, button, istouch)
end

function map.keypressed(key, code)
end

function map.wheelmoved(x, y)

end

function map.getTiles()
	local tmp = {}
	for line in io.lines(love.filesystem.getWorkingDirectory().."/db/map.proj") do
    	item = {}
		for substring in line:gmatch("%S+") do
			table.insert(item, substring)
		end
		tmp[#tmp+1] = {tonumber(item[1]), tonumber(item[2]), tonumber(item[3]), tonumber(item[4]), item[5]}
    end
    tiles = tmp
end

function map.getChunks()
	local tmp = {}
	most far left
	for line in tiles do

	end
    chunks = tmp
end

function map.getLoadedChunks(chunks)
	local tmp = {}
	chunks
	loadedChunks = tmp
end

return map