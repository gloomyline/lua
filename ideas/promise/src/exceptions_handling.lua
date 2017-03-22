-- @Author: Alan
-- @Date:   2017-03-15 14:54:49
-- @Last Modified by:   Alan
-- @Last Modified time: 2017-03-15 16:33:04

function catch( what )
	return what[1]
end

function try( what )
	local status, result = pcall(what[1])
	if not status then
		what[2](result)
	end
	return result
end

-- try {
-- 	function()
-- 		error('ops')
-- 	end,

-- 	catch{
-- 		function ( error )
-- 			print ('caught error:' .. error)
-- 		end
-- 	}
-- }