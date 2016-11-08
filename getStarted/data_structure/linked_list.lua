-- @Author: gloomy
-- @Date:   2016-11-08 21:27:16
-- @Last Modified by:   gloomy
-- @Last Modified time: 2016-11-08 21:30:32

-- 1. 创建一个用作列表头结点的变量
list = nil

-- 2. 在表头插入一个元素，元素值为v
list = {next = list, value = v}

-- 3. 遍历此列表
local  l = list
while l do
	print (l.value)
	l = l.next
end