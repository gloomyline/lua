-- @Author: Alan
-- @Date:   2016-11-09 13:38:22
-- @Last Modified by:   Alan
-- @Last Modified time: 2016-11-09 15:00:25


Set = {}

-- 根据参数列表中的值创建一个新的集合
function Set.new( l )
	local set = {}
	for _, v in ipairs(l) do
		set[v] = true
	end
	return set
end

function Set.union( a, b )
	local res = Set.new{}
	for k in pairs(a) do
		res[k] = true
	end
	for k in pairs(b) do
		res[k] = true
	end
	return res
end

function Set.intersection( a, b )
	local res = Set.new{}
	for k in pairs(a) do
		res[k] = b[k]
	end
	return res
end

-- 打印集合函数
function Set.tostring( set )
	local l = {}				-- 用于存放集合中所有元素的列表
	for e in pairs(set) do
		l[#l + 1] = e
	end
	return "{" .. table.concat(l, ', ') .. "}"
end

function Set.print( s )
	print (Set.tostring(s))
end


-- 1. 创建一个准备用作集合的元表
mt = {} 						-- 集合的元表

-- 2. 修改Set.new函数，用于创建集合，将mt设置为当前所创建table的元表
function Set.new( l )
	local set = {}
	setmetatable(set, mt)
	for _, v in pairs(l) do
		set[v] = true
	end
	return set
end

-- 3. 所有由Set.new创建的集合都具有一个相同的元表
s1 = Set.new{10, 20, 30, 50}
s2 = Set.new{30, 1}
print (getmetatable(s1))			-- --> table: 0042E390
print (getmetatable(s2))			-- --> table: 0042E390

-- 4. 将元方法加入元表中
mt.__add = Set.union
mt.__mul = Set.intersection

-- 5. 将两个集合相加、相乘
Set.print(s1 + s2)					-- 使用加号来求集合并集
Set.print((s1 + s2) * s1)			-- 使用乘号来求集合交集

local meta = {Set = Set, mt = mt}
return meta