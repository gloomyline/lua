-- @Author: Alan
-- @Date:   2016-11-08 20:34:14
-- @Last Modified by:   gloomy
-- @Last Modified time: 2016-11-08 21:00:32

-- 1. 将两个单词以空格相连，编码成一个前缀
function prefix( w1, w2 )
	return w1 .. ' ' .. w2
end

-- 2. 向构造的table某个前缀列表插入一个新单词，使用以下函数
function insert( index, value )
	local list = statetab[index]
	if list == nil then
		statetab[index] = {value}
	else
		list[#list + 1] = value
	end
end

-- 3. 创建完table后，生成具有MAXGEN单词的文本
--[[
首先，重现初始化变量w1和w2
然后，对于每个前缀，程序从其对应的单词列表中随机地选出下一个单词，并打印。
最后更新w1和w2。
下面是该程序的辅助函数定义：
--]]
function allwords(  )
	local line = io.read()					-- 当前行
	local pos = 1							-- 行中当前位置
	return function (  )					-- 迭代器函数
		while line do						-- 只要还有行就一直循环
			local s, e = string.find(line, "%w+", pos)
			if s then						-- 找到一个单词了吗？
				pos = e + 1					-- 更新下一个位置
				return string.sub(line, s, e)-- 返回该单词
			else
				line = io.read()			-- 没有找到单词，尝试下一行
				pos = 1						-- 从行首位置重新开始
			end
		end
		return nil							-- 所有行都遍历完毕
	end
end

-- 4. 下面是主程序:
local N = 2
local MAXGEN = 10000
local NOWORD = "\n"

-- 构建table
local w1, w2 = NOWORD, NOWORD
for w in allwords() do
	insert(prefix(w1, w2), w)
	w1 = w2; w2 = w
end
insert(prefix(w1, w2), NOWORD)

-- 生成文本
w1 = NOWORD; w2 = NOWORD 					-- 重新初始化
for i=1, MAXGEN do
	local list = statetab[prefix(w1, w2)]
	-- 从列表中选择一个随机项
	local r = math.random(#list)
	local nextword = list[r]
	if nextword == NOWORD then
		return
	end
	io.write(nextword, " ")
	w1 = w2; w2 = nextword
end