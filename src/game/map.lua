local map = {}

local background = love.graphics.newImage("assets/background.png")

local vegetation = love.graphics.newImage("assets/outside/vegetation.png")
local groundtiles = love.graphics.newImage("assets/outside/groundTiles.png")
local rocks = love.graphics.newImage("assets/outside/rocks.png")
local items = love.graphics.newImage("assets/outside/items.png")
local othero = love.graphics.newImage("assets/outside/other.png")
local buildings = love.graphics.newImage("assets/outside/buildings.png")
local walls = love.graphics.newImage("assets/interiorgeneral/walls.png")
local flooring = love.graphics.newImage("assets/interiorgeneral/flooring.png")
local stairs = love.graphics.newImage("assets/interiorgeneral/stairs.png")
local misc = love.graphics.newImage("assets/interiorgeneral/misc.png")
local electronics = love.graphics.newImage("assets/interiorgeneral/electronics.png")
local tables = love.graphics.newImage("assets/interiorgeneral/tables.png")
local otheri = love.graphics.newImage("assets/interiorgeneral/other.png")

local spriteSheets = {["vegetation"] = vegetation, ["groundtiles"] = groundtiles, ["rocks"] = rocks, ["items"] = items, ["othero"] = othero, ["buildings"] = buildings, ["walls"] = walls, ["flooring"] = flooring, ["stairs"] = stairs, ["misc"] = misc, ["electronics"] = electronics, ["tables"] = tables, ["otheri"] = otheri}

local characters = love.graphics.newImage("assets/characters/characters.png")
local character = {["front"] = love.graphics.newQuad(206, 0, 28, 42, characters),
				   ["frontWalk"] = love.graphics.newQuad(296, 0, 30, 42, characters),
					["back"] = love.graphics.newQuad(236, 0, 28, 42, characters),
					["backWalk"] = love.graphics.newQuad(328, 0, 28, 42, characters),
					["left"] = love.graphics.newQuad(266, 0, 28, 42, characters),
					["leftWalk"] = love.graphics.newQuad(358, 0, 28, 42, characters),
				   ["right"] = love.graphics.newQuad(266, 0, 28, 42, characters),
				   ["rightWalk"] = love.graphics.newQuad(358, 0, 28, 42, characters)}

local tiles
local chunks
local loadedChunks
local mapPath

local lockMovement = false
local directionX = ""
local directionY = 0
local charX = 0
local charY = 0
local time = 0
local lock = false
local moving = false

local function roundDown(n)
  for i=0,32 do
    if n % 32 == 0 then return n end
    n = n - 1
  end
end

function map.load() 
  	love.window.setTitle("Pokemon")
  	map.getTiles()
  	map.getChunks()
end

function map.update(dt)
	time = time + dt

	if (charX % 32 == 0) and (charY % 32 == 0) and lock then moving = false end

	if moving == true then lock = true end

	if directionX == 1 and moving then charX = charX + 4 end
	if directionX == 0 and moving then charX = charX - 4 end

	if directionY == 1 and moving then charY = charY + 4 end
	if directionY == 0 and moving then charY = charY - 4 end

	if moving == false then
		if love.keyboard.isDown("w") or love.keyboard.isDown("a") or love.keyboard.isDown("s") or love.keyboard.isDown("d") then
			moving = true
			lock = false
			directionX = ""
			directionY = ""
		end
		if love.keyboard.isDown("w") then directionY = 1
		elseif love.keyboard.isDown("s") then directionY = 0
		elseif love.keyboard.isDown("a") then directionX = 1
		elseif love.keyboard.isDown("d") then directionX = 0 end
	end
end

function map.draw() 
	love.graphics.draw(background, 0+charX, 0+charY)

	for i = 1, #chunks do
		for a = 1, #chunks[i][2] do
			local img = spriteSheets[chunks[i][2][a][5]]
			local quad = love.graphics.newQuad(chunks[i][2][a][3], chunks[i][2][a][4], 32, 32, img)
			love.graphics.draw(img, quad, chunks[i][1][1]+chunks[i][2][a][1]+charX, chunks[i][1][2]+chunks[i][2][a][2]+charY)
		end
	end

	if not moving then
		if directionY == 0 then love.graphics.draw(characters, character["front"], 448, 280) end
		if directionY == 1 then love.graphics.draw(characters, character["back"], 448, 280) end
		if directionX == 0 then love.graphics.draw(characters, character["right"], 480, 280, 0, -1, 1) end
		if directionX == 1 then love.graphics.draw(characters, character["left"], 448, 280) end
	end

	if moving then 
		if directionY == 0 and time < 0.25 then love.graphics.draw(characters, character["front"], 448, 280) end
		if directionY == 1 and time < 0.25 then love.graphics.draw(characters, character["back"], 448, 280) end
		if directionX == 0 and time < 0.25 then love.graphics.draw(characters, character["right"], 480, 280, 0, -1, 1) end
		if directionX == 1 and time < 0.25 then love.graphics.draw(characters, character["left"], 448, 280) end

		if directionY == 0 and time > 0.25 then love.graphics.draw(characters, character["frontWalk"], 446, 280) end
		if directionY == 1 and time > 0.25 then love.graphics.draw(characters, character["backWalk"], 448, 280) end
		if directionX == 0 and time > 0.25 then love.graphics.draw(characters, character["rightWalk"], 480, 278, 0, -1, 1) end
		if directionX == 1 and time > 0.25 then love.graphics.draw(characters, character["leftWalk"], 448, 278) end
	end

	if time > 0.5 then time = 0 end
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
	--need to do a test and db correction to make sure that lowX and lowY is set to 0, 0 
	--and to make sure that every other tile is updated to match new pos
	for i = 1, #tiles do
		if lowX > tiles[i][1] then lowX = tiles[i][1] end
		if lowY > tiles[i][2] then lowY = tiles[i][2] end
		if highX < tiles[i][1] then highX = tiles[i][1] end
		if highY < tiles[i][2] then highY = tiles[i][2] end
	end
	xDiff = highX - lowX
	yDiff = highY - lowY
	xDiff = math.ceil(xDiff / 640)
	yDiff = math.ceil(yDiff / 640)
	for x = 1, xDiff do
		for y = 1, yDiff do
			tmp[#tmp+1] = {{(x-1)*640, (y-1)*640}, {}}
		end
	end
	-- might need to do tiles[i][1]-lowX to make sure that chunks start from first tile not 0, 0
	for i = 1, #tiles do
		local chunk = math.ceil(tiles[i][1]/640)
		print(math.ceil(tiles[i][1]/640))
		tmp[chunk][2][#tmp[chunk][2]+1] = {roundDown(tiles[i][1])-(tmp[chunk][1][1]), roundDown(tiles[i][2])-(tmp[chunk][1][2]), tiles[i][3], tiles[i][4], tiles[i][5]}
	end
    chunks = tmp
end

function map.getLoadedChunks(chunks)
end

return map