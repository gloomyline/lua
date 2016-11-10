-- @Author: Alan
-- @Date:   2016-11-10 20:28:35
-- @Last Modified by:   Alan
-- @Last Modified time: 2016-11-10 21:51:19


-- 1. 以下代码详细说明了require的行为：
function require( name )
	if not package.loaded[name] then				-- 模块是否已加载
		local loader = findloader(name)			

		if loader == nil then
			error('unable to load module' .. name)	-- 无法加载
		end

		package.loaded[name] = true					-- 将模块标记为已加载
		local res = loader(name) 					-- 初始化模块

		if res ~= nil then
			package.loaded[name] = res
		end
	end
	return package.loaded[name]
end

--[[
总结：
1. 首先，它在table package.loaded中检查模块是否已加载。
2. 如果是的话，require就返回相应的值，因此，只要一个模块已加载，后续的require调用都将返回同一个值，不会再次加载它
3. 如果模块尚未加载，require就试着为该模块找一个加载器(loader),会在table package.preload中查询传入的模块名。如果找到了一个函数，就以该函数作为模块的加载器。
4. 通过这个preload table,就有一种通用的方法来处理各种不同的情况。通常这个table中不会找到有关指定模块的条目，那么require就会尝试从Lua文件或C程序库中加载模块
5. 如果require为指定模块找到了一个Lua文件，它就通过loadfile来加载该文件，而如果找到一个C程序库，就通过loadlib来加载
6. loadfile和loadlib都只是加载了代码，并没有运行它们。为了运行代码，require会以模块名作为参数来调用这些代码。
7. 如果加载器有返回值，require就将这个返回值存储到table package.loaded中，以此作为将来对同意模块调用的返回值。
8. 如果加载其没有返回值，require就会返回table package.loaded中的值。

关于LUA_PATH:
1. 当Lua启动后，便以环境变量LUA_PATH的值来初始化这个变量
2. 如果没有找到该环境变量，则使用一个编译时定义的默认路径来初始化。
3.在使用LUA_PATH时，Lua会将其中所有的字串“;;”替换为默认路径
--]]