-- @Author: Alan
-- @Date:   2016-11-07 14:36:09
-- @Last Modified by:   Alan
-- @Last Modified time: 2016-11-07 14:48:09

x = 10
local i = 1

while i <= x do
	local x = i * 2
	print (x)
	i = i + 1
end

print ('**********')

if i > 20 then
	local x
	x = 20
	print (x + 2)
else
	print (x)
end

--[[
总结：
1. 如果在交互模式中输入这段代码的话，该示例可能不会如预期那样的工作。因为在交互模式中每行输入内容自身就形成了一个程序块
2. 解决这个问题的办法，显式地界定一个块，将这些内容放入一对do-end关键字中
3. "尽可能的使用局部变量"是一种良好的编程风格，局部变量可以避免将一些无用的名称引入全局环境，访问局部变量比访问全局变量更快，局部变量通常会随着其作用域结束二小时，这样便于垃圾回收
--]]