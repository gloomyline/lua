-- @Author: gloomy
-- @Date:   2016-11-09 22:46:11
-- @Last Modified by:   gloomy
-- @Last Modified time: 2016-11-09 23:10:34


-- 检测所有对全局table不存在的key的访问
-- 方法1
local mt = {
	__index = function ( _, n )
		error("attempt to read undeclared variable " .. n, 2)
	end,
	__newindex = function ( _, n )
		error("attempt to write to undeclared variable " .. n, 2)
	end,
}
setmetatable(_G, mt)

-- 访问全局table中不存在key以测试
-- print (a)

-- 绕过元表，声明一个新的变量
rawset(_G, "declare", function ( name, initval )
	rawset(_G, name, initval or false)
end)

declare("a", 10)
print(a)

print (string.rep('*', 10))

-- 方法2
local declareNames = {}

setmetatable(_G, {
	__newindex = function (t, n, v)
		if not declareNames[n] then
			local w = debug.getinfo(2, "S").what
			if w ~= "main" and w ~= "C" then
				error("attempt to write to undeclared variable " .. n, 2)
			end
			declareNames[n] = true
		end
		rawset(t, n, v)				-- 完成实际全局变量设置
	end,
	__index = function ( _, n )
		if not declareNames[n] then
			error("attempt to read undeclared variable " .. n, 2)
		else
			return nil
		end
	end,
})

--[[
上述两种方法导致的开箱基本可以忽略不计
第一种方法中，完全没有涉及到元方法的调用
第二种方法虽然会使程序调用到元方法，但只有当程序访问一个nil变量是才会发生
Lua发行版本中包含一个叫strict.lua的模块，实现了对全局变量的检查，使用了上述的技术
--]]