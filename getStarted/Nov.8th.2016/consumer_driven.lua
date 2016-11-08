-- @Author: Alan
-- @Date:   2016-11-08 14:12:06
-- @Last Modified by:   Alan
-- @Last Modified time: 2016-11-08 14:38:12

-- 
consumer = function (  )
	while true do
		local x = receive()			-- 从生成者接收值
		io.write(x, "\n")			-- 消费新的值
	end
end

producer = coroutine.create(
	function (  )
		while true do
			local x = io.read()		-- 产生新的值
			send(x)					-- 发送给消费者
		end
	end
)

function send( x )
	coroutine.yield(x)
end

function receive(  )
	local status, value = coroutine.resume(producer)
	return value
end

consumer()
--[[
在以上代码设计中，程序通过调用消费者来启动。
当消费者需要一个新值是，唤醒生产者。
生产者返回一个新值后停止运行，并等待消费者的再次唤醒。
这种设计称为“消费者驱动(consumer-driven)”
--]]


