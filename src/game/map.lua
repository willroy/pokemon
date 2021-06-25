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
	for line in io.lines(love.filesystem.getWorkingDirectory().."/../../db/map.proj") do
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
	lowX = 10000000
	lowY = 10000000
	highX = 0
	highY = 0
	-- Get top left tile and bottom right tile locations
	for i = 1, #tiles do
		if lowX > tiles[i][1] then lowX = tiles[i][1] end
		if lowY > tiles[i][2] then lowY = tiles[i][2] end
		if highX < tiles[i][1] then highX = tiles[i][1] end
		if highY < tiles[i][2] then highY = tiles[i][2] end
	end
	-- Get difference amount of chunks that can fit on map
	xDiff = highX - lowX
	yDiff = highY - lowY
	xDiff = math.ceil(xDiff / 640)
	yDiff = math.ceil(yDiff / 640)
	-- make a chunk for each possible chunk position on map
	for x = 1, xDiff do
		for y = 1, yDiff do
			tmp[#tmp+1] = {{(x-1)*640, (y-1)*640}, {}}
		end
	end
	-- Add tile to chunk based on which chunk the tile is in
	for i = 1, #tiles do
		local chunk = math.ceil(tiles[i][1]/640)
		tmp[chunk][2][#tmp[chunk][2]+1] = {tiles[i][1], tiles[i][2], tiles[i][3], tiles[i][4], tiles[i][5]}
	end
    chunks = tmp
end

function map.getLoadedChunks(chunks)
end

return map