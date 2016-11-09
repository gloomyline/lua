-- @Author: Alan
-- @Date:   2016-11-09 09:53:19
-- @Last Modified by:   Alan
-- @Last Modified time: 2016-11-09 10:32:49


function basicSerialize( o )
	if type(o) == 'number' then
		return tostring(o)
	else
		return string.format('%q', o)
	end
end

function save( name, value, saved )
	saved = saved or {}											-- 初始值
	io.write(name, ' = ')
	if type(value) == 'number' or type(value) == 'string' then
		io.write(basicSerialize(value), '\n')
	elseif type(value) == 'table' then
		if saved[value] then									-- 该value是否已保存过
			io.write(saved[value], '\n')	
		else
			saved[value] = name									-- 为下次使用保存名称
			io.write('{}\n')									-- 创建一个新的table
			for k,v in pairs(value) do
				k = basicSerialize(k)							-- 保存其字段
				local fname = string.format('%s[%s]', name, k)
				save(fname, v, saved)
			end
		end
	else
		error('cannot save a' .. type(value))
	end
end

a = {x=1, y=2; {3, 4, 5}}
a[2] = a					-- 环
a.z = a[1]					-- 共享子table

save('a', a)

print (string.rep('*', 10))

-- 共享方式保存几个table中共同部分，调用save时使用相同的saved参数
b = {{"one", "two"}, 3}
c = {k = b[1]}

-- 独立方式保存，结果不会有共同部分
save('b', b)
save('c', c)

print (string.rep('*', 10))

-- 使用同一个saved table来调用save，串行化结果会共享共同部分
local t = {}
save('b', b, t)
save('c', c, t)