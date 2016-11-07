-- @Author: Alan
-- @Date:   2016-11-07 15:55:39
-- @Last Modified by:   Alan
-- @Last Modified time: 2016-11-07 16:09:37

-- notice Lua random
print ('*****1*****')
math.randomseed(os.time())
for i=1,5 do
	print(math.random(0, 100))
end

--[[
此处结果和第一个循环的结果相同，因为随机不是真正的随机
随机种子相同的情况下生成的随机队列也相同
--]]
print ('*****2*****')
math.randomseed(os.time())
for i=1,5 do
	print(math.random(0, 100))
end

--[[
此处结果全相同，主要原因是因为设置的种子数基本相同
导致第一个值全相同
--]]
print ('*****3*****')
for i=1,5 do
	math.randomseed(os.time())
	print(math.random(0, 100))
end

print ('*****4*****')
math.randomseed(tostring(os.time()):reverse():sub(1, 6))
for i=1,5 do
	print(math.random(0, 100))
end
