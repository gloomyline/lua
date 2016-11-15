-- @Author: Alan
-- @Date:   2016-11-15 09:46:03
-- @Last Modified by:   Alan
-- @Last Modified time: 2016-11-15 10:23:25


--[[
URL编码，HTTP所使用的一种编码方式，用于在URL中传送参数
这种编码方式会将特殊字符(如'='、'&'、'+')编码为'%<xx>'的形式，<xx>是字符的十六进制
此外，将空格转换为'+'
最后,它会将没对参数及其值用'='连接起来，并对没对结果name=value用'&'连接起来


name = 'al';query = 'a+b = c';q = 'yes or no'
'name=al&query=a%2Bb+%3D+c&q=yes+or+no'
--]]
-- 对URL进行解码，对编码中每个值，以其名称作为key，保存在一个table中
function unescape( s )
	s = s:gsub('+', ' ')
	s = s:gsub('%%(%x%x)', function (h)
			return string.char(tonumber(h, 16))
		end)
	return s
end

print (unescape('name=al&query=a%2Bb+%3D+c&q=yes+or+no'))

-- 使用gmatch对name=value进行解码
cgi = {}
function decode( s )
	for name, value in string.gmatch(s, '([^&=])=([^&=]+)') do
		name = unescape(name)
		value = unescape(value)
		cgi[name] = value
	end
end

print (string.rep('*', 10))

-- URL编码函数
-- 首先，写一个escape函数，将所有特殊字符编码为'%'并百岁该字符的十六进制码，将空格装换为'+'
function escape( s )
	s = string.gsub(s, '[&=+%%%c]', function (c)
			return string.format('%%%02X', string.byte(c))
		end)
	s = string.gsub(s, ' ', '+')
	return s
end
-- encode函数会遍历整个待编码table，构建最终的结果字符串
function encode( t )
	local b = {}
	for k, v in pairs(t) do
		b[#b + 1] = (escape(k) .. '=' .. escape(v))
	end
	return table.concat(b, '&')
end

t = {
	name = 'al',
	query = 'a+b = c',
	q = 'yes or no',
}
print (encode(t))