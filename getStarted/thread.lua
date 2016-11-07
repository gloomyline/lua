-- @Author: Alan
-- @Date:   2016-11-06 09:03:48
-- @Last Modified by:   Alan
-- @Last Modified time: 2016-11-06 10:02:01

function foo (a)
	print("foo", a)
	return coroutine.yield(2*a)
end

co = coroutine.create(function (a,b)
	print("co-body", a, b)
	local r = foo(a+1)
	print("co-body", r)
	local r, s = coroutine.yield(a+b, a-b)
	print("co-body", r, s)
	return b, "end"
end)

print("main", coroutine.resume(co, 1, 10))
print("main", coroutine.resume(co, "r"))
print("main", coroutine.resume(co, "x", "y"))
print("main", coroutine.resume(co, "x", "y"))

--[[调用函数 coroutine.create 可创建一个协程。 其唯一的参数是该协程的主函数。 create 函数只负责新建一个协程并返回其句柄 （一个 thread 类型的对象）； 而不会启动该协程。

调用 coroutine.resume 函数执行一个协程。 第一次调用 coroutine.resume 时，第一个参数应传入 coroutine.create 返回的线程对象，然后协程从其主函数的第一行开始执行。 传递给 coroutine.resume 的其他参数将作为协程主函数的参数传入。 协程启动之后，将一直运行到它终止或 让出。

协程的运行可能被两种方式终止： 正常途径是主函数返回 （显式返回或运行完最后一条指令）； 非正常途径是发生了一个未被捕获的错误。 对于正常结束， coroutine.resume 将返回 true， 并接上协程主函数的返回值。 当错误发生时， coroutine.resume 将返回 false 与错误消息。

通过调用 coroutine.yield 使协程暂停执行，让出执行权。 协程让出时，对应的最近 coroutine.resume 函数会立刻返回，即使该让出操作发生在内嵌函数调用中 （即不在主函数，但在主函数直接或间接调用的函数内部）。 在协程让出的情况下， coroutine.resume 也会返回 true， 并加上传给 coroutine.yield 的参数。 当下次重启同一个协程时， 协程会接着从让出点继续执行。 调用coroutine.yield 会返回任何传给 coroutine.resume 的第一个参数之外的其他参数。

与 coroutine.create 类似， coroutine.wrap 函数也会创建一个协程。 不同之处在于，它不返回协程本身，而是返回一个函数。 调用这个函数将启动该协程。 传递给该函数的任何参数均当作 coroutine.resume 的额外参数。 coroutine.wrap 返回 coroutine.resume 的所有返回值，除了第一个返回值（布尔型的错误码）。 和 coroutine.resume 不同， coroutine.wrap 不会捕获错误； 而是将任何错误都传播给调用者。
--]]