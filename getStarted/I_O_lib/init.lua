-- @Author: Alan
-- @Date:   2016-11-15 11:12:28
-- @Last Modified by:   Alan
-- @Last Modified time: 2016-11-15 11:15:55


--[[
I/O库为文件操作提供了两种不同的模型，简单模型(simple model)和完整模型(complete mode)
简单模型假设有一个当前输入文件和一个当前输出文件，它的I/O操作均作用与这些文件
完整模型使用显式的文件句柄，采用面向对象的风格，将所有的操作定义为文件句柄上的方法
--]]
