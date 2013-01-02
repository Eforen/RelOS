os.loadAPI("/SatelliteSettings")
os.loadAPI("/modules/moduleGPS")

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
moduleGPS.setup(SatelliteSettings.getPos())
local LightBlinkTimer = os.startTimer(3)
local LightBlinkStep = 0
local LightBlinkStatus = true
local broadcastAliveTimer

while running do
	event, var2, var3 = os.pullEvent()
	if event == 'key' then
	elseif event == 'timer' and var2 == LightBlinkTimer then
		LightBlinkStep=LightBlinkStep+1
		if LightBlinkStep == 0 then
			LightBlinkTimer = os.startTimer(6)
			LightBlinkStatus = false
		elseif LightBlinkStep == 1 then
			LightBlinkTimer = os.startTimer(1)
			LightBlinkStatus = true
		elseif LightBlinkStep == 2 then
			LightBlinkTimer = os.startTimer(1)
			LightBlinkStatus = false
		elseif LightBlinkStep == 3 then
			LightBlinkTimer = os.startTimer(1)
			LightBlinkStatus = true
		elseif LightBlinkStep == 4 then
			LightBlinkTimer = os.startTimer(1)
			LightBlinkStatus = false
		elseif LightBlinkStep == 5 then
			LightBlinkTimer = os.startTimer(1)
			LightBlinkStatus = true
			LightBlinkStep = -1 --Reset
		elseif LightBlinkStep == 6 then
			LightBlinkTimer = os.startTimer(0.25)
			LightBlinkStatus = false
		elseif LightBlinkStep == 7 then
			LightBlinkTimer = os.startTimer(0.25)
			LightBlinkStatus = true
			LightBlinkStep = 0
		end
		redstone.setOutput("front", LightBlinkStatus)
	elseif event == 'timer' and var2 == broadcastAliveTimer then
		broadcastAlive()
	elseif event == 'rednet_message' then
		moduleGPS.netMsg( var2, var3 )
	end
end