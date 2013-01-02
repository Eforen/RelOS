if turtle ~= nil then
	local tArgs = { ... }
	if #tArgs < 3 then
		print("Invalid Args")
		os.sleep(5)
		return
	end
	disk.setLabel("front", "SatelliteOS" )
	local path = disk.getMountPath("front")
	fs.delete(path .. "/lib")
	fs.delete(path .. "/modules")
	fs.delete(path .. "/deamon")
	fs.delete(path .. "/startup")
	fs.delete(path .. "/boot")
	fs.delete(path .. "/SatelliteSettings")
	fs.copy("/lib", path .. "/lib")
	fs.copy("/bin/satellite/install/modules", path .. "/modules")
	fs.copy("/bin/satellite/install/deamon", path .. "/deamon")
	fs.copy("/bin/satellite/install/install", path .. "/startup")
	fs.copy("/bin/satellite/install/boot", path .. "/boot")
	sfile = io.open(path .. "/SatelliteSettings", 'w')
	sfile:write("function getPos() return "..tonumber(tArgs[1])..", "..tonumber(tArgs[2])..", "..tonumber(tArgs[3]).." end")
	sfile:close()
else
	fs.delete("/lib")
	fs.delete("/modules")
	fs.delete("/deamon")
	fs.delete("/SatelliteSettings")
	fs.delete("/startup")
	fs.copy("/disk/lib", "/lib")
	fs.copy("/disk/modules", "/modules")
	fs.copy("/disk/deamon", "/deamon")
	fs.copy("/disk/SatelliteSettings", "/SatelliteSettings")
	fs.copy("/disk/boot", "/startup")
	shell.run("/deamon")
	correct("/")
end