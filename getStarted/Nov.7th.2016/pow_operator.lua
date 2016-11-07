-- @Author: Alan
-- @Date:   2016-11-07 14:08:37
-- @Last Modified by:   Alan
-- @Last Modified time: 2016-11-07 14:22:59

--[[
在二元操作夫中，除了指数操作符“^”和连接操作符“..”是“右结合”的，
所有其他的操作符都是“左结合”的
若不确定某些操作符的优先级时，就应显示地用括号来指定所期望的运算次序
--]]

local x = 2
local y = 2
local z = 3
print("x^y^z -->", x^y^z)
print("(x^y)^z -->", (x^y)^z)