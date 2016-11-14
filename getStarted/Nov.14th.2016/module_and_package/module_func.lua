-- @Author: Alan
-- @Date:   2016-11-14 10:46:07
-- @Last Modified by:   Alan
-- @Last Modified time: 2016-11-14 10:50:19


module(..., package.seeall)
--[[
package.seeall <=> setmetatable(M, {__index = _G})
在一个模块文件的开头有了这句调用后，后续所有的代码都可以像普通的lua代码那样
不需要限定模块名和外部的名字，同样也不需要返回模块table
--]]