-- List of ores to mine
local ores = {
	"minecraft:iron_ore",
	"minecraft:gold_ore",
	"minecraft:coal_ore",
	"minecraft:diamond_ore",
	"minecraft:redstone_ore",
	"minecraft:emerald_ore",
	"minecraft:lapis_ore",
	"minecraft:nether_quartz_ore",
	"minecraft:deepslate_iron_ore", -- add other ores as needed
	"buddycards:luminis_ore",
}

-- Function to check if the block is an ore
function isOre(block)
	if block.tags["forge:ores"] then
		return true
	end
	for _, ore in pairs(ores) do
		if block.name == ore then
			return true
		end
	end
	return false
end

-- Function to mine a block and recursively mine connected ores in all directions
function mineVein()
	-- Forward inspection
	if turtle.detect() then
		local success, block = turtle.inspect()

		if success and isOre(block) then
			turtle.dig()
			turtle.forward()
			mineVein() -- Recursively mine in the new position
			turtle.back()
		end
	end

	-- Upward inspection
	if turtle.detectUp() then
		local success, block = turtle.inspectUp()

		if success and isOre(block) then
			turtle.digUp()
			turtle.up()
			mineVein() -- Recursively mine in the new position
			turtle.down()
		end
	end

	-- Downward inspection
	if turtle.detectDown() then
		local success, block = turtle.inspectDown()

		if success and isOre(block) then
			turtle.digDown()
			turtle.down()
			mineVein() -- Recursively mine in the new position
			turtle.up()
		end
	end

	-- Side inspections
	for i = 1, 4 do
		turtle.turnLeft()
		if turtle.detect() then
			local success, block = turtle.inspect()
			if success and isOre(block) then
				turtle.dig()
				turtle.forward()
				mineVein() -- Recursively mine in the new position
				turtle.back()
			end
		end
	end
end

-- Function to strip mine a 1x2 tunnel and mine any veins found
function stripMine(length)
	-- for i = 1, length do
	local i = 0
	while i < length do
		-- Mine the block in front and above
		if turtle.detect() then
			turtle.dig()
		end

		-- Move forward
		if not turtle.detect() then
			moveForward()
			i = i + 1
		end

		if turtle.detectUp() then
			turtle.digUp()
			moveUp()
			mineVein()
			moveDown()
		end

		-- Check for ores and mine veins if found
		mineVein()
	end
end

-- Function to track and return to the start point
function mineAndReturn(length)
	local x, y, z = 0, 0, 0
	local direction = 0 -- 0=north, 1=east, 2=south, 3=west

	function updatePosition(move)
		if move == "forward" then
			if direction == 0 then
				print(x, y, z)
				z = z - 1
			elseif direction == 1 then
				x = x + 1
			elseif direction == 2 then
				z = z + 1
			elseif direction == 3 then
				x = x - 1
			end
		elseif move == "back" then
			if direction == 0 then
				z = z + 1
			elseif direction == 1 then
				x = x - 1
			elseif direction == 2 then
				z = z - 1
			elseif direction == 3 then
				x = x + 1
			end
		elseif move == "up" then
			y = y + 1
		elseif move == "down" then
			y = y - 1
		end
	end

	function moveForward()
		turtle.forward()
		updatePosition("forward")
	end

	function moveBack()
		turtle.back()
		updatePosition("back")
	end

	function moveUp()
		turtle.up()
		updatePosition("up")
	end

	function moveDown()
		turtle.down()
		updatePosition("down")
	end

	function turnRight()
		turtle.turnRight()
		direction = (direction + 1) % 4
	end

	function turnLeft()
		turtle.turnLeft()
		direction = (direction - 1) % 4
	end

	-- Start strip mining
	stripMine(length)

	-- Returning to start point
	while x ~= 0 or y ~= 0 or z ~= 0 do
		print(x, y, z)
		if y > 0 then
			moveDown()
		elseif y < 0 then
			moveUp()
		elseif z > 0 then
			while direction ~= 2 do
				turnRight()
			end
			moveForward()
		elseif z < 0 then
			while direction ~= 2 do
				turnRight()
			end
			moveForward()
			-- moveBack()
		elseif x > 0 then
			while direction ~= 1 do
				turnRight()
			end
			moveForward()
		elseif x < 0 then
			while direction ~= 3 do
				turnRight()
			end
			moveForward()
		end
	end
end

-- Execute the mining and returning function with a strip mine length of 20 blocks
mineAndReturn(5)
