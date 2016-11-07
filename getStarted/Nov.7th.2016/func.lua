-- @Author: Alan
-- @Date:   2016-11-07 16:36:12
-- @Last Modified by:   Alan
-- @Last Modified time: 2016-11-07 20:45:32

--[[
函数是一种对语句和表达式进行抽象的主要机制
函数既可以完成某项特定的任务，也可以只做一些计算并返回结果
上述第一种情况中，一句函数调用被视为一条语句
第二种情况中，则将其视为一句表达式
--]]

-- multiple results
local s, e = string.find("hello lua world", "lua")
print (s, e)

function maximum( a )
	local mi = 	1
	local m = a[mi]
	for i,v in ipairs(a) do
		if v > m then
			mi = i
			m = v
		end
	end
	return mi, m
end

print (maximum({8, 19, 24, 16, 5}))

print ('**********')

-- variable number of arguments
function add( ... )
	local s = 0
	--[[
	block below could be writed easily into:
	for i,v in ipairs{...} do
		s = s + v
	end

	ipairs() in lua is iterator func, curves could be ellipsis when argument is talbe or string
	--]]
	for i,v in ipairs({...}) do
		s = s + v
	end
	return s
end

print (add(1, 2, 3, 4))

-- multi-value identity func
function id( ... )
	return ...
end

print (id(1, 2))

function fwrite( fmt, ... )
	return io.write(string.format(fmt, ...))
end

fwrite('')
fwrite('a')
fwrite('%d%d', 4, 5)
print ('\n')
function printArgValue( ... )
	for i = 1, select('#', ...) do
		local arg = select(i, ...)
		print (arg)
	end
end

printArgValue(1, 2, 3, 4, 5)

print ('**********')

-- named arguments
--[[
通过名称来指定实参是很有用的，
os.rename(),这个函数用于文件改名，
通常会忘记一个参数是表示新文件名还是旧文件名
希望这个函数可以接受两个具有名称的实参，列如：
-- 无效的代码
rename(old="temp.lua", new="temp1.lua")
Lua并不直接支持这种语法，但可以通过一种细微的改变来获得相同的效果。
另外，还需要用到一种Lua中特殊的函数调用语法，就是当实参只有一个table构造式时，
函数调用中的圆括号是可有可无的：
rename{old="temp.lua", new="temp1.lua"}
此外，将rename改为只接受一个参数，并从这个参数中获取实际的参数：
function rename(arg)
	return os.rename(arg.old, arg.new)
end
--]]
