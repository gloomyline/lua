-- @Author: Alan
-- @Date:   2016-11-14 15:57:00
-- @Last Modified by:   Alan
-- @Last Modified time: 2016-11-14 16:09:37


-- table.sort

-- 迭代器，根据table key的次序来进行遍历
function pairsByKeys( t, f )
	local a = {}
	for n in pairs(t) do a[#a + 1] n end
	table.sort( a, f )
	local i = 0					-- 迭代器变量
	return function (  )		-- 迭代器函数
		i = i + 1
		return a[i], t[a[i]]
	end
end

-- 通过这个函数就可以很容易地按字母顺序来打印函数名
for name, line in pairsByKeys(lines) do
	print(name, line)
end