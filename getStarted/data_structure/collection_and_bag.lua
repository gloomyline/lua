-- @Author: gloomy
-- @Date:   2016-11-08 21:45:58
-- @Last Modified by:   gloomy
-- @Last Modified time: 2016-11-08 22:00:30


reserved = {
	["while"] = true,
	["end"] = true,
	["function"] = true,
	["local"] = true
}

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


for w in allwords() do
	if not reserved[w] then
		io.write(w)							-- 'w'不是保留字
	end
end

-- 借助一个辅助函数来创建集合，是初始化变得更清晰
function Set( list )
	local set = {}
	for _, l in ipairs(list) do
		set[l] = true
	end
	return set
end

reserved = Set{"while", "end", "function", "local", }

-- bag sometimes called Multiset

-- increase counter when insert one element
function insert( bag, ele )
	bag[ele] = (bag[ele] or 0) + 1
end

-- decrease counter when delete one element
function remove( bag, ele )
	local count = bag[ele]
	bag[ele] = (count and count > 1) and count - 1 or nil
end
-- retain couter when count exists or greater than zero