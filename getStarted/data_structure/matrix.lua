-- @Author: gloomy
-- @Date:   2016-11-08 21:14:31
-- @Last Modified by:   gloomy
-- @Last Modified time: 2016-11-08 21:26:34


-- 1. 数组的数组
mt = {}					-- 创建矩阵
for i=1, N do
	mt[i] = {}			-- 创建一个新行
	for j=1, M do
		mt[i][j] = 0
	end
end

-- 2. 将两个索引合并为一个索引
-- 如果两个索引是整数，可以将第一个索引乘以一个适当的常量，并加上第二个索引
mt1 = {} 
for i=1, N do
	for j=1, M do
		mt[(i - 1) * M + j] = 0
	end
end

-- 3. 如果索引是字符串，可以把索引拼接起来，中间使用一个字符分割
-- 使用字符串s和t来索引一个矩阵，可以通过代码m[s .. ":" .. t]。
-- 其中，s和t都不能包含冒号

-- 4. 将矩阵的一行与一个常量相乘
function mult( a, rowindex, k )
	local row = a[rowindex]
	for i,v in ipairs(row) do
		row[i] = v * k
	end
end