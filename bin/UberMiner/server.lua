-- SmartMine server software v0.43
-- v0.43
-- - interface now uses cList object for graphical navigation with keyboard.
-- v0.4
-- - 


os.loadAPI('UberMiner/lib/config')
os.loadAPI('UberMiner/lib/vector')
os.loadAPI('UberMiner/lib/gui')


-- Version info
function version()
	print('Droid Control v0.43')
end


-- global vars
botArray = {-1, -1, -1, -1}
botStatus = {'Idle', 'Idle', 'Idle', 'Idle'}
botID = -1
--dock = vector.vector()
dock = {0,0,0,0}
mode = 0
-- Modes:
-- 0 - dig
-- 1 - place


-- # NOTE: Fleet IDs and dock location are not permanent! You may wish to remove the exit option from the menu list.
-- GUI items
menulist = {
	'Change droid ID',
	'Change docking coordinates',
	'Assume direct control',
	'Callibrate droid',
	'Mining operations',
	'Exit'
}
cmenu = gui.clist.create(3,11,menulist)

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
	cmenu:out()
end

function status()
	gui.box(1,10,47,8)
	gui.box(1,3,30,3)
	gui.box(1,5,30,6)
	gui.box(30,3,18,3)
	gui.box(30,5,18,6)
	term.setCursorPos( 3, 4 )
	term.write('Status:')
	-- Print droid status
	di = 1
	while di <= 4 do
		term.setCursorPos( 4, 5+di )
		term.write(di .. '.[')
		if botArray[di] == -1 then term.write('N/A]')
		else
			term.write(botArray[di] .. '] - ' .. botStatus[di])
		end
		di=di+1
	end
	-- Print dock location
	term.setCursorPos( 32, 4 )
	term.write('Dock location:')
	term.setCursorPos( 37, 6 )
	term.write('X: ')
	term.write(dock.x)
	term.setCursorPos( 37, 7 )
	term.write('Y: ')
	term.write(dock.y)
	term.setCursorPos( 37, 8 )
	term.write('Z: ')
	term.write(dock.z)
	term.setCursorPos( 32, 9 )
	term.write('Facing: ')
	term.write(dock.dir)

	-- Return cursor
	term.setCursorPos( 1, 12 )
end

-- Select bot to operate
function whichBot()
	local botList = {}
	local di = 1
	while di <= 4 do
		botList[di] = di .. '.['
		if botArray[di] == -1 then botList[di] = di..'.[N/A]'
		else
			botList[di] = di..'.['..botArray[di]..'] - '..botStatus[di]
		end
		di=di+1
	end
	local botmenu = gui.clist.create(2,6,botList)
	gui.bbox(1,5,30,6)
	botmenu:out()
	
	local result = nil
	while true do
		event, key = os.pullEvent()
		if event == 'key' then
			result = botmenu:input(event, key)
			if result ~= nil then return result end
		end
		gui.bbox(1,5,30,6)
		botmenu:out()
	end
end

function targetID()
	local bot = whichBot()
	gui.bbox(1,10,47,8)
	gui.text(3,11,'Enter target droid ID: ')
	botArray[bot] = tonumber(read()) -- ask for the new ID of the turtle
end

function setDock()
	gui.bbox(1,10,47,8)
	gui.text(3,11,'     Dock X: ')
	dock.x = tonumber(read())
	gui.box(1,10,47,8)
	gui.text(3,12,'     Dock Y: ')
	dock.y = tonumber(read())
	gui.box(1,10,47,8)
	gui.text(3,13,'     Dock Z: ')
	dock.z = tonumber(read())
	gui.box(1,10,47,8)
	gui.text(3,14,'Dock Facing: ')
	dock.dir = tonumber(read())
end

function callibrate()
	local bot = -1
	while true do
		bot = whichBot()
		if botArray[bot] ~= -1 then break end
	end
	gui.bbox(1,10,47,8)
	gui.text(3,11,'Callibrating...')
	rednet.send(botArray[bot],'setx ' .. dock.x)
	rednet.send(botArray[bot],'sety ' .. dock.y)
	rednet.send(botArray[bot],'setz ' .. dock.z)
	rednet.send(botArray[bot],'setd ' .. dock.dir)
	gui.text(3,13,'Press spacebar to cancel.')
	getReply(bot)
end

-- Wait for bot confirmation (can be cancelled locally)
function getReply(bot)
	while true do
		event, key, text = os.pullEvent()
		if event == 'rednet_message' and key == botArray[bot] then
			botStatus[bot] = text
			break
		elseif event == 'char' and key == ' ' then break
		end
	end
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

-- Mining operations
function mineConfig()
	local bot = -1
	while true do
		bot = whichBot()
		if botArray[bot] ~= -1 then break end
	end
	
	-- Input target
	while true do
		gui.bbox(1,10,47,8)
		
		gui.text(3,11,'Starting X: ')
		local minex = tonumber(read())
		gui.box(1,10,47,8)
		
		gui.text(3,12,'Starting Y: ')
		local miney = tonumber(read())
		gui.box(1,10,47,8)
		
		gui.text(3,13,'Starting Z: ')
		local minez = tonumber(read())
		gui.box(1,10,47,8)
		
		gui.text(30,11,'Width: ')
		local minew = tonumber(read())
		gui.box(1,10,47,8)
		
		gui.text(29,12,'Length: ')
		local minel = tonumber(read())
		gui.box(1,10,47,8)
		
		gui.text(26,13,'Max depth: ')
		local mined = tonumber(read())
		gui.box(1,10,47,8)
		
		-- Make sure our coordinates are entered correctly
		gui.text(3,15,'Confirm coordinates for Droid#'..bot..'? (y/n) ')
		if read() == 'y' then
			rednet.send(botArray[bot],'minex ' .. minex)
			rednet.send(botArray[bot],'miney ' .. miney)
			rednet.send(botArray[bot],'minez ' .. minez)
			rednet.send(botArray[bot],'minew ' .. minew)
			rednet.send(botArray[bot],'minel ' .. minel)
			rednet.send(botArray[bot],'mined ' .. mined)
			
			gui.box(1,10,47,8)
			gui.text(3,16,'Press spacebar to cancel.')
			getReply(bot)
			break
		else
			-- Ask for new input
			gui.box(1,10,47,8)
			gui.text(3,16,'Enter new? (y/n) ')
			if read() == 'n' then break end
		end
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
				-- change target droid ID
				targetID()
			elseif result == 2 then
				-- change docking location
				setDock()
			elseif result == 3 then
				-- assume direct control
				controlLoop()
			elseif result == 4 then
				-- send callibration data
				callibrate()
			elseif result == 5 then
				-- configure mining ops
				mineConfig()
			elseif result == 6 then break -- exit
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