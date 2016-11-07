-- @Author: Alan
-- @Date:   2016-11-07 14:51:46
-- @Last Modified by:   Alan
-- @Last Modified time: 2016-11-07 16:35:46

-- if then else
local result

--[[
此处使用math.random()函数产生随机40到100之间整数 
无法正常工作 在交互模式下可正常工作 待解决
local score = math.random(40, 100)
--]]
math.randomseed(tostring(os.time()):reverse():sub(1, 6))
local score = math.random(40, 100)
print (score)
if score >= 90 then
	result = '优'
elseif score >= 80 then
	result = '良'
elseif score >= 60 then
	result = '及格'
else
	result = '不及格'
end 

print (result)

print ('**********')

-- while

-- init talbe and put it in a
local a = {}
do
local i = 1
local v = 10
for i=1,10 do
	a[i] = v + i
end
print (a[5])
end

-- iterate table print content
do
local i = 1
while a[i] do
	print (a[i])
	i = i + 1
end
end

print ('**********')

-- repeat
do
local i = 1
repeat
	print (a[i])
	i = i + 1
until a[i] == nil
end

--[[
声明在循环提中的局部变量作用域包括了条件测试
--]]

print ('**********')

-- for (numeric for)
-- 如果不想给循环设置上限的话，可以使用常量math.huge
for i=1,math.huge do
	if(0.3*i^3 - 20*i^2 - 500 >= 0) then
		print (i)
		break
	end
end

-- for (generic for)
-- 通过一个迭代器(iterator)函数来遍历所有的值
local days = {"Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"}
local revDays = {}
for k,v in pairs(days) do
	revDays[v] = k
end

print (revDays['Thursday'])

print ('**********')

-- break and return
--[[
break和return语句用于跳出当前的块
break用于结束一个循环
return用于从一个函数中返回结果
--]]