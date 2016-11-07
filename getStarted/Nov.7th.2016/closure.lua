-- @Author: Alan
-- @Date:   2016-11-06 09:47:48
-- @Last Modified by:   gloomy
-- @Last Modified time: 2016-11-07 22:09:55

--[[
若将一个函数写在另一个函数之内，
那么这个位于内部的函数便可以访问外部函数中的局部变量，
这项特征称之为“词法域”。
--]]
local names = {"Alan", "Paul", "Marry"}		-- 学生姓名列表
local grades = {Alan = 10, Paul = 7, Marry = 8}	-- 对应于每个姓名的年级列表
-- 根据每个学生的年级来对姓名进行排序
function sortByGrade( names, grades )
	table.sort( names, function(n1, n2) return grades[n1] > grades[n2] end )
end

for i,v in ipairs(names) do
	print(i,v)
end

print ('**********')

sortByGrade(names, grades)

for i,v in ipairs(names) do
	print(i,v)
end

print ('**********')

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

print ('**********')

do

function newCounter(  )
	local i = 0
	return function (  )
		i = i + 1
		return i
	end
end

local nc = newCounter()
for i = 1, 10 do
	print(nc())
end
print(nc())

print ('**********')

local nc1 = newCounter()
for i=1,10 do
	print(nc1())
end

end
--[[
在上述代码块中，匿名函数访问了一个“非局部的变量”i，
该变量用于保持一个计数器。
一个closure就是一个函数加上该函数所需访问的所有“非局部的变量”，
如果再次调用newCounter，那么它会创建一个新的局部变量i，
从而也得到一个新的closure
nc和nc1是同一个函数所创建的两个不同的closure，
它们各自拥有局部变量i的独立实例
--]]

-- 重新定义math.sin
do
local oldSin = math.sin
local k = math.pi/180
math.sin = function ( x )
	return oldSin(x*k)
end
print(math.sin(30))
end
--[[
将老版本的sin保存到了一个私有变量中，
现在只有通过新版本sin才能访问到它了。
可以使用同样的技术创建一个安全的运行环境，
即所谓的“沙盒”(sandbox)。
--]]