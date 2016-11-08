-- @Author: Alan
-- @Date:   2016-11-08 15:24:56
-- @Last Modified by:   Alan
-- @Last Modified time: 2016-11-08 16:04:20

--[[
将循环迭代器视为“生产者——消费者”模式的一种特例，
一个迭代器会产出一些内容，而循环体则会消费这些内容
--]]

--[[
下面的这个迭代器，可以遍历某个数组的所有排列组合形式。
使用递归函数来产生所有的排列组合，只要将每个数组元素都一次放到最后一个位置，
然后递归地生成其余元素的排列。
--]]
function permgen( a, n )
	n = n or #a							-- 默认n为a的大小
	if n <= 1 then						-- 还需改变吗？
		printResult(a)
	else
		for i = 1, n do
			a[n], a[i] = a[i], a[n] 	-- 将第i个元素放到数组末尾
			permgen(a, n - 1)			-- 生成其余元素的排列
			a[n], a[i] = a[i], a[n]		-- 恢复第i个元素
		end
	end
end

-- 输出数组的内容
function printResult( a )
	for i=1,#a do
		io.write(a[i], ' ')
	end
	io.write('\n')
end

permgen{1, 2, 3, 4}

print '**********'
-- 将printResult该为yield
function permgen1( a, n )
	n = n or #a
	if n <=1 then
		coroutine.yield(a)
	else
		for i = 1, n do
			a[i], a[n] = a[n], a[i]
			permgen1(a, n - 1)
			a[n], a[i] = a[i], a[n]
		end
	end
end

-- 定义一个工厂函数，生成函数放到一个协同程序中运行
-- 并创建迭代器函数，作用是唤醒协同程序，让其产生下一种排列
function permutations( a )
	local co = coroutine.create(function (  )
		permgen1(a)
	end)
	return function ()			-- 迭代器
		local code, res = coroutine.resume(co)
		return res
	end
end

-- 使用coroutine.wrap重写上述函数permutations
-- function permutations( a )
-- 	return coroutine.wrap(function (  )
-- 		permgen1(a)
-- 	end)
-- end
--[[
总结：
coroutine.wrap比coroutine.create更易于使用，
提供了一个对于协同程序编程实际所需的功能
即一个可以唤醒协同程序的函数。
但也缺乏灵活性，无法检查wrap所创建的协同程序的状态，
此外，也无法检测出运行时的错误
--]]

-- 在for语句中遍历一个数组的所有排列
for p in permutations{'a', 'b', 'c'} do
	printResult(p)
end