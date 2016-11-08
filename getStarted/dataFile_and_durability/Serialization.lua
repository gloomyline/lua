-- @Author: gloomy
-- @Date:   2016-11-08 22:54:53
-- @Last Modified by:   gloomy
-- @Last Modified time: 2016-11-08 23:15:54


-- 创建一个值
function serialize( o )
	if type(o) == "number" then
		io.write(o)
	elseif type(0) == "string" then
		-- io.write("'", o, "'")
		-- io.write("[[", o, "]]")
		io.write(string.format("%q", o))
	end
	return
end

function printNAsterisk( n )
	print (string.rep("*", n))
end

printNAsterisk(10)

for i=1,10 do
	printNAsterisk(i)
end