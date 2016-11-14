-- @Author: Alan
-- @Date:   2016-11-14 16:17:09
-- @Last Modified by:   Alan
-- @Last Modified time: 2016-11-14 16:55:00

-- string.len(s)可返回字符串s长度
local s = 'test'
print (string.len(s))
print (s:len())
print (#s)

-- string.rep(s, n)或者string:rep(n)可返回字符串s重复n次的结果
print (s:rep(10))

-- string.lower(s)可返回一份s的副本，其中所有的大写字母都被转换成小写形式，其他字符保持不变
-- string.upper(s)与之相反，小写转换成大写
print (s:upper())

-- string.sub(s, i, j)可以从字符串s中提取地i到第j个字符

-- string.char和string.byte用于转换字符及其内部数值表示
-- string.char函数接受零个或多个整数，并将每个整数转换成对应的字符，然后返回一个由这些字符连接而成的字符串
-- string.byte(s, i)返回字符串s中第i字符的内部数值表示，调用string.byte(s, i, j)可以返回所以i到j之间(包括i和j)的所有字符串的内部值

--[[
string.format用于格式化字符串的利器，经常用在输出上
根据第一个参数的描述，返回后续其他参数的格式化版本，第一个参数也称为'格式化字符串'
编写格式化字符串规则，由常规文本和指示(directive)组成，指示控制了每个参数应放到格式化结果的什么位置
一个指示有字符'%'加上一个字母组成，这些字母指定了如何格式化参数，'d'用于十进制数、'x'用于十六进制数、
'o'八进制数、'f'浮点数、's'用于字符串
--]]
print (string.format('pi = %.4f', math.pi))
print (string.format('%02d/%02d/%04d', '1', '14', '2016'))
print (string.format('<%s>%s</%s>', 'h1', 'a title', 'h1'))