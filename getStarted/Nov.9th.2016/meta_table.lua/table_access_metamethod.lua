-- @Author: gloomy
-- @Date:   2016-11-09 21:35:17
-- @Last Modified by:   gloomy
-- @Last Modified time: 2016-11-09 22:34:54


-- 1. __index元方法

-- 首先，声明一个原型和一个构造函数，构造函数创建新的窗口，并使它们共享一个元表
Window = {}					-- 创建一个命名空间
Window.prototype = {		-- 使用默认值创建一个原型
	x = 0, 
	y = 0, 
	width = 100, 
	height = 100,
}
Window.mt = {}				-- 创建元表
function Window.new( o )	-- 声明构造函数
	setmetatable (o, Window.mt)
	return o
end

-- 定义__index元方法
Window.mt.__index = function ( table, key )
	return Window.prototype[key]
end
-- 当__index是一个table时，上述方法声明可简写为
-- Window.mt.__index = Window.prototype
-- 将一个table作为__index元方法是一种快捷的、实现单一继承的方式
-- 如果不想在访问一个table时涉及它的__index元方法，可以使用函数rawget,调用rawget(t, i)就是对table t进行了一个原始的(raw)访问

-- 创建一个新窗口，并查询一个它没有的字段
w = Window.new{x = 10, y = 20}
print (w.width)

-- 2. __newindex元方法
--[[
__newindex元方法与__index类似，不同之处在于前者用于table更新，后者用于table查询。
当对一个table中不存在的索引赋值时，解释器就会查找__newindex元方法。
如果有这个方法，解释器就调用它，而不执行赋值。
如果这个元方法是一个table，解释器就在table中执行赋值，而不是对原来的table。
此外，还有一个原始函数允许绕过元方法，调用raw(t, k, v)就可以不涉及任何元方法而直接设置table t中与key k 相关联的value v。
组合使用__index和__newindex元方法可以实现诸如只读table，具有默认值table和面向对象过程中的继承。
--]]

print (string.rep('*', 10))

-- 3. 具有默认值的table
function setDefault( t, d )
	local mt = {}
	mt.__index = function (  )
		return d
	end
	setmetatable(t, mt)
end

tab = {x=10, y=20}
print (tab.x, tab.z)
setDefault(tab, 0)
print (tab.x, tab.z)

print (string.rep('*', 10))

local mt = {}
function mt.__index( t )
	return t.___
end
function setDefault( t, d )
	t.___ = d
	setmetatable(t, mt)
end

-- 4. 跟踪table访问
t = {}						-- 原来的table(其他地方创建的)
local _t = t 				-- 保持对原table的私有访问

t = {}						-- 创建代理
local mt = {				-- 创建元表
	__index = function ( t, k )
		print ("*access to element " .. tostring(k))
		return _t[k]		-- 访问原来的table
	end,
	__newindex = function ( t, k, v )
		print ("*update of element " .. tostring(k) .. " to " .. tostring(v))
		_t[k] = v			-- 更新原来的table
	end
}
setmetatable(t, mt)

t[2] = "hello"
print(t[2])

-- 将原来的talbe保存在代理table的一个特殊字段中
local index = {}			-- 创建私有索引
local mt = {				-- 创建元表
	__index = function ( t, k )
		print ("*access to element " .. tostring(k))
		return t[index][k]	-- 访问原来的table
	end,
	__newindex = function ( t, k, v )
		print ("*update of element " .. tostring(k) .. " to " .. tostring(v))
		t[index][k] = v		-- 更新原来的table
	end
}

function track( t )
	local proxy = {}
	proxy[index] = t
	setmetatable(proxy, mt)
	return proxy
end

-- 监视table t,唯一要做的就是执行：
t = track(t)

-- 5. read-only-table
function readOnly( t )
	local proxy = {}
	local mt = {
		__index = t,
		__newindex = function ( t, k, v )
			error("attempt to update a read-only table", 2)
		end
	}
	setmetatable(proxy, mt)
	return proxy
end

-- 使用示例
days = readOnly{"Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"}
print (days[1])
days[2] = "Noday"
