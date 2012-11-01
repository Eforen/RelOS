if turtle ~= nil then
	disk.setLabel("front", "SatelliteOS" )
	local path = disk.getMountPath("front")
	fs.copy("/lib", path .. "/lib")
	fs.copy("/bin/satellite/install/modules", path .. "/modules")
	fs.copy("/bin/satellite/install/install.lua", path .. "/startup")
	fs.copy("/bin/satellite/install/boot.lua", path .. "/boot")
else
	fs.copy("/disk/lib", "/lib")
	fs.copy("/disk/modules", "/modules")
	fs.copy("/disk/boot", "/startup")
end