--os.loadAPI('UberMiner/lib/vector')
--os.loadAPI('/MonSrv/lib/serialize')

os.pullEvent = os.pullEventRaw
term.clear()
term.setCursorPos(1,1)
print("This is a monitor server. There is no user interaction here.")
print("Please find a computer.")   
local firstCycle = true
local validSender = false
local modemSide = "front" -- change to the side of the computer your modem is on
local monitorSide = "top" -- change to the side of the computer your modem is on
local valid = false
local mon
senders = {}
senders = { 81 } -- computer ID's of the computers you want to accept requests from
--[[ command modeds
 -1 - Restart Monitor Server
  0 - {x, y, string} prints the string at x, y
  1 - {msg} Write msg to the MonitorServer screen.
  2 - {n} Scrolls Y Lines.
  3 - {x, y} sets cursor posistion to x, y.
  4 - {boolean} Enables or disables cursor blinking.
  5 - [Not Implimented] Returns {x, y} arguments containing the x and the y position of the cursor on the Monitor.
  6 - [Not Implimented] Returns {x, y} arguments containing the x and the y values stating the size of the Monitor.
  7 - Clears the Monitor.
  8 - {line} Clears the line the cursor is on.
  9 - {scale} Set Text Scale
]]--

local typeArgs = {{-1,0},{0,3},{1,1},{2,1},{3,2},{4,1},{5,2},{6,2},{7,0},{8,1},{9,1}}
--[[
local typeArgs = {}
typeArgs[1]={-1,0}
typeArgs[02]={0,3}
typeArgs[03]={1,1}
typeArgs[04]={2,1}
typeArgs[05]={3,2}
typeArgs[06]={4,1}
typeArgs[07]={5,2}
typeArgs[08]={6,2}
typeArgs[09]={7,0}
typeArgs[10]={8,1}
typeArgs[11]={9,1}
]]--

local monRestart = -1
local monPrint = 0
local monWrite = 1 --() Write to the Monitor's screen.
local monScroll = 2 --( n ) Scrolls the monitor screen.
local monSetCursorPos = 3 --( x, y )  Sets the cursor position on the Monitor.
local monSetCursorBlink = 4 --( b ) Enables or disables cursor blinking.
local monGetCursorPos = 5 --()  Returns two arguments containing the x and the y position of the cursor on the Monitor.
local monGetSize = 6 --() Returns two arguments containing the x and the y values stating the size of the Monitor.
local monClear = 7 --() Clears the Monitor.
local monClearLine = 8 --( line ) Clears the line the cursor is on.
local monSetTextScale = 9 --( scale )

function bootUp()
  mon = peripheral.wrap(monitorSide)
  mon.clear()
  debugText("Monitor Connected...")
  sleep(0.5)
  rednet.open(modemSide)
  debugText("Networking Online...")
  sleep(0.5)
  debugText("Waiting for first msg...")
end 

function debugText( msg )
  mon.scroll(1)
  mon.setCursorPos( 1, 5 )
  mon.write(msg)
  print(msg)
end

function stringToMsg( msg )
  print(msg)
  output = {}
  pos=0

  debugText(msg)
  msgArr = serialize.deserialize(msg)
  debugText("1st arg: ".. tostring(msgArr[1]))
  debugText("2nd arg: ".. tostring(msgArr[2]))
  debugText("3rd arg: ".. tostring(msgArr[3]))
  debugText("4th arg: ".. tostring(msgArr[4]))
  debugText("4th arg: ".. tostring(msgArr[5]))

  lastPos=pos
  --pos=msg.find(",", pos)
  pos=msg:find(",", pos)
  print(tostring(msg:find("*")))
  -- Get Type from first area
  if pos == nil then
    print("returning entire string")
    return {tonumber(msg)}
  end

  print("first , Pos: "..pos)
  print(msg:sub(lastPos, pos-1))
  msgType = tonumber(msg:sub(lastPos, pos-1))
  output[1] = msgType
  args=-1
  for tSet in typeArgs do
    if tSet[1] == msgType then
      args=tSet[2]
      break
    end
  end
  -- Check that it did not error
  if args == -1 then
    return nil
  end
  aPos = 1
  a = args
  -- Get remaining args
  while a > 0 do
    aPos = apos + 1
    a = a + 1
    
    lastPos=pos
    if not a == 0 then
      pos=msg:find(",", pos)
    end
    output[aPos]=msg:sub(lastPos, pos-1)
  end
  bla = 0
  kill = bla[5]
  return output
end

while true do 
  validSender = false
  if firstCycle then
    bootUp()
    firstCycle = false
  end
  local senderId = nil
  local message
  local distance

  while senderId == nil do
    senderId, message, distance = rednet.receive(10)
  end
  --debugText(senderId)
  --debugText(message)
  for i,v in ipairs(senders) do
    if v == senderId then
      validSender = true
      break
    end
  end
  if validSender then
    --print(message)
    --message = stringToMsg(message)
    --message = serialize.deserialize(message)

    --debugText(message)
    message = serialize.deserialize(message)
    --debugText("1st arg: " .. tostring(message[1]))
    --debugText("2nd arg: " .. tostring(message[2]))
    --debugText("3rd arg: " .. tostring(message[3]))
    --debugText("4th arg: " .. tostring(message[4]))
    --debugText("5th arg: " .. tostring(message[5]))

    --print(message)
    --debugText(tostring(message[1])..","..tostring(message[2])..","..tostring(message[3])..","..tostring(message[4]))
    if message[1] == "monServer" then
      if message[2] == monPrint then
        mon.setCursorPos( message[3], message[4] )
        mon.write(message[5])
        print("monPrint {"..message[3]..","..message[4]..","..message[5].."}")
      elseif message[2] == monClearLine then
        mon.clearLine(message[3])
        print("monClearLine {"..message[3].."}")
      elseif message[2] == monWrite then
        mon.write(message[3])
        print("monWrite {"..message[3].."}")
      elseif message[2] == monScroll then
        mon.scroll(message[3])
        print("monScroll {"..message[3].."}")
      elseif message[2] == monSetCursorPos then
        mon.setCursorPos(message[3], message[4])
        print("monSetCursorPos {"..message[3]..","..message[4].."}")
      elseif message[2] == monSetCursorBlink then
        mon.setCursorBlink(message[3])
        print("monSetCursorBlink {"..message[3].."}")
      elseif message[2] == monClear then
        mon.clear()
        term.clear()
        print("monClear {}")
      elseif message[2] == monClearLine then
        mon.clearLine(message[3])
        print("monClearLine {"..message[3].."}")
      elseif message[2] == monSetTextScale then
        mon.setTextScale(message[3])
        print("setTextScale {"..message[3].."}")
      end
    end
--[[
    ]]--
  end
end