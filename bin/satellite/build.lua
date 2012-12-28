sm = smartmove
t = turtle

function returnToDock()
	sm.moveTo(352,64,458,0)
end

local headerText = "***************************************\n**   Welcome to Satellite builder    **\n**   v1.0                            **\n***************************************\n"

function header()
	common.printStandardHeader(headerText)
	--term.clear()
	--print(headerText)
end

-- Setup Vars
local kill = false
local waitingConfermation = false

--Enter Item selectiong phase
local slotFuel = 1
local slotComputer = 2
local slotDiskDrive = 3
local slotModem = 4
local slotCobblestone = 5
local slotWall = 6
local slotFloppy1 = 7
local slotFloppy2 = 8
local slotFloppy3 = 9
local slotFloppy4 = 10
local slotLight = 11
local slotTorch = 12


print("  _____      _  ____   _____ ")
print(" |  __ \\    | |/ __ \\ / ____|")
print(" | |__) |___| | |  | | (___  ")
print(" |  _  // _ \\ | |  | |\\___ \\ ")
print(" | | \\ \\  __/ | |__| |____) |")
print(" |_|  \\_\\___|_|\\____/|_____/ ")
print()


header()

print("Please fill slot " .. slotFuel .. " with Fuel")
while(turtle.getItemCount(slotFuel) == 0) do
	os.sleep( 0.1 )
end
header()

print("Please fill slot " .. slotComputer .. " with 4 Computers")
while(turtle.getItemCount(slotComputer) < 4) do
	os.sleep( 0.1 )
end
header()

print("Please fill slot " .. slotDiskDrive .. " with 4 Disk Drives")
while(turtle.getItemCount(slotDiskDrive) < 4) do
	os.sleep( 0.1 )
end
header()

print("Please fill slot " .. slotModem .. " with 4 Modems")
while(turtle.getItemCount(slotModem) < 4) do
	os.sleep( 0.1 )
end
header()

print("Please fill slot " .. slotCobblestone .. " with 4 Cobblestone")
while(turtle.getItemCount(slotCobblestone) < 4) do
	os.sleep( 0.1 )
end
header()

print("Please fill slot " .. slotWall .. " with 34 walls")
while(turtle.getItemCount(slotWall) < 34) do
	os.sleep( 0.1 )
end
header()

print("Please fill slot " .. slotFloppy1 .. " with a floppy")
while(turtle.getItemCount(slotFloppy1) < 1) do
	os.sleep( 0.1 )
end
header()

print("Please fill slot " .. slotFloppy2 .. " with a floppy")
while(turtle.getItemCount(slotFloppy2) < 1) do
	os.sleep( 0.1 )
end
header()

print("Please fill slot " .. slotFloppy3 .. " with a floppy")
while(turtle.getItemCount(slotFloppy3) < 1) do
	os.sleep( 0.1 )
end
header()

print("Please fill slot " .. slotFloppy4 .. " with a floppy")
while(turtle.getItemCount(slotFloppy4) < 1) do
	os.sleep( 0.1 )
end
header()

print("Please fill slot " .. slotLight .. " with 4 Redstone Lamps")
while(turtle.getItemCount(slotLight) < 4) do
	os.sleep( 0.1 )
end
header()

print("Please fill slot " .. slotTorch .. " with 8 Torchs")
while(turtle.getItemCount(slotTorch) < 8) do
	os.sleep( 0.1 )
end
header()

print("All Items Acounted For!")

-- Enter posisioning phase
local posX, posY, posZ, posF = common.getTurtlePos( headerText )

sm.setCoords(posX, posY, posZ, posF)

-- Enter confermation phase
header()
print("Are you sure your ready to build (y/n)?")

kill = false
waitingConfermation = true

kill = (common.standardConfermaion() == false)
--[[
while waitingConfermation == true do
	event, param1, param2 = os.pullEvent("char")
	if param1 == "y" then
		waitingConfermation = false
	elseif param1 == "n" then
		waitingConfermation = false
		kill = true
	end
end
]]


