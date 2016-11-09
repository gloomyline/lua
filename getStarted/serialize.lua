-- @Author: Alan
-- @Date:   2016-11-09 09:38:54
-- @Last Modified by:   Alan
-- @Last Modified time: 2016-11-09 10:01:44

--[[
-- @fn:						串行化
-- @o：			[any]		需要串行化的数据
-- @indent:		[int]		缩进空格个数
-- @return：nil 
--]]
function serialize( o, indent )
	if type(o) == 'number' then
		io.write(o)
	elseif type(o) == 'string' then
		io.write(string.format('%q', o))
	elseif type(o) == 'table' then
		io.write('{\n')
		for k,v in pairs(o) do
			io.write(string.rep(" ", indent) .. "["); serialize(k); io.write("] =")
			serialize(v)
			io.write(',\n')
		end
		io.write('}\n')
	else
		error('cannot serialize a' .. type(o))
	end
end