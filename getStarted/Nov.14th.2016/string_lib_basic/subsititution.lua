-- @Author: Alan
-- @Date:   2016-11-15 09:10:55
-- @Last Modified by:   Alan
-- @Last Modified time: 2016-11-15 09:44:23


--[[
string.gsub函数的第三个参数不仅是一个字符串，还可以是一个table或函数
当用一个函数来调用时，string.gsub会在每次找到匹配时调用该函数，调用时的参数就是捕获到的内容，该函数的返回值作为替换的字符串
当用一个table来调用是，string.gsub会用每次捕获到的内容作为key，在table中进行查找，并将对应的value作为要替换的内容
--]]
function expand( s )
	local res
	res = string.gsub(s, '$(%w+)', _G)
	return res
end

name = 'Lua';othername = 'Node'
status = 'Great'
print (expand('$name is $status,isn\'t it'))
print (expand('$othername is $status,isn\'t it'))

-- 不确定所有的变量都有一个对应的字符串值，可以对它们引用tostring
function expand1( s )
	return (string.gsub(s, '$(%w+)', function(n) return tostring(_G[n]) end))
end
print (expand1('print = $print;a = $a'))

-- 将LaTex风格命令(\example{text})转换成XML风格(<example>text</example>),允许嵌套命令
function toxml( s )
	s = string.gsub(s, '\\(%a+)(%b{})', function (tag, body)
			body = body:sub(2, -2)				-- 递归body前删除花括号
			body = toxml(body)					-- 递归处理body
			return string.format('<%s>%s</%s>', tag, body, tag)
		end)
	return s
end
print (toxml('\\title{The \\bold{big} example}'))