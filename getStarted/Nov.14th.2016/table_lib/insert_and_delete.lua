-- @Author: Alan
-- @Date:   2016-11-14 15:31:35
-- @Last Modified by:   Alan
-- @Last Modified time: 2016-11-14 15:47:35


-- table.insert 用于将一个元素插入到数组的指定位置，它会移动后续元素以空出空间
-- 如果在调用insert时没有指定位置参数，则会将元素添加到数组末尾

local t = {}
for line in io.lines() do
	table.insert(t, line)
end
print(#t)

print(string.rep("*", 10))

-- table.remove会删除(并返回)数组指定位置上的元素，并将该位置之后的所有元素前移，以填补空隙
-- 如果在调用这个函数时不指定位置参数，它就会删除数组的最后一个元素
