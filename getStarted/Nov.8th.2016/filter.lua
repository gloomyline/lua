-- @Author: Alan
-- @Date:   2016-11-08 14:38:23
-- @Last Modified by:   Alan
-- @Last Modified time: 2016-11-08 14:51:15

-- 扩展consumer_driven设计，实现“过滤器(filter)”

function receive( prod )
	local status, value = coroutine.resume(prod)
	return value
end

function send( x )
	coroutine.yield(x)
end

function producer(  )
	return coroutine.create(function (  )
		while true do
			local x = io.read()				-- 产生新值
			send(x)
		end
	end)
end

function consumer( prod )
	while true do
		local x = receive(prod)
		io.write(x, '\n')
	end
end

function filter( prod )
	return coroutine.create(
		function (  )
			for line = 1, math.huge do
				local x = receive(prod)		-- 获取新的值
				x = string.format('%5d %s', line, x)
				send(x)
			end
		end
	)
end

consumer(filter(producer()))