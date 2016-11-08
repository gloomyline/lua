-- @Author: gloomy
-- @Date:   2016-11-08 22:01:33
-- @Last Modified by:   gloomy
-- @Last Modified time: 2016-11-08 22:14:13

-- 下述算法在读取较大的文件时，会导致极大的性能开销
local buff = ""
for line in io.line() do
	buff = buff .. line .. "\n"
end

-- 使用concat来重写上述循环：
local t = {}
for line in io.lines() do
	t[#t + 1] = line
end
t[#t + 1] = ""
local s = table.concat(t, "\n")

-- 获取栈缓冲中的最终内容，只需连接其中所有的字符串
function addString( stack, s )
	stack[#stack + 1] = s 				-- 将's'压入栈
	for i=#stack - 1, 1, -1 do
		if #stack[i] > #stack[i + 1] then
			break
		end
		stack[i] = stack[i] .. stack[i + 1]
		stack[i + 1] = nil
	end
end