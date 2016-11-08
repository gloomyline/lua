-- @Author: gloomy
-- @Date:   2016-11-08 21:05:47
-- @Last Modified by:   gloomy
-- @Last Modified time: 2016-11-08 21:13:35

a = {}						-- 新建一个数组
for i = 1, 1000 do
	a[i] = 0
end

print (#a)					-- 长度操作符"#"依赖于这个事实计算数组的大小

local squares = {}
for i = 1, 10 do
	table.insert(squares, i^2)
end

print (table.concat( squares, ", ", 1, 10 ))

for i,v in ipairs(squares) do
	print(tostring(i) .. '-' .. v)
end