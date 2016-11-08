-- @Author: gloomy
-- @Date:   2016-11-08 21:52:38
-- @Last Modified by:   gloomy
-- @Last Modified time: 2016-11-08 21:52:59

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
