write("Creating Bin Install Cache...\n")
os.sleep( 0.2 )
local FileList = fs.list("/disk/bin") --Table with all the files and directories available

for _,file in ipairs( FileList ) do --Loop. Underscore because we don't use the key, ipairs so it's in order
	print( "Found File:" .. file ) --Print the file name
	os.sleep( 0.3 )
	--write("\n")
end --End the loop

os.sleep( 0.4 )
write("Creating bin dir...\n")
fs.makeDir("/bin")

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