-- @Author: Alan
-- @Date:   2016-11-08 09:33:14
-- @Last Modified by:   Alan
-- @Last Modified time: 2016-11-08 10:41:58

-- iterator and closure
function allWords(  )
	local line = io.read() 							-- 当前行
	local pos = 1									-- 一行中当前位置
	return function (  )							-- 迭代器函数
		while line do								-- 若为有效的行内容进入循环
			local s, e = string.find(line, '%w+', pos)
			if s then
				pos = e + 1							-- 该单词的下一个位置
				return string.sub(line, s, e)		-- 返回该单词
			else
				line = io.read()					-- 没有找到单词，尝试下一行
				pos = 1								-- 在第一个位置重新开始
			end
		end
		return nil									-- 返回nil，遍历结束
	end
end

for word in allWords() do
	print (word)
end

-- generic for semantics
-- 泛型for在循环过程中内部保存了迭代器函数
-- 一个迭代器函数，一个恒定状态(invariant state)和一个控制变量(control variable)

-- non-state-iterator

-- complex-state-iterator

-- 重写allWords迭代器
local iterator
function all(  )
	local state = {line = io.read(), pos = 1}
	return iterator, state
end

function iterator(  )
	while state.line do
		local s, e = string.find(state.line, '%w+', state.pos)
		if s then
			state.pos = e + 1
			return string.sub(state.line, s, e)
		else
			state.lien = io.read()
			state.pos = 1
		end
	end
	return nil
end

-- true iterator not generator
function allWords( f )
	for line in io.lines() do
		for word in string.gmatch(line, '%w+') do
			f(word)
		end
	end
end

-- 使用这个迭代器时，需要传入一个描述循环体的函数
-- 只想打印每个单词，可以使用print
allWords(print)