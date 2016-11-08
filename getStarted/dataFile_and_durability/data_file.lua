-- @Author: gloomy
-- @Date:   2016-11-08 22:37:05
-- @Last Modified by:   gloomy
-- @Last Modified time: 2016-11-08 22:46:56


-- 计算数据文件中条目数量
local count = 0
function Entry( ... )
	count = count + 1
end
dofile("data.lua")
print ("number of entries:" .. count)

-- 收集数据文件中所有作者的姓名，然后打印出这些姓名
local authors = {}				-- 作者姓名的集合
function Entry( b )
	authors[b[1]] = true
end
dofile("data.lua")
for name in pairs(authors) do
	print (name)
end