-- @Author: Alan
-- @Date:   2016-11-15 11:16:23
-- @Last Modified by:   Alan
-- @Last Modified time: 2016-11-15 11:27:58


--[[
simple mode所有操作都作用于两个当前文件。
I/O库将当前输入文件初始化为进程标准输入(stdin)
将当前输出文件初始化为进程标准输出(stdout)
在执行io.read()操作时，就会从标准输入中读取一行

io.input和io.output可以改变这两个当前文件
io.input(filename)调用会以只读模式打开指定的文件，并将其设为当前输入文件
之后除非再次调用io.input，否则所有的输入都将来源于这个文件
在输出方面,io.output也可以完成类似操作
如果出现错误,这两个函数都会引发(raise)错误，如果相处理这些错误，必须使用完整模型中的io.open

io.write接受任意数量的字符串参数，并将它们写入当前的输出文件，可以接受数字参数，会根据常规转换规则转换为字符串
想要完全地控制转换，使用string.format
实际操作中应当避免使用连接操作，提高效率
无论使用io.write还是print都有一个原则，随意编写(quick-and-dirty)程序中，或者为调试目的而编写的代码中，提倡使用print
在其他需要完全控制输出的地方使用io.write
--]]
