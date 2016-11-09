-- @Author: Alan
-- @Date:   2016-11-09 15:10:17
-- @Last Modified by:   Alan
-- @Last Modified time: 2016-11-09 15:12:26


local meta = require('../arithmetic_metamethod')
local Set = meta.Set
local mt = meta.mt

mt.__tostring = Set.tostring

s1 = Set.new{10, 4, 5}
print (s1)