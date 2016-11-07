-- @Author: Alan
-- @Date:   2016-11-07 20:45:48
-- @Last Modified by:   gloomy
-- @Last Modified time: 2016-11-07 21:27:49

--[[
在Lua中，函数是一种“第一类值(First-class Value)”，
它们具有特定的词法域(Lexical Scoping)。
"第一类值"表示Lua中函数与其他传统类型的值具有相同的权利。
“词法域”是指一个函数可以嵌套在另一个函数中，内部的函数可以访问外部函数外部函数中的变量
--]]

-- 持有某函数的变量
do
local a = {p=print}
a.p "Hello World!"
local print = math.sin 	-- 'print'现在引用了正弦函数
a.p(print(1))
local sin = a.p 			-- 'sin'现在引用了print函数
sin(10, 20)
end

-- anonymous funciton
do
local network = {
	{name = 'grauna', IP = '210.26.30.34'},
	{name = 'arraial', IP = '210.26.30.23'},
	{name = 'lua', IP = '210.26.23.12'},
	{name = 'derain', IP = '210.26.23.20'},
}

function printArrayValue( a )
	for i,v in ipairs(a) do
		if type(v) == 'table' then
			for k,val in pairs(v) do
				print (val)
			end
		else
			print (v)
		end
	end
end

printArrayValue(network)
print ('**********')

table.sort( network, function ( a, b ) return (a.name > b.name) end
)

printArrayValue(network)
end

print ('**********')

-- higer-order function
function derivative( f, delta )
	local delta = delta or le-4
	return function ( x )
		return (f(x+delta) - f(x))/delta
	end
end

c = derivative(math.sin, 0.000001)
print (math.cos(10), c(10))
