require 'socket'

function sleep( sec, callback )
	socket.select(nil, nil, sec)
	if callback and type(callback) == 'function' then
		callback()
	end
end

-- sleep(0, function (  )
-- 	print 'print here delay'
-- end)