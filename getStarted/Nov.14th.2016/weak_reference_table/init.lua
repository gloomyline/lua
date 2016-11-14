-- @Author: Alan
-- @Date:   2016-11-14 11:02:12
-- @Last Modified by:   Alan
-- @Last Modified time: 2016-11-14 11:15:14


-- weak table(弱引用 table)用户能用它来告诉Lua一个引用不该阻碍一个对象的回收
--[[
所谓"弱引用(weak reference)"就是一种会被垃圾收集器忽视的对象的引用。
如果一个对象的所有引用都是弱引用，那么Lua就可以回收这个对象了，并且还可以以某种形式来删除这些弱引用本身。
使用"弱引用table"来实现"弱引用"，一个弱引用table就是一个具有弱引用条目的table
如果一个对象只被一个弱引用table所持有，那么lua会回收这个对象
一个弱引用类型通过元表中的__mode字段来决定的
--]]

-- 以下示例演示了弱引用table的一些基本行为
a = {}
b = {__mode = "k"}
setmetatable (a, b) 			-- 现在'a'的key就是弱引用
key = {}						-- 创建第一个key
a[key] = 1					
key = {}						-- 创建第二个key
a[key] = 2
collectgarbage()				-- 强制进行一次垃圾收集
for k, v in pairs(a) do
	print(V)
end

-- Lua只会回收弱引用table中的对象，数字、布尔和字符串的这样的"值"是不可回收的