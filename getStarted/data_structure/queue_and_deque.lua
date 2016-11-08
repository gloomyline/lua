-- @Author: gloomy
-- @Date:   2016-11-08 21:31:49
-- @Last Modified by:   gloomy
-- @Last Modified time: 2016-11-08 21:45:29


function ListNew(  )
	return {first = 0, last = -1}
end

-- 避免污染全局名称空间，
-- 在一个table内部定义所有的队列操作，
-- 这个table称为List,将上述函数重写为
List = {}
function List.new(  )
	return {first = 0, last = -1}
end

-- 在常量时间内完成在两端插入或删除元素
-- 队首入队
function List.pushFirst( list, value )
	local first = list.first - 1
	list.first = first
	list[first] = value
end

-- 队尾入队
function List.pushLast( list, value )
	local last = list.last + 1
	list.last = last
	lsit[last] = value
end

-- 队首出队
function List.popFirst( list )
	local first = list.first
	if first > list.last then
		error("list is empty")
	end
	local value = list[first]
	list[first] = nil				-- 允许垃圾收集
	list.first = first + 1
	return value
end

-- 队尾出队
function List.popLast( list )
	local last = list.last
	if last < list.first then
		error ("list is empty")
	end
	local value = list[last]
	list[last] = nil 				-- 允许垃圾收集
	list.last = last - 1
	return value
end