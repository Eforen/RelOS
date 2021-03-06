function sp( seconds )
	if releaseVersion then
		os.sleep( seconds )
	end
end


dirs = { }
files = { }
libs = {
	{"Serialize API", "net/serialize.lua", "net/serialize", true},
	{"Graphic Interface API", "gui/gui.lua", "gui/gui", true},
	{"Config API", "util/config.lua", "util/config", true},
	{"Vector API", "util/vector.lua", "util/vector", true},
	{"SmartMove API", "turtle/smartmove.lua", "turtle/smartmove", true}
}

local pageLine = 1
function stepPage()
	pageLine = pageLine + 1
	--printer.setCursorPos(0, pageLine)
end

function dothing(dir, loc)
	local FileList = fs.list(dir) --Table with all the files and directories available

	for _,file in ipairs( FileList ) do --Loop. Underscore because we don't use the key, ipairs so it's in order
		if fs.isDir(dir .. "/" .. file) then
			--dirs = {dirs, loc .. file}
			table.insert(dirs, loc .. file)
			dothing(dir .. "/" .. file, loc .. file .. "/")
			--printer.write( dir .. "/" .. file.."/:d")
			--stepPage()
		else
			--files = {files, loc .. file}
			table.insert(files, loc .. file)
			--printer.write( dir..loc..file..":f")
			--stepPage()
		end
		--print( "Found File:" .. file ) --Print the file name
		--os.sleep( 0.3 )
		--write("\n")
	end --End the loop
end

write("Creating Bin Install Cache...\n")
sp( 0.2 )

--printer = peripheral.wrap( "right" )
--printer.newPage()
--printer.setPageTitle("Search Debug Printout")
dothing("/disk/bin", "/")
--printer.endPage()

for _,dir in ipairs( dirs ) do
	write(dir .. "/\n")
	sp( 0.3 )
end

for _,file in ipairs( files ) do
	write(tostring(file) .. "\n")
	sp( 0.3 )
end

sp( 0.4 )
write("Creating bin dir...\n")
fs.makeDir("/bin")


--string.sub("123456789", -4, -1)



for _,dir in ipairs( dirs ) do
	write("Creating Dir: " .. "/bin" .. dir .. "/ ")
	sp( 0.1 )
	write(".")
	sp( 0.1 )
	write(".")
	sp( 0.1 )
	write(".")
	sp( 0.1 )
	write("\n")

	fs.makeDir("/bin" .. dir)
end

--printer.newPage()
pageLine = 0
stepPage()
--printer.setPageTitle("Copy Debug Printout")
for _,file in ipairs( files ) do
	if string.sub(file, -4, -1) == ".lua" then
		write("Copy File: " .. "/bin" .. string.sub(file, 1, -5))
		fs.delete("/bin" .. string.sub(file, 1, -5))
		fs.copy("/disk/bin" .. file, "/bin" .. string.sub(file, 1, -5))
		--printer.write( "f:/bin" .. string.sub(file, 1, -5))
		--stepPage()
	else
		write("Copy File: " .. "/bin" .. file)
		fs.delete("/bin" .. file)
		fs.copy("/disk/bin" .. file, "/bin" .. file)
		--printer.write( "d:/bin" .. file)
		--stepPage()
	end
	sp( 0.1 )
	write(".")
	sp( 0.1 )
	write(".")
	sp( 0.1 )
	write(".")
	sp( 0.1 )
	write("\n")
end
--printer.endPage()

--[[
for dir in dirs do
	write("Creating lib/"+dir)
	fs.makeDir("/lib/"+dir)
end
write("Installing lib files to dir...")
for lib in libs do
	write("Installing lib "+lib[1])
	fs.delete ("/lib/"+lib[3])
	fs.copy("/disk/lib/"+lib[2], "/lib/"+lib[3])
end
write("Loading apis...")

for lib in libs do
	write("Loading api "+lib[3])
	os.loadAPI('/lib/'+lib[3])
end
--]]