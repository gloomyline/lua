-- @Author: Alan
-- @Date:   2016-11-14 14:00:36
-- @Last Modified by:   Alan
-- @Last Modified time: 2016-11-14 15:34:56


--[[
math库由一组标准的数学函数构成，
包括三角函数、指数和对数函数(exp、log、log10)、取整函数、生成伪随机函数(random、randomseed),
以及变量pi和huge
--]]

-- 所有的三角函数都使用弧度单位，使用函数deg和rad来转换角度和弧度
-- 使用角度单位，重新定义三角函数
-- local sin, asin, ... = math.sin, math.asin, ..
local deg, rad = math.deg, math.rad
math.sin = function (x) return sin(rad(x)) end
math.asin = function (x) return deg(math.asin(x)) end

-- 函数math.random用于生成伪随机数
math.randomseed()
for i = 1, 10 do
	print(math.random())
end

-- 函数math.randomseed用于设置伪随机数生成器的种子数，它的唯一参数就是这个种子数
--[[
程序启动时，用一个固定的种子数来调用它，以此初始化伪随机数生成器。
这样每次程序运行时，都会生成相同的伪随机数序列。
--]]

-- 生成不同的伪随机数序列方法，函数os.time返回一个表示当前时间的数字，一般这个数字表示从某个时间点开始至今的秒数

