--os.loadAPI('/TreeBot/lib/gui')
--os.loadAPI('/TreeBot/lib/smartmove')
sm = smartmove

posOut = 296, 81, 418
posIn = 296, 79, 416
posJunction = 296, 79, 418
posChest = 298, 79, 418
posDock = 291, 82, 422
posFirstTreeBase = 286, 71, 379
posRestPoint = 283, 71, 382

--smartmove.initCoords()
pos = gps.locate()
if pos ~= nil then
	write("GPS Failed")
else
	turtle.refuel(1)
	sm.setCoords(pos, 0)
	sm.up()
	sm.moveTo(posOut, 1)
	sleep(1)
	--sm.moveTo(106, 92, 242, 1)
	--sleep(3)
	--sm.moveTo(112, 101, 228, 3)
	--sleep(1)
	sm.moveTo(posDock, 0)
end