write("Creating Bin Install Cache...")
local FileList = fs.list("") --Table with all the files and directories available

for _,file in ipairs( FileList ) do --Loop. Underscore because we don't use the key, ipairs so it's in order
  print( "Found File:" .. file ) --Print the file name
end --End the loop

write("Creating bin dir...")
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