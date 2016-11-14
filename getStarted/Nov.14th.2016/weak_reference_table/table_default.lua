-- @Author: Alan
-- @Date:   2016-11-14 13:45:07
-- @Last Modified by:   Alan
-- @Last Modified time: 2016-11-14 13:57:12


-- 弱引用table，通过它将每个table与其默认值关联起来
local defaults = {}
setmetatable(defaults, {__mode = "k"})
local mt = {__index = function ( t ) return defaults[t] end}
function setDefault( t, d )
	defaults[t] = d
	setmetatable (t, mt)
end

-- 对每种不同的默认值使用不同的元表
local metas = {}
setmetatable(metas, {__mode = "v"})
function setDefault	( t, d )
	local mt = metas[d]
	if mt == nil then
		mt = {__index = function() return d end}
		metas[d] = mt  					-- 备忘录
	end
	setmetatable(t, mt)
end