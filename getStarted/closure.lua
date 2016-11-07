-- @Author: Alan
-- @Date:   2016-11-06 09:47:48
-- @Last Modified by:   Alan
-- @Last Modified time: 2016-11-06 10:00:41
a = {}
local x = 20
for i=1,10 do
	local y = 0
	a[i] = function () y=y+1; return x+y end
	print (i, a[i]())
end

--[[这个循环创建了十个闭包（这指十个匿名函数的实例）。
这些闭包中的每一个都使用了不同的 y 变量， 而它们又共享了同一份 x。
]]--

print ('end')