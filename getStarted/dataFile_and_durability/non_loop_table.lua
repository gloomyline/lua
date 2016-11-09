-- @Author: Alan
-- @Date:   2016-11-09 09:34:05
-- @Last Modified by:   Alan
-- @Last Modified time: 2016-11-09 09:44:20


function serialize( o )
	if type(o) == 'number' then
		io.write(o)
	elseif type(o) == 'string' then
		io.write(string.format('%q', o))
	elseif type(o) == 'table' then
		io.write('{\n')
		for k,v in pairs(o) do
			-- io.write("	", k, "=") 为了解决key是数字或者非法Lua标识符 修改为
			io.write("	["); serialize(k); io.write("] =")
			serialize(v)
			io.write(',\n')
		end
		io.write('}\n')
	else
		error('cannot serialize a' .. type(o))
	end
end