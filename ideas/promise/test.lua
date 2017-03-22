-- @Author: Alan
-- @Date:   2017-03-15 16:03:34
-- @Last Modified by:   Alan
-- @Last Modified time: 2017-03-15 16:26:26

local Promise = require('src.core')

local NewPromise = Promise:new()

local promise = NewPromise:init(function ( resolve, reject )
	-- Promise.sleep(1, function (  )
		resolve({val='success'})	
	-- end)
end)

promise.thenTo(function ( val )
	print(val)
end)