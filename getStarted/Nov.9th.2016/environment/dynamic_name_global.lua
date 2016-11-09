-- @Author: Alan
-- @Date:   2016-11-09 22:37:01
-- @Last Modified by:   gloomy
-- @Last Modified time: 2016-11-09 22:45:35


function getfield( f )
	local v = _G				-- 从全局变量的table开始
	for w in string.gmatch(f, "[%w_]+") do
		v = v[w]
	end
	return v
end

function setfield( f, v )
	local t = _G				-- 从全局变量table开始
	for w, d in string.gmatch(f, "([%w_]+)(%.?)") do
		if d == "." then		-- 最后一个字段
			t[w] = t[w] or {}	-- 如果不存在就创建table
			t = t[w]			-- 获取该table
		else
			t[w] = v 			-- 完成赋值
		end
	end
end

-- 调用setfield函数，创建两个table：全局t和t.x，并将10赋予t.x.y
setfield("t.x.y", 10)
print(getfield("t.x.y"))