function buildSatellite()

	local startPosX, startPosY, startPosZ, startPosF = sm.getX(), sm.getY(), sm.getZ(), sm.getDir()

	--sm.moveTo(startPosX - 6, startPosY, startPosZ, 3)

	for i = 0,10 do
		sm.moveTo(startPosX - 5 + i, startPosY+1, startPosZ, 3)
		turtle.select(slotWall)
		turtle.placeDown()
	end
	-- Place first node
	-- Place Computer
	sm.moveTo(startPosX + 6, startPosY, startPosZ, 3)
	t.select(slotComputer)
	t.place()
	-- Place DiskDrive
	sm.moveTo(startPosX + 6, startPosY-1, startPosZ, 3)
	t.select(slotDiskDrive)
	t.place()
	-- Place Cobblestone Block
	sm.moveTo(startPosX + 6, startPosY+1, startPosZ, 3)
	t.select(slotCobblestone)
	t.placeDown()
	-- Place Torch on cobble Block
	sm.moveTo(startPosX + 6, startPosY+1, startPosZ + 1, 3)
	t.select(slotTorch)
	t.placeDown()
	-- Place Torch on cobble Block
	sm.moveTo(startPosX + 6, startPosY+1, startPosZ - 1, 3)
	t.select(slotTorch)
	t.placeDown()
	-- Place Modem
	sm.moveTo(startPosX + 7, startPosY+2, startPosZ, 3)
	t.select(slotModem)
	t.placeDown()
	-- Place Redstone Lamp
	sm.moveTo(startPosX + 8, startPosY, startPosZ+1, 2)
	t.select(slotLight)
	t.place()

	-- Turn on computer
	sm.moveTo(startPosX + 7, startPosY, startPosZ+1, 2)
	computer = peripheral.wrap("front")
	sleep(0.5)
	if computer then
		computer.turnOn()
	end


	-- Place second node
	-- Place Computer
	sm.moveTo(startPosX - 6, startPosY, startPosZ, 1)
	t.select(slotComputer)
	t.place()
	-- Place DiskDrive
	sm.moveTo(startPosX - 6, startPosY-1, startPosZ, 1)
	t.select(slotDiskDrive)
	t.place()
	-- Place Cobblestone Block
	sm.moveTo(startPosX - 6, startPosY+1, startPosZ, 1)
	t.select(slotCobblestone)
	t.placeDown()
	-- Place Torch on cobble Block
	sm.moveTo(startPosX - 6, startPosY+1, startPosZ + 1, 1)
	t.select(slotTorch)
	t.placeDown()
	-- Place Torch on cobble Block
	sm.moveTo(startPosX - 6, startPosY+1, startPosZ - 1, 1)
	t.select(slotTorch)
	t.placeDown()
	-- Place Modem
	sm.moveTo(startPosX - 7, startPosY+2, startPosZ, 1)
	t.select(slotModem)
	t.placeDown()
	-- Place Redstone Lamp
	sm.moveTo(startPosX - 8, startPosY, startPosZ+1, 2)
	t.select(slotLight)
	t.place()

	-- Turn on computer
	sm.moveTo(startPosX - 7, startPosY, startPosZ+1, 2)
	computer = peripheral.wrap("front")
	sleep(0.5)
	if computer then
		computer.turnOn()
	end

	-- Place Spire
	for i = 1,7 do
		sm.moveTo(startPosX, startPosY+i, startPosZ, 3)
		turtle.select(slotWall)
		turtle.placeDown()
	end

	-- Place Top Bar
	for i = 0,10 do
		sm.moveTo(startPosX, startPosY+1+7, startPosZ - 5 + i, 0)
		turtle.select(slotWall)
		turtle.placeDown()
	end

	-- Place third node
	-- Place Computer
	sm.moveTo(startPosX, startPosY+7, startPosZ + 6, 0)
	t.select(slotComputer)
	t.place()
	-- Place DiskDrive
	sm.moveTo(startPosX, startPosY+7-1, startPosZ + 6, 0)
	t.select(slotDiskDrive)
	t.place()
	-- Place Cobblestone Block
	sm.moveTo(startPosX, startPosY+7+1, startPosZ + 6, 0)
	t.select(slotCobblestone)
	t.placeDown()
	-- Place Torch on cobble Block
	sm.moveTo(startPosX + 1, startPosY+7+1, startPosZ + 6, 0)
	t.select(slotTorch)
	t.placeDown()
	-- Place Torch on cobble Block
	sm.moveTo(startPosX - 1, startPosY+7+1, startPosZ + 6, 0)
	t.select(slotTorch)
	t.placeDown()
	-- Place Modem
	sm.moveTo(startPosX, startPosY+7+2, startPosZ + 7, 0)
	t.select(slotModem)
	t.placeDown()
	-- Place Redstone Lamp
	sm.moveTo(startPosX+1, startPosY+7, startPosZ + 8, 1)
	t.select(slotLight)
	t.place()

	-- Turn on computer
	sm.moveTo(startPosX+1, startPosY+7, startPosZ + 7, 1)
	computer = peripheral.wrap("front")
	sleep(0.5)
	if computer then
		computer.turnOn()
	end


	-- Place forth node
	-- Place Computer
	sm.moveTo(startPosX, startPosY+7, startPosZ - 6, 2)
	t.select(slotComputer)
	t.place()
	-- Place DiskDrive
	sm.moveTo(startPosX, startPosY+7-1, startPosZ - 6, 2)
	t.select(slotDiskDrive)
	t.place()
	-- Place Cobblestone Block
	sm.moveTo(startPosX, startPosY+7+1, startPosZ - 6, 2)
	t.select(slotCobblestone)
	t.placeDown()
	-- Place Torch on cobble Block
	sm.moveTo(startPosX + 1, startPosY+7+1, startPosZ - 6, 0)
	t.select(slotTorch)
	t.placeDown()
	-- Place Torch on cobble Block
	sm.moveTo(startPosX - 1, startPosY+7+1, startPosZ - 6, 0)
	t.select(slotTorch)
	t.placeDown()
	-- Place Modem
	sm.moveTo(startPosX, startPosY+7+2, startPosZ - 7, 2)
	t.select(slotModem)
	t.placeDown()
	-- Place Redstone Lamp
	sm.moveTo(startPosX+1, startPosY+7, startPosZ - 8, 1)
	t.select(slotLight)
	t.place()

	-- Turn on computer
	sm.moveTo(startPosX+1, startPosY+7, startPosZ - 7, 1)
	computer = peripheral.wrap("front")
	sleep(0.5)
	if computer then
		computer.turnOn()
	end


	-- Move to Clear Location
	sm.moveTo(startPosX + 2, startPosY-1, startPosZ+2, 1)
end

if kill == true then
	write("Exiting...\n")
else
	write("Running...\n")
	--sm.up()
	local startPosX, startPosY, startPosZ, startPosF = sm.getX(), sm.getY(), sm.getZ(), sm.getDir()
	sm.moveTo(startPosX, startPosY+2, startPosZ, 0)
	sleep(1)
	sm.moveTo(startPosX, 200, startPosZ, 0)
	buildSatellite()
	sleep(2)
	sm.moveTo(startPosX, startPosY+2, startPosZ, 0)
	sm.moveTo(startPosX, startPosY, startPosZ, sm.getDir())
	print("Done")
end