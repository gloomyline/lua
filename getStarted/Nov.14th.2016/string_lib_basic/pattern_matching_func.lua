-- @Author: Alan
-- @Date:   2016-11-14 16:57:02
-- @Last Modified by:   Alan
-- @Last Modified time: 2016-11-14 17:26:25


--[[
字符串库中最强大的函数find、match、gsub(global substitution,全局替换)
和gmatch(全局匹配),基于“模式(patttern)”
--]]

-- string.find 当find找到一个模式后，它就会返回两个值：匹配到的起始索引和结尾索引，如果没有找到任何匹配，返回nil
-- 这个函数还有第三个可选参数，是一个索引，告诉函数应从目标字符串那个位置开始搜索
local s = 'test\nt\ne\n\s\t\n'
local t = {}
local i = 0
while true do
	i = string.find(s, '\n', i + 1)
	if i == nil then break end
	t[#t + 1] = i
end

-- string.match 返回的是目标字符串中与模式匹配的那部分子串，而非该模式所在位置

-- string.gsub函数
--[[
3个参数：目标字符串、模式和替换字符串
第四个参数为可选参数，可以先知替换的次数
将目标字符串中国有出现模式的地方替换为替换字符串(最后一个参数)：
--]]
-- string.gsub还有另一个结果，实际替换的次数，一下代码就是一种统计字符串中空格数量的简单方法
local str = 'test test test t e s t'
count = select(2, string.gsub(str, ' ', ' '))
print (count)

-- string.gmatch
--[[
返回一个函数，通过这个函数可以遍历到一个字符串中所有出现指定模式的地方
--]]
local s = 'it is just a test'
local words = {}
for w in string.gmatch(s, '%a+') do
	words[#words + 1] = w
end

for i, v in ipairs(words) do
	print (tostring(i) .. '-' .. v)
end

-- 通过gmatch和gsub模拟require在寻找模块时的搜索策略
function search( modname, path )
	modname = string.gsub(modname, '%.', '/')
	for c in string.gmatch(path, '[^;]+') do
		local fname = string.gsub(c, '?', modname)
		local f = io.open(fname)
		if f then
			f:close()
			return fname
		end
	end
	return nil 					-- 未找到
end