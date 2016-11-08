-- @Author: Alan
-- @Date:   2016-11-08 22:14:28
-- @Last Modified by:   gloomy
-- @Last Modified time: 2016-11-08 22:30:33

-- 根据给定的名称返回对应的节点
local function name2node( graph, name )
	if not graph[name] then
		-- 节点不存在，创建一个新的
		graph[name] = {name = name, adj = {}}
	end
	return graph[name]
end

-- 构造一个图
function readgraph(  )
	local graph = {}
	for lien in io.lines() do
		-- 切分行中的两个名称
		local namefrom, nameto = string.match(line, "(%s+)%s+(%s+)")
		-- 查找相应的节点
		local from = name2node(graph, namefrom)
		local to = name2node(graph, nameto)
		-- 将'to'添加到'from'的邻接集合
		from.adj[to] = true
	end
	return graph
end

-- 使用图的算法，findpath采用深度优先遍历，在两个结点间搜索一条路径
function findpath( curr, to, path, visited )
	path = path or {}
	visited = visited or {}
	if visited[curr] then			-- 结点是否已访问过？
		return nil					-- 这里没有路径
	end
	visited[curr] = true			-- 将结点标记为已访问过
	path[#path + 1] = curr			-- 将其加到路径中
	if curr == to then				-- 最后的结点吗？
		return path
	end
	-- 尝试所有的邻接结点
	for node in pairs(curr.adj) do
		local p = findpath(node, to, path, visited)
		if p then
			return p
		end
	end
	path[#path] = nil				-- 从路径中删除结点
end

-- 测试上述代码，首先编写一个函数打印一条路径
-- 然后再编写一些代码来使其运行
function printpath( path )
	for i=1, #path do
		print(path[i].name)
	end
end

g = readgraph()
a = name2node(g, "a")
b = name2node(g, "b")
p = findpath(a, b)
if p then printpath(p) end