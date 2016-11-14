-- @Author: Alan
-- @Date:   2016-11-14 11:16:31
-- @Last Modified by:   Alan
-- @Last Modified time: 2016-11-14 11:48:53


--[[
通用的编程技术"空间换时间"，
记录下函数计算结果，然后使用相同的参数调用该函数时，便可以复用之前的结果
--]]

-- 以下代码模拟备忘录函数

local results = {}
-- 使用weak table解决因累积耗费服务器内存的问题 
setmetatable(results, {__mode = "v"})		-- 使value成为弱引用
function mem_loadstring( s )
	local res = results[s]
	if res == nil then 
		res = assert(loadstring(s))
		results[s] = res
	end
	return res
end

-- "备忘录"技术，可以确保某对象的唯一性

-- 颜色生成器函数
function createRGB( r, g, b )
	return {red = r, green = g, blue = b}
end

local results1 = {}
setmetatable(results1, {__mode = "v"})
function createRGB( r, g, b )
	local key = r .. "-" .. g .. "-" .. b
	local color = results1[key]
	if color == nil then
		color = {red = r, green = g, blue = b}
		results1[key] = color
	end
	return color
end