local sOpenedSide = nil
local function open()
	local bOpen, sFreeSide = false, nil
	for n,sSide in pairs(rs.getSides()) do	
		if peripheral.getType( sSide ) == "modem" then
			sFreeSide = sSide
			if rednet.isOpen( sSide ) then
				bOpen = true
				break
			end
		end
	end
	
	if not bOpen then
		if sFreeSide then
			print( "No modem active. Opening "..sFreeSide.." modem" )
			rednet.open( sFreeSide )
			sOpenedSide = sFreeSide
			return true
		else
			print( "No modem attached" )
			return false
		end
	end
	return true
end

function close()
	if sOpenedSide then
		rednet.close( sOpenedSide )
	end
end

function broadcastAlive()
	--rednet.br
end

local firstCycle = true
local running = true

open()
local LightBlink = os.startTimer(3)
local LightBlinkStep = 0
local LightBlinkStatus = true

while running do
	event, var2, var3 = os.pullEvent()
	if event == 'key' then
	elseif event == 'timer' then
		LightBlinkStep=LightBlinkStep+1
		if LightBlinkStep == 0 then
			os.startTimer(3)
			LightBlinkStatus = false
		elseif LightBlinkStep == 1 then
			os.startTimer(0.25)
			LightBlinkStatus = true
		elseif LightBlinkStep == 2 then
			os.startTimer(0.25)
			LightBlinkStatus = false
		elseif LightBlinkStep == 3 then
			os.startTimer(0.25)
			LightBlinkStatus = true
		elseif LightBlinkStep == 4 then
			os.startTimer(0.25)
			LightBlinkStatus = false
		elseif LightBlinkStep == 5 then
			os.startTimer(0.25)
			LightBlinkStatus = true
		elseif LightBlinkStep == 6 then
			os.startTimer(0.25)
			LightBlinkStatus = false
		elseif LightBlinkStep == 7 then
			os.startTimer(0.25)
			LightBlinkStatus = true
		end

		redstone.setOutput("front", LightBlinkStatus)

	elseif event == 'rednet_message' then
		senderId, message, distance = rednet.receive(25)
		broadcastAlive()
	end
end