--os.loadAPI('/TreeBot/lib/gui')
--os.loadAPI('/TreeBot/lib/smartmove')
sm = smartmove

dropOffPoint = {117,100,228,1}

function dropOff()
	sm.moveTo(dropOffPoint[1], dropOffPoint[2], dropOffPoint[3], dropOffPoint[4])
	for i=4,9 do
		turtle.select(i)
		turtle.drop(5)
		sleep(0.5)
	end
end
--smartmove.initCoords()
sm.setCoords(115, 100, 230, 0)
sm.moveTo(112, 101, 228, 1)
sleep(1)
sm.moveTo(106, 93, 242, 0)
turtle.digDown()
sm.moveTo(116, 101, 226, 1)
while turtle.getItemCount( 1 ) > 0 do
	sleep(1)
end
--sm.moveTo(115, 100, 230, 0)

--sm.up()
--sm.moveTo(112, 101, 228, 1)
--sleep(1)
--sm.moveTo(106, 92, 242, 1)
--sleep(3)
--sm.moveTo(112, 101, 228, 3)
--dropOff()
--sleep(1)
sm.moveTo(115, 100, 230, 0)