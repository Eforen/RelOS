write("Creating Install Cache...")
-- Lib format
-- {
--	string = Verbos name
--	string = file path relitive to /lib/,
--	string = install location relitive to /lib/
--	boolean = autoload
-- }
--	
dirs = {
	"move"
}
libs = {
	{"GPS Server", "gpss.lua", "gpss", true}
}
write("Creating lib dir...")
fs.makeDir("/lib")
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