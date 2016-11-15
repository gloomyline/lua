-- @Author: Alan
-- @Date:   2016-11-15 10:24:09
-- @Last Modified by:   Alan
-- @Last Modified time: 2016-11-15 11:04:43


-- '()'捕获它在目标字符串中位置，返回一个数字
print (string.match('hello', '()ll()'))

-- 在一个字符串中扩展tab(制表符)                                                                                   
function expandTabs(s, tab)
	tab = tab or 8
	local corr = 0
	s = string.gsub(s, '()\t', function (p)
			local sp = tab - (p - 1 + corr)%tab
			corr = corr - 1 + sp
			return string.rep(' ', sp)
		end)
	return s
end

-- 将空格装换为tab
function unexpandTabs( s, tab )
	tab = tab or 8
	s = expandTabs(s)
	local pat = string.rep('.', tab)
	s = string.gsub(s, pat, '%0\1')
	s = string.gsub(s, ' +\1', '\t')
	s = string.gsub(s, '\l', '')
	return s
end

