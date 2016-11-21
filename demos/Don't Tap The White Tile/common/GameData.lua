-- @Author: Alan
-- @Date:   2016-11-18 16:03:22
-- @Last Modified by:   Alan
-- @Last Modified time: 2016-11-18 16:28:05
local GameData = {}

GameData.score = 0			-- 游戏分数
GameData.row = 0			-- 行数
GameData.col = 0			-- 列数
GameData.speed = 0			-- 琴键移动速度

GameData.boxWidth = 0		-- 块宽
GameData.boxHeight = 0		-- 块高

-- get scores
function GameData.getScore(  )
	return GameData.score
end

-- set scores
function GameData.setScore( val )
	GameData.score = val
	GameData.speed = GameData.score + 1
end

-- get boxWidth
function GameData.getBoxWidth(  )
	if GameData.boxWidth == 0 then
		GameData.boxWidth = display.contentWidth / GameData.col
	end
	return GameData.boxWidth
end

-- get boxHeight
function GameData.getBoxHeight(  )
	if GameData.boxHeight == 0 then
		GameData.boxHeight = display.contentHeight / GameData.row
	end
	return GameData.boxHeight
end

return GameData
