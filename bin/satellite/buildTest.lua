function header()
	term.clear()
	term.
end

slotFuel = 1
slotComputer = 2
slotDiskDrive = 3
slotModem = 4
slotFloppy = 5

header()

print("Please fill slot " .. slotFuel .. " with Fuel")
while(turtle.getItemCount(slotFuel) == 0) do
	os.sleep( 0.1 )
end
header()

print("Please fill slot " .. slotComputer .. " with Fuel")
while(turtle.getItemCount(slotComputer) == 0) do
	os.sleep( 0.1 )
end
header()

print("Please fill slot " .. slotDiskDrive .. " with Fuel")
while(turtle.getItemCount(slotDiskDrive) == 0) do
	os.sleep( 0.1 )
end
header()

print("Please fill slot " .. slotModem .. " with Fuel")
while(turtle.getItemCount(slotModem) == 0) do
	os.sleep( 0.1 )
end
header()

print("Please fill slot " .. slotFloppy .. " with Fuel")
while(turtle.getItemCount(slotFloppy) == 0) do
	os.sleep( 0.1 )
end
header()

print("All Items Acounted For!")