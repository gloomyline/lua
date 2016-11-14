-- @Author: Alan
-- @Date:   2016-11-14 10:25:36
-- @Last Modified by:   Alan
-- @Last Modified time: 2016-11-14 10:45:54


local modname = complex
local M = {}
_G[modname] = M
package.loaded[modname] = M

--[[
当创建了一个空table M作为环境后，就无法访问前一个环境中全局变量了
以下两种方法可以解决访问其他的模块
--]]
-- 访问其他模块解决办法，继承
setmetatable(M, {__index = _G})
-- 更快捷的方法来访问其他模块，声明一个局部变量，用以保存对旧环境的访问
-- 使用此方法，必须在所有全局变量的名称前加上"_G",由于没有使用元方法，这种访问会比上面的方法略快
local _G = _G

setfenv(1, M)

--[[
必须先调用setmetatable再调用setfenv
通过这种方法，模块就能直接访问任何全局标识
每次访问只需付出很小的开销。
这种方法会导致的后果，此时的模块中包含了所有的全局变量
比如说，其他人可以通过这个模块来调用标准的正选函数complex.math.sin(x)
--]]



	-- 声明函数add，成为complex.add
	function add( c1, c2 )
		return new(c1.r + c2.r, c1.i + c2.i)
	end	

-- 更正规的方法是将需要用到的函数或模块声明为局部变量

-- 模块设置
local modname = ...
local M = {}
_G[modname] = M
package.loaded[modname] = M

-- 导入段
-- 声明这个模块从外界所需的东西
local sqrt = math.sqrt
local io = io

-- 在这句结束之后就不再需要外部访问了
setfenv(1, M)

--[[
这种技术要求做更多的工作，但是它能清晰的说明模块的依赖性
同时，较之前的两种方法，它的运行速度更快
--]]