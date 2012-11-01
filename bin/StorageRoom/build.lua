function f()
	--if not turtle.detect() then turtle.forward() end
	if not turtle.forward() then
		write("Failed Move Forward")
		checkFuel()
		while not turtle.forward() do
			write("Failed Move Forward Agean Sleeping")
			sleep(1)
		end
	end
end
function b()
	if not turtle.back() then
		write("Failed Move Back")
		checkFuel()
		while not turtle.back() do
			write("Failed Move Back Agean Sleeping")
			sleep(1)
		end
	end
end
function l()
	tl()
	f()
	tr()
	--turtle.left()
end
function r()
	tr()
	f()
	tl()
	--turtle.right()
end
function u()
	--if not turtle.detectUp() then turtle.up() end
	--turtle.up()
	if not turtle.up() then
		checkFuel()
		write("Failed Move Up")
		while not turtle.up() do
			write("Failed Move Up Agean Sleeping")
			sleep(1)
		end
	end
end
function d()
	--if not turtle.detectDown() then turtle.down() end
	--turtle.down()
	if not turtle.down() then
		checkFuel()
		write("Failed Move Down")
		while not turtle.down() do
			write("Failed Move Down Agean Sleeping")
			sleep(1)
		end
	end
end

function tl()
	turtle.turnLeft()
end
function tr()
	turtle.turnRight()
end
function ta()
	turtle.turnRight()
	turtle.turnRight()
end

function dig()
	while turtle.detect() do
		turtle.dig()
		sleep(1)
	end
end
function digUp()
	while turtle.detectUp() do
		turtle.digUp()
		sleep(1)
	end
end
function digDown()
	while turtle.detectDown() do
		turtle.digDown()
		sleep(1)
	end
end
function digAll()
	dig()
	digUp()
	digDown()
end
function digBoth()
	digUp()
	digDown()
end
function p( slot )
	turtle.select(slot)
	turtle.place()
end
function pu( slot )
	turtle.select(slot)
	turtle.placeUp()
end
function pd( slot )
	turtle.select(slot)
	turtle.placeDown()
end


-- Version info
function version()
	return 0.1
end

function printVersion()
	print('StorageRoomBuilder v' .. toString(version()))
end

function checkHole()
	if not turtle.detect() then
		p(1)
	else
		turtle.select(9)
		if turtle.compare() then
			dig()
			p(1)
		end
		turtle.select(1)
	end
end
function checkHoles()
	checkHole()
	tr()
	checkHole()
	ta()
	checkHole()
	tr()
end
function checkHolesUp()
	checkHoleUp()
	checkHoles()
end
function checkHolesDown()
	checkHoleDown()
	checkHoles()
end
function checkHoleUp()
	if not turtle.detectUp() then
		pu(1)
	else
		turtle.select(9)
		if turtle.compareUp() then
			digUp()
			p(1)
		end
		turtle.select(1)
	end
end
function checkHoleDown()
	if not turtle.detectDown() then
		pd(1)
	else
		turtle.select(9)
		if turtle.compareDown() then
			digDown()
			p(1)
		end
		turtle.select(1)
	end
end
function checkHolesAll()
	checkHoles()
	if not turtle.detectUp() then
		pu(1)
	else
		turtle.select(9)
		if turtle.compare() then
			d()
			p(1)
		end
		turtle.select(1)
	end
	if not turtle.detectDown() then
		pd(1)
	else
		turtle.select(9)
		if turtle.compare() then
			d()
			p(1)
		end
		turtle.select(1)
	end
end
function checkInv(slot)
	turtle.select( slot )
	if turtle.compareTo( 1 ) then
		turtle.drop()
	end
end

function checkFuel()
	write("Debug: checkFuel(); \n")
	if (turtle.getFuelLevel()<=0) then
		write("Debug: refueling... \n")
		turtle.select(fualSlot)
		turtle.refuel(1)
	end
end

-- Do StorageRoom Stuff

local width, height, depth, torchheight, torchspace = 5, 4, 20, 3, 5

local insetChest = false

function setup()
	term.clear()
	-- body
	textutils.slowWrite("Enter width (" .. width .. "): ")
	width = common.getInput(width)
	textutils.slowWrite("Enter height (" .. height .. "): ")
	height = common.getInput(height)
	textutils.slowWrite("Enter depth (" .. depth .. "): ")
	depth = common.getInput(depth)
	textutils.slowWrite("Enter torchheight (" .. torchheight .. "): ")
	torchheight = common.getInput(torchheight)
	textutils.slowWrite("Enter torchspace (" .. torchspace .. "): ")
	torchspace = common.getInput(torchspace)
end

function build()
	-- body
end

-- End Storage Room Stuff

-- global vars
botArray = {-1, -1, -1, -1}
botStatus = {'Docked','Idle'}
botID = -1
dock = vector.vector()
mode = 0
fualSlot = 16
signSlot = 15
-- Modes:
-- 0 - dig
-- 1 - place

-- # NOTE: Fleet IDs and dock location are not permanent! You may wish to remove the exit option from the menu list.
-- GUI items
menulist = {
	'Setup',
	'Build',
	'Update Firmware',
	'Turn Off',
	'Test Command'
}
cmenu = gui.clist.create(3,4,menulist)

-- startup screen
function screen()
	term.clear()
	term.setCursorPos( 1, 1 )
	version()
	status()
	menu()
end

-- display command options
function menu()
	cmenu:out(term)
end

function status()
	--gui.box(term,1,10,36,8)
	gui.box(term,1,1,11,3) -- Status Box Label --
	gui.box(term,11,1,26,3)
	--gui.box(term,30,5,18,6)
	term.setCursorPos( 2, 2 )
	term.write('Status:')
	-- Print droid status
	di = 1
	term.setCursorPos( 12, 2 )
	term.write('[' .. botStatus[1] .. '] ' .. botStatus[2])
	-- Print dock location

	-- Return cursor
	term.setCursorPos( 1, 4 )
end

-- main loop
function main()
	rednet.open('right')
	screen()
	while true do
		event, key, text = os.pullEvent()
		if event == 'key' then
			local result = cmenu:input(event, key)
			if result == 1 then	setup()
			elseif result == 2 then build() -- build room
			elseif result == 3 then os.reboot() -- update
			elseif result == 4 then os.shutdown() -- turn off
			elseif result == 5 then runTestCom() -- For testing new stuff
			end
			-- update the status screen
			screen()
		elseif event == 'rednet_message' then
			-- Handle status reports
			local di = 1
			while di <= 4 do
				if key == botArray[di] then botStatus[di] = text end
				di=di+1
			end
			screen()
		end
	end
	shell.run('clear')
	rednet.close('right')
end

main()