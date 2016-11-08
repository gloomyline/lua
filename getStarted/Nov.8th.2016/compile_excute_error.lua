-- @Author: Alan
-- @Date:   2016-11-08 10:57:19
-- @Last Modified by:   Alan
-- @Last Modified time: 2016-11-08 11:50:35

-- compile
--[[print "enter function to be plotted (with variable 'x')"
local l = io.read()
local f = assert(loadstring("local x = ...;return " .. l))
for i = 1, 20 do 
	print (string.rep("*", f(i)))
end
--]]

-- error

local file, msg
repeat
	print 'enter a file name'
	local name = io.read()
	if not name then 
		print 'input nil'
		return 
	end

	-- 如果不想处理错误情况，仍需安全运行程序，使用assert来检测操作
	-- file = assert(io.open(name, 'r'))
	-- 如果io.open失败了，assert就引发一个错误，错误消息是io.open的第二个返回值

	file, msg = io.open(name, 'r')
	if not file then
		print (msg)
	end
until file
print "end"

-- error_handle_exceptions

-- error msg and traceback
