-- @Author: Alan
-- @Date:   2016-11-14 16:09:58
-- @Last Modified by:   Alan
-- @Last Modified time: 2016-11-14 16:13:36


-- 处理嵌套的字符串数组
function rconcat( l )
	if type(l) ~= "table" then return l end
	local res = {}
	for i = 1, #l do
		res[i] = rconcat(l[i])
	end
	return table.concat(res)
end