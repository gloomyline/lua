-- @Author: gloomy
-- @Date:   2016-11-07 22:09:43
-- @Last Modified by:   gloomy
-- @Last Modified time: 2016-11-07 22:29:06


Lib = {}
Lib.foo = function ( x, y )
	return x + y 
end
Lib.goo = function ( x, y )
	return x - y
end

-- 使用构造式
Lib = {
	foo = function (x, y) return x + y end,
	goo = function (x, y) return x - y end
}

-- ------------------
Lib = {}
function Lib.foo( x, y )
	return x + y
end
function Lib.goo( x, y )
	return x - y
end

-- ------------------
-- recursive non-global func
local fact 				-- 需要先定义一个局部变量，避免在递归时调用的是全局的函数
fact = function ( n )
	if n == 0 then
		return 1
	else
		return n*fact(n-1)
	end
end

print(fact(5))
print(fact(10))

--[[
上述代码用以下方式定义也可以解决上述可能出现的问题
local function fact(n)
	if n == 0 then
		return 1
	else
		return n*fact(n-1)
	end
end

这个技巧对于间接递归的函数而言是无效的，
在间接递归的情况中，必须使用一个明确的前向声明(Forward Declaration)
示例代码如下：
--]]
local f, g 				-- 前向声明
function g(  )
	f()
end
function f(  )
	g()
end
-- 注意，别把第二个函数定义写为“local function f0”.
-- 如果这样做的话，Lua会创建一个新的局部变量f,
-- 而将原来声明的f(函数g中所引用的那个)置于未定义状态
