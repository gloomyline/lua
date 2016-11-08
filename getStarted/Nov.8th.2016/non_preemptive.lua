-- @Author: Alan
-- @Date:   2016-11-08 16:05:06
-- @Last Modified by:   Alan
-- @Last Modified time: 2016-11-08 17:33:44

-- 1. 加载LuaSocket库
require "socket"

--[[
-- 2. 定义主机和下载的文件
local host = "www.w3.org"
local file = "/TR/REC-html32.html"

-- 3. 打开一个TCP连接，连接到该站点的80端口
-- 这步操作将返回一个连接对象，可以使用它类发送文件请求
c = assert(socket.connect(host, 80))

-- 4. 发送文件请求
c:send("GET" .. file .. " HTTP/1.0\r\n\r\n")

-- 5. 按1K的字节块来接收文件，并将每块写到标准输出：
while true do
	local s, status, partial = c:receive(2^10)
	io.write(s or partial)
	if status == "closed" then break end
end

-- 6. 下载完文件，关闭连接
c:close()

print "**********"
--]]


-- 在以协同程序来重写程序前，先将之前的下载代码封装成一个函数
function download( host, file )
	local c = assert(socket.connect(host, 80))
	local count = 0									-- 记录接收到的字节数
	c:send("GET" .. file .. " HTTP/1.0\r\n\r\n")
	while true do
		local s, status, partial = receive(c)
		count = count + #(s or partial)
		if status == "closed" then break end
	end
	c:close()
	print (file, count)
end

-- 辅助函数receive, 在并发实现中，这个函数接收数据时绝对不能阻塞，需要在没有足够可用数据时挂起执行
function receive( connection )
	connection:settimeout(0)						-- 使receive调用不会阻塞
	local s, status, partial = connection:receive(2^10)
	if status == 'timeout' then
		coroutine.yield(connection)
	end
	return s or partial, status
end

threads = {}										-- 用于记录所有正在运行的线程
function get( host, file )							-- get函数确保每个下载任务都在一个独立的线程中执行
	-- 创建协同程序
	local co = coroutine.create(
		function (  )
			download(host, file)
		end
	)
	-- 将其插入记录表中
	table.insert(threads, co)
end

-- 调度程序，遍历所有线程，逐个唤醒它们的执行。
-- 并且当线程完成任务时，将该线程从列表中删除
function dispatch(  )								
	local i = 1
	local connections = {}
	while true do
		if threads[i] == nil then					-- 判断保存线程表中是否还存在线程
			if threads[1] == nil then break end		-- 列表是否为空
			i = 1									-- 重新开始循环
			connections = {}
		end
		local status, res = coroutine.resume(threads[i])
		if not res then								-- 线程是否已经完成了任务
			table.remove(threads, i)
		else										-- 超时操作
			i = i +1								
			connections[#connections + 1] = res
			if #connections == #threads then		-- 所有线程都阻塞了吗？
				socket.select(connections)
			end
		end
	end
end

-- 主程序需要创建所有的线程，并调用调度程序
host = "www.w3.org"

get(host, "/TR/html401/html40.txt")
get(host, "/TR/2002/REC-xhtml1-20020801/xhtml1.pdf")
get(host, "/TR/REC-html32.html")
get(host, "/TR/2000/REC-DOM-Level-2-Core-20001113/DOM2-Core.txt")

dispatch()											-- 主循环
