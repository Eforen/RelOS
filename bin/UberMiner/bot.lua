os.loadAPI('UberMiner/lib/config')
os.loadAPI('UberMiner/lib/gui')
os.loadAPI('UberMiner/lib/vector')


function f()
	--if not turtle.detect() then turtle.forward() end
	if not turtle.forward() then
		write("Failed Move Forward")
		while not turtle.forward() do
			write("Failed Move Forward Agean Sleeping")
			sleep(1)
		end
	end
end
function b()
	if not turtle.back() then
		write("Failed Move Back")
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
	print('UberMiner v' .. toString(version()))
end

function makeSideShaft(torchMiddle, depth)
	if torchMiddle and not turtle.detectDown() then
		pd(9)
	end
	tr()

	term.clear()
	term.setCursorPos( 1, 1 )
	version()
	botStatus = {'Strip Mine','SideShaft'}
	status()

	write("Right Shaft depth ")
	for i=1,depth do
		x, y = term.getCursorPos()
		term.setCursorPos(x-string.len(tostring(y-1)),y)
		write(i)
		if i%5 == 0 then 
			pd(9)
		end
		hallStep()
	end
	ta()

	term.clear()
	term.setCursorPos( 1, 1 )
	version()
	status()

	write("Right Shaft depth ")
	for i=1,depth do
		x, y = term.getCursorPos()
		term.setCursorPos(x-string.len(tostring(y-1)),y)
		write(i)
		f()
	end
	-- I should be at center!

	term.clear()
	term.setCursorPos( 1, 1 )
	version()
	status()
	
	write("Left Shaft depth ")
	for i=1,depth do
		x, y = term.getCursorPos()
		term.setCursorPos(x-string.len(tostring(y-1)),y)
		write(i)
		if i%5 == 0 then 
			pd(9)
		end
		hallStep()
	end
	ta()

	term.clear()
	term.setCursorPos( 1, 1 )
	version()
	status()
	
	write("Left Shaft depth ")
	for i=1,depth do
		x, y = term.getCursorPos()
		term.setCursorPos(x-string.len(tostring(y-1)),y)
		write(i)
		f()
	end
	tl()
end

function hallStep()
	--checkInvAll()


	if turtle.detect() then
		dig()
		f()
		checkHoles()
	else
		f()
	end


	--digBoth()
	if turtle.detectDown() then
		digDown()
		d()
		checkHolesDown()
		u()
	else
		d()
		checkHoleDown()
		u()
	end


	if turtle.detectUp() then
		digUp()
		u()
		checkHoles()
	else
		u()
	end


	if turtle.detectUp() then
		digUp()
		u()
		checkHoles()
	else
		u()
	end


	if turtle.detectUp() then
		digUp()
		u()
		checkHolesUp()
	else
		u()
		checkHoleUp()
	end

	d()
	d()
	d()
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
	end
	if not turtle.detectDown() then
		pd(1)
	else
		turtle.select(9)
		if turtle.compare() then
			d()
			p(1)
		end
	end
end
function checkInv(slot)
	turtle.select( slot )
	if turtle.compareTo( 1 ) then
		turtle.drop()
	end
end
function checkInvAll()
	checkInv(2)
	checkInv(3)
	checkInv(4)
	checkInv(5)
	checkInv(6)
	checkInv(7)
	checkInv(8)
end

function runNormal()
	term.clear()
	term.setCursorPos( 1, 1 )
	version()
	botStatus = {'Strip Mine','Setup'}
	status()

	write('Side Shafts to Skip: ')
	Skips = tonumber(read())

	write('Side Shaft Depths: ')
	ShaftDepths = tonumber(read())

	write('Depth: ')
	Depth = tonumber(read())

	digUp()
	u()

	if Skips > 0 then
		for y=1,Skips do
			term.clear()
			term.setCursorPos( 1, 1 )
			version()
			botStatus = {'Strip Mine','Skipping'}
			status()
			write("Skipping.")
			for i=1,3 do
				write(".")
				if turtle.detect() then
					dig()
					f()
					checkHolesAll()
				else
					f()
				end
			end
		end
	end

	for y=1,Depth do
		term.clear()
		term.setCursorPos( 1, 1 )
		version()
		botStatus = {'Strip Mine','Hallway'}
		status()
		write("Hall Step ")
		for i=1,3 do
			x, y = term.getCursorPos()
			term.setCursorPos(x-string.len(tostring(y-1)),y)
			write(i)
			hallStep()
		end
		print("")

		makeSideShaft(true,ShaftDepths)
	end

	for y=1,Depth+Skips do
		term.clear()
		term.setCursorPos( 1, 1 )
		version()
		botStatus = {'Strip Mine','Returning'}
		status()
		write("Returning.")
		for i=1,3 do
			write(".")
			b()
		end
	end
	d()
end

function hallwayStep(torch, right)
	--checkInvAll()


	if turtle.detect() then
		dig()
		f()
		checkHolesDown()
	else
		f()
	end


	--digBoth()
	if turtle.detectUp() then
		digUp()
		u()
		checkHoles()
	else
		u()
	end

	if torch==true and right == true then
		tr()
		if turtle.detect() then
			dig()
			f()
			checkHolesUp()
		else
			f()
		end
		p(9)
		b()
		tl()
	end

	if turtle.detectUp() then
		digUp()
		u()
		checkHolesUp()
	else
		u()
	end

	tl() --turn to do left side

	if turtle.detect() then
		dig()
	end
	f()
	checkHole()
	tr()
	checkHole()

	if not turtle.detectUp() then
		pu(1)
	end

	if turtle.detectDown() then
		digDown()
	end
	d()
	checkHole()
	tl()
	checkHole()

	if torch==true and right == true then
		tl()
		if turtle.detect() then
			dig()
			f()
			checkHolesUp()
		else
			f()
		end
		p(9)
		b()
		tr()
	end

	if turtle.detectDown() then
		digDown()
	end
	d()
	checkHole()
	tr()
	checkHole()

	r()
end

function runHallway()
	term.clear()
	term.setCursorPos( 1, 1 )
	version()
	botStatus = {'Hallway','Setup'}
	status()

	write('Place torch every: ')
	torchSep = tonumber(read())

	write('Depth: ')
	Depth = tonumber(read())

	torchRight=true
	--for y do
		term.clear()
		term.setCursorPos( 1, 1 )
		version()
		botStatus = {'Hallway','Hallway'}
		status()
		write("Hall Step ")
		for i=1,Depth do
			x, y = term.getCursorPos()
			term.setCursorPos(x-string.len(tostring(y-1)),y)
			write(i)
			hallwayStep((y%torchSep==0), torchRight)
			if y%torchSep==0 then torchRight = not torchRight end
		end
		print("")
	--end

	for y=1,Depth+Skips do
		term.clear()
		term.setCursorPos( 1, 1 )
		version()
		botStatus = {'Hallway','Returning'}
		status()
		write("Returning.")
		for i=1,3 do
			write(".")
			b()
		end
	end
end

function runTestCom()
	f()
	sleep(5)
end


-- global vars
botArray = {-1, -1, -1, -1}
botStatus = {'Docked','Idle'}
botID = -1
dock = vector.vector()
mode = 0
-- Modes:
-- 0 - dig
-- 1 - place

-- # NOTE: Fleet IDs and dock location are not permanent! You may wish to remove the exit option from the menu list.
-- GUI items
menulist = {
	'Setup Mine',
	'Mine Hallway',
	'Read droid ID',
	'Change docking coordinates',
	'Assume direct control',
	'Callibrate droid',
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

-- Direct control via keyboard
function controlLoop()
	local bot = -1
	while true do
		bot = whichBot()
		if botArray[bot] ~= -1 then break end
	end
	botID = botArray[bot]
	mode = 0 -- set the mode to dig
	gui.bbox(1,10,47,8)
	gui.text(3,11,'Assuming direct control.')
	while true do
		event, key = os.pullEvent() 
		gui.bbox(1,10,47,8)
		gui.text(3,11,'Assuming direct control.')
		if key == 203 then -- left
			rednet.send(botID, 'left')
			gui.text(3,12,'Left')
		elseif key == 200 then -- up
			rednet.send(botID, 'up')
			gui.text(3,12,'Forward')
		elseif key == 205 then -- right
			rednet.send(botID, 'right')
			gui.text(3,12,'Right')
		elseif key == 'a' then -- if A - ascend
			rednet.send(botID, 'asc')
			gui.text(3,12,'Up.')
		elseif key == 'z' then -- if Z - descend
			rednet.send(botID, 'desc')
			gui.text(3,12,'Down.')
		elseif key == 57 then -- issued special command (spacebar)
			if mode == 0 then -- dig mode
				rednet.send(botID, 'dig')
				gui.text(3,12,'Dig')
			elseif mode == 1 then -- place mode 
				rednet.send(botID, 'place')
				gui.text(3,12,'Place')
			end
		elseif key == 2 then -- set to dig mode (pressed 1)
			mode = 0
			gui.text(3,12,'Dig mode selected.') --write it
		elseif key == 3 then  -- set to place mode (pressed 2)
			mode = 1
			gui.text(3,12,'Place mode selected.')
		elseif key == 157 then -- rs signal (right ctrl key)
			rednet.send(botID, 'rs')
			gui.text(3,12,'Redstone activated.')
		elseif key == '0' then -- exit
			return
		end
		gui.text(3,14,'Press 0 to return to menu')
	end
end

-- main loop
function main()
	rednet.open('right')
	screen()
	while true do
		event, key, text = os.pullEvent()
		if event == 'key' then
			local result = cmenu:input(event, key)
			if result == 1 then
				-- Test Droid
				--targetID()
				runNormal()
			elseif result == 2 then
				-- change docking location
				runHallway()
			elseif result == 3 then
				-- assume direct control
				controlLoop()
			elseif result == 4 then
				-- send callibration data
				--callibrate()
			elseif result == 5 then
				-- Read droid ID
			elseif result == 7 then os.reboot() -- update
			elseif result == 8 then os.shutdown() -- turn off
			elseif result == 9 then runTestCom() -- For testing new stuff
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