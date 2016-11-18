-----------------------------------------------------------------------------------------
--
-- main.lua
--
-----------------------------------------------------------------------------------------

-- Your code here

local function listener( event )
	print 'listener called'
end

local _timer = timer.performWithDelay(3000, listener)

for k,v in pairs(_timer) do
	print(k,v)
end
-- ...

local result = timer.pause(_timer)
print (result)

for k,v in pairs(_timer) do
	print(k,v)
end