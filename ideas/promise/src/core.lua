-- @Author: Alan
-- @Date:   2017-03-15 13:44:56
-- @Last Modified by:   Alan
-- @Last Modified time: 2017-03-16 10:48:53

require('sleep') 				-- 模拟延时执行
require('exceptions_handling')	-- 异常处理捕获

local Promise = {}

local function resolvePromise( promise2, x, resolve, reject )
	local thenTo
	local thenToCalledOrRaise = false

	if Promise2 == x then
		return reject(error('Chaining cycle detected for promise!'))
	end

	if x.thenTo then
		if x.status == 'pending' then
			x.thenTo(function ( v )
				resolvePromise(promise2, v, resolve, reject)
			end, reject)
		else
			x.thenTo(resolve, reject)
		end

		return 
	end

	if ((x ~= nil) and ((type(x) == 'table') or (type(x) == 'function'))) then
		try{
			function (  )
				thenTo = x.thenTo
				if type(thenTo == 'function') then
					x.thenTo(function(val) 
						if thenToCalledOrRaise then 
							return 
						end
						thenToCalledOrRaise = true	
						return resolvePromise(promise2, val, resolve, reject)
					end, function ( reason )
						if thenToCalledOrRaise then
							return
						end
						thenToCalledOrRaise = true
						return reject(reason)
					end)
				else
					resolve(x)
				end	
			end,
			catch{
				function ( reason )
					if thenToCalledOrRaise then
						return
					end
					return reject(reason)
				end
			}
		}
	else
		resolve(x)
	end
end

function Promise:init( executor )
	self.status = 'pending'
	self.onResolvedCallback = {}
	self.onRejectedCallback = {}

	local function resolve( value )
		if value.thenTo then
			return value.thenTo(resolve, reject)
		end

		sleep(0, function (  ) -- 异步执行所有的回调函数
			if self.status == 'pending' then
				self.status = 'resolved'
				self.data = value
				for i = 1, #self.onResolvedCallback do
					self.onResolvedCallback[i](value)
				end
			end
		end)
	end

	local function reject( reason )
		sleep(0, function (  )
			if self.status == 'pending' then
				self.status = 'rejected'
				self.data = reason
				for i = 1, #self.onRejectedCallback do
					self.onRejectedCallback[i](reason)
				end
			end
		end)
	end

	try{
		function (  )
			excutor(resolve, reject)
		end,

		catch{
			function ( reason )
				reject(reason)
			end
		}
	}
end

function Promise:thenTo( onResolved, onRejected )
	local promise2, onResolved, onRejected
	if type(onResolved) == 'function' then
		onResolved = onResolved
	else
		onResolved = function ( v )
			return v
		end
	end
	if type(onRejected) == 'function' then
		onRejected = onRejected
	else
		onRejected = function ( r )
			return r
		end
	end

	local promise = Promise:new()

	if self.status == 'resolved' then
		promise2 = promise:init(function(resolve, reject)
				sleep(0, function (  )
					try{
						function (  )
								local x = onResolved(self.data)
								resolvePromise(promise2)
						end,
						catch{
							function ( reason )
								reject(reason)
							end
						}
					}
				end)
			end)
		return promise2
	end

	if self.status == 'rejected' then
		promise2 = promise:init(function ( resolve, reject )
			sleep(0, function (  )
				try{
					function (  )
						local x = onRejected(self.data)
						resolvePromise(promise2, x, resolve, reject)
					end,
					catch{
						function ( reason )
							reject(reason)
						end
					}
				}
			end)
		end)
		return promise2
	end

	if self.status == 'pending' then
		promise2 = promise:init(function ( resolve, reject )
			table.insert(self.onResolvedCallback, function ( value )
				try{
					function (  )
						local x = onResolved(value)
						resolvePromise(promise2, x, resolve, reject)
					end,
					catch{
						function ( reason )
							reject(reason)
						end
					}
				}
			end)

			table.insert(self.onRejectedCallback, function ( reason )
				try{
					function (  )
						local x = onRejected(reason)
						resolvePromise(promise2, x, resolve, reject)
					end,
					catch{
						function ( r )
							reject(r)
						end
					}
				}
			end)
		end)
	end
end

function Promise:catch( onRejected )
	return self.thenTo(null, onRejected)
end

function Promise:new(o)
	o = o or {}
	setmetatable( o, self )
	self.__index = self
	return o
end

-- sleep(3, function (  )
-- 	print('11111')
-- end)

-- try{
-- 	function (  )
-- 		error('ops')
-- 	end,
-- 	catch{
-- 		function ( err )
-- 			print('caught error:' .. err )
-- 		end
-- 	}	
-- }

-- TODO : test
local NewPromise = Promise:new()

local promise = NewPromise:init(function ( resolve, reject )
	sleep(1, function (  )
		resolve('success')
		print(val)	
	end)
end)

promise.thenTo(function ( val )
	-- print(val)
	if val == 'success' then
		NewPromise:init(function ( resolve, reject )
			sleep(1, function (  )
				resolve('success1')
			end)
		end)
	end
end)
	.thenTo(function ( val )
		print (val)
	end)

-- expected result
--[[
1. 执行异步操作
2. 等待操作完成，传出操作结果
3. 如果有异步操作，继续执行重复1、2操作
4.输出结果
--]]

-- test end

return Promise