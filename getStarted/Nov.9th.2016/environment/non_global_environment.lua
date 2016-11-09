-- @Author: Alan
-- @Date:   2016-11-09 23:11:18
-- @Last Modified by:   gloomy
-- @Last Modified time: 2016-11-09 23:28:15


-- 通过函数setfenv来改变一个函数的环境
-- 该函数的参数是一个函数和一个新的环境table
-- 第一个参数除了可以指定为函数本身，还可以指定为一个数字，
-- 以表示当前函数调用栈中的层数
-- 数字1表示当期函数，数字2表示调用当前函数的函数，一次类推

-- a = 1					-- 创建一个全局变量
-- setfenv(1, {g=_G})		-- 改变当前的环境

-- g.print (a)
-- g.print	(g.a)

-- g.setfenv(1, {_G = g._G})
-- _G.print(a)
-- _G.print(_G.a)

-- 使用继承来组装新环境
a = 1
local newgt = {}		-- 创建新环境
setmetatable(newgt, {__index = _G})
setfenv(1, newgt)		-- 设置变量环境
print(a)

a = 10
print(a)
print(_G.a)
_G.a = 20
print(_G.a)
print(a)

print (string.rep("*", 10))

-- 每个函数及某些closure都有一个继承环境
function factory(  )
	return function (  )
		return a		-- "全局的"a
	end
end

a = 3
f1 = factory()
f2 = factory()

setfenv(f1, {a=10})
print (f1())
print (f2())