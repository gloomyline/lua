-- @Author: Alan
-- @Date:   2016-11-08 19:52:02
-- @Last Modified by:   gloomy
-- @Last Modified time: 2016-11-08 20:32:16



-- 1. 定义一个辅助函数用于输出格式化后的文本
function fwrite( fmt, ... )
	return io.write(string.format(fmt, ...))
end

-- 2. 函数writeHeader只是简单地写出一个始终不变的页面首部
function writeHeader(  )
	io.write([[
		<html>
		<head><title>Projects using Lua</title></head>
		<body bgcolor="#fff">
		Here are brief descriptions of some projects around the world that use <a href="home.html">Lua</a>
		<br>
	]])
end

-- 3. entry的第一个定义，将每个项目的标题以一个列表项目输出，参数o就将是每个描述项目的table
function entry1( o )
	count = count + 1
	local title = o.title or '(no title)'
	fwrite('<li><a href="#%d">%s</a>\n', count, title)
end

-- 4. entry的第二个定义写出所有关于项目的详细数据
function entry2( o )
	count = count + 1
	fwrite('<hr>\n<h3>\n')

	local href = o.url and string.format('href=%s', o.url) or ''
	local title = o.title or o.org or 'org'
	fwrite('<a name="%d"%s</a>\n', count, href, title)

	if o.title and o.org then
		fwrite('<br>\n<small><em>%s</em></small>', o.org)
	end
	fwrite('\n</h3>\n')

	if o.description then
		fwrite('%s<p>\n', string.gsub(o.description, '\n\n+', '<p>\n'))
	end

	if o.email then
		fwrite('Contact:<a href="mailto:%s">%s</a>\n', o.email, o.contact or o.email)
	elseif o.contact then
		fwrite('Contact:%s\n', o.contact)
	end
end

-- 5. writeTail用来结束一个页面
function writeTail(  )
	fwrite('</body></html>\n')
end

-- 6. main program
local inputfile = 'db.lua'
writeHeader()

count = 0
f = loadfile(inputfile)				-- 加载数据文件

entry = entry1						-- 定义'entry'
fwrite('<ul>\n')
f()									-- 运行数据文件
fwrite('</ul>\n')

count = 0
entry = entry2						-- 重定义'entry'
f()									-- 再次运行数据文件

writeTail()