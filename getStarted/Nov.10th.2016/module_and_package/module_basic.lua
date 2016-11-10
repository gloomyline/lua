-- @Author: Alan
-- @Date:   2016-11-10 21:05:44
-- @Last Modified by:   Alan
-- @Last Modified time: 2016-11-10 21:50:30


-- 在Lua中创建一个模块最简单的方法是：创建一个table，并将所有需要导出的函数放入其中，最后返回这个table。inv声明为程序快的局部变量，就是将其定义成一个私有名称

local modname = ...
local M = {}
-- complex = M 		-- 模块名
_G[modname] = M
package.loaded[modname] = M

-- 定义一个常量'i'
M.i = {r = 0, i = 1}

function M.new( r, i )
	return {r = r, i = i}
end

function M.add( c1, c2 )
	return complex.new(c1.r + c2.r, c1.i + c2.i)
end

function M.sub( c1, c2 )
	return complex.new(c1.r - c2.r, c1.i - c2.i)
end

function M.mul( c1, c2 )
	return complex.new(c1.r * c2.r, c1.i * c2.i)
end

local function inv(c)
	local n = c.r^2 + c.i^2
	return M.new(c.r/n, -c.i/n)
end

function M.div( c1, c2 )
	return M.mul(c1, inv(c2))
end

-- return complex