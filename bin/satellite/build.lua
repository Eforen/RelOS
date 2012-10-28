local tArgs = { ... }
if #tArgs < 4 then
  print("Usage : satelite <x> <y> <z> <f>")
  return
end
local Xpos = tonumber(tArgs[1])
local Ypos = tonumber(tArgs[2])
local Zpos = tonumber(tArgs[3])
local facing = tonumber(tArgs[4])

function buildUp(floppySlot)
  -- Put the disk drive
  turtle.select(3)
  turtle.place()
  -- Load disk into drive and write startup file
  turtle.select(floppySlot)
  turtle.drop()
  file = fs.open("disk/startup","w")
  file.writeLine("shell.run(\"gps\",\"host\","..Xpos..","..Ypos..","..Zpos..")")
  file.close()
  -- put the computer
  turtle.up()
  turtle.select(2)
  turtle.place()
  -- place the modem
  turtle.up()
  turtle.up()
  turtle.forward()
  turtle.select(4)
  turtle.placeDown()
  turtle.back()
  turtle.down()
  turtle.down()
  -- turn computer on
  computer = peripheral.wrap("front")
  sleep(0.5)
  if computer then
    computer.turnOn()
  end
  turtle.down()
end

if type(Xpos) ~= "number" then
  print("x must be number")
  return
end
if type(Ypos) ~= "number" then
  print("y must be number")
  return
end
if type(Zpos) ~= "number" then
  print("z must be number")
  return
end
if type(facing) ~= "number" then
  print("facing must be number")
  return
end
print("Please fill up following slots")
print("1 = Fuel")
print("2 = Computer (4x)")
print("3 = Disk drive (4x)")
print("4 = Modem (4x)")
print("5 - 8 = Floppy disk (4x)")
print("Press any key to continue")
while true do
  event, param1 = os.pullEvent()
  if event == "char" then
    break
  end
end
while turtle.getItemCount(1) > 0 do
  turtle.refuel()
end
print("Fuel level is "..turtle.getFuelLevel())
print("Going up to 100 meter to build satelite")
for height = 1, 100, 1 do
  turtle.up()
end
Ypos = Ypos + 101
-- Go 10 forward to set the first computer
for c = 1, 10, 1 do
  turtle.forward()
end
if facing == 0 then
  Zpos = Zpos + 11
end
if facing == 2 then
  Zpos = Zpos - 11
end
if facing == 1 then
  Xpos = Xpos - 11
end
if facing == 3 then
  Xpos = Xpos + 11
end
buildUp(5)
-- Go back 20 and put the second computer
turtle.turnRight()
turtle.turnRight()
if facing == 0 then
  facing = 2
elseif facing == 1 then
  facing = 3
elseif facing == 2 then
  facing = 0
elseif facing == 3 then
  facing = 1
end
for c = 1, 20, 1 do
  turtle.forward()
end
if facing == 0 then
  Zpos = Zpos + 22
end
if facing == 2 then
  Zpos = Zpos - 22
end
if facing == 1 then
  Xpos = Xpos - 22
end
if facing == 3 then
  Xpos = Xpos + 22
end
buildUp(6)
-- go 10 forward to the middle
turtle.turnRight()
turtle.turnRight()
if facing == 0 then
  facing = 2
elseif facing == 1 then
  facing = 3
elseif facing == 2 then
  facing = 0
elseif facing == 3 then
  facing = 1
end
for c = 1, 10, 1 do
  turtle.forward()
end
if facing == 0 then
  Zpos = Zpos + 11
end
if facing == 2 then
  Zpos = Zpos - 11
end
if facing == 1 then
  Xpos = Xpos - 11
end
if facing == 3 then
  Xpos = Xpos + 11
end
-- and 10 more up
for c = 1, 10, 1 do
  turtle.up()
end
Ypos = Ypos + 10
-- turn 90 degree to setup the second row
turtle.turnRight()
facing = facing + 1
if facing == 4 then
  facing = 0
end
-- Go 10 forward to set the third computer
for c = 1, 10, 1 do
  turtle.forward()
end
if facing == 0 then
  Zpos = Zpos + 11
end
if facing == 2 then
  Zpos = Zpos - 11
end
if facing == 1 then
  Xpos = Xpos - 11
end
if facing == 3 then
  Xpos = Xpos + 11
end
buildUp(7)
-- Go back 20 and put the last computer
turtle.turnRight()
turtle.turnRight()
if facing == 0 then
  facing = 2
elseif facing == 1 then
  facing = 3
elseif facing == 2 then
  facing = 0
elseif facing == 3 then
  facing = 1
end
for c = 1, 20, 1 do
  turtle.forward()
end
if facing == 0 then
  Zpos = Zpos + 22
end
if facing == 2 then
  Zpos = Zpos - 22
end
if facing == 1 then
  Xpos = Xpos - 22
end
if facing == 3 then
  Xpos = Xpos + 22
end
buildUp(8)
-- go 10 forward to the middle
turtle.turnRight()
turtle.turnRight()
for c = 1, 10, 1 do
  turtle.forward()
end
-- and back to earth
while not turtle.detectDown() do
  turtle.down()
end