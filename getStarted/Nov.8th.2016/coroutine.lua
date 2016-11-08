-- @Author: Alan
-- @Date:   2016-11-08 11:50:58
-- @Last Modified by:   Alan
-- @Last Modified time: 2016-11-08 14:09:30

--[[
协同程序与线程(thread)差不多，也就是一条执行队列，
拥有自己独立的栈、局部变量和指令指针，
同时又与其他协同程序共享全局变量和其他大部分东西

notes: 后续学习完成之后再回来学习协同程序这一章
--]]

co = coroutine.create(function () print "Hello!" end)
print (co)
print (coroutine.status(co))
coroutine.resume(co)
print (coroutine.status(co))

print ('**********')

-- yield,让运行中的协同程序挂起，而之后可以回复它的运行

co1 = coroutine.create(function (  )
	for i=1,10 do
		print('co1', i)
		coroutine.yield()
	end
end)

coroutine.resume(co1)
print(coroutine.status(co1))
for i=1,10 do
	coroutine.resume(co1)
	print (coroutine.status(co1))
end

-- 协同程序处于死亡状态，试图恢复它的执行，resume将返回false及一条错误信息
print (coroutine.resume(co1))

print ('**********')

-- 第一次调用resume时，所有传递给resume的额外参数都将视为协同程序主函数的参数：
co2 = coroutine.create(function ( a, b, c )
	print ("co2", a, b, c)
end)
print (coroutine.resume(co2, 1, 2, 3))

print ('**********')

-- 在resume调用返回的内容中，第一个值为true则表示没有错误，后面所有的值都是对应yield传入的参数
co3 = coroutine.create(function ( a, b )
	coroutine.yield(a + b, a -b)
end)
print (coroutine.resume(co3, 20, 10))

print ('**********')

-- 与此对应的是，yield返回的额外值就是对应resume传入的参数
co4 = coroutine.create(function (  )
	print ("co", coroutine.yield())
end)
coroutine.resume(co4)
print (coroutine.status(co4))
coroutine.resume(co4, 4, 5)
print (coroutine.status(co4))

print ('**********')

-- 当一个协同程序结束时，它的主函数所返回的值都将作为对应resume的返回值
co5 = coroutine.create(function (  )
	return 6, 7
end)
print (coroutine.resume(co5))