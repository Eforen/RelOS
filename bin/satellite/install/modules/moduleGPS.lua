local x,y,z
local nServed = 0
local status = "Not Started..."

function setup( posx, posy, posz)
	x,y,z = posx, posy, posz
	status = "Serving GPS requests"
end

function loop()
end

function netMsg( senderId, message, distance )
	if message == "PING" then
		rednet.send(sender, textutils.serialize({x,y,z}))
		
		nServed = nServed + 1
		if nServed > 1 then
			local x,y = term.getCursorPos()
			term.setCursorPos(1,y-1)
		end
		print( nServed.." GPS Requests served" )
	end
end

function getStatus()
	return status
end