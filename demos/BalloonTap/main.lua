-- @Author: Alan
-- @Date:   2016-11-15 23:44:03
-- @Last Modified by:   Alan
-- @Last Modified time: 2016-11-16 01:09:44
-----------------------------------------------------------------------------------------
--
-- main.lua
--
-----------------------------------------------------------------------------------------


-- adding Physics and start it
local physics = require('physics')
physics.start()

-- get widget
local widget = require('widget')

-- get center point position
local cx = display.contentCenterX
local cy = display.contentCenterY
-- get width/height of stage
local sW = display.contentWidth
local sH = display.contentHeight

-- load background
local background = display.newImageRect('assets/background.png', 360, 570 )
background.x = cx
background.y = cy
-- load platform
local platform = display.newImageRect('assets/platform.png', 300, 50)
platform.x = cx
platform.y = sH - 25
physics.addBody(platform, 'static')
platform.myName = 'platform'

-- textfiled
local tapCount = 0
local tapText = display.newText(tapCount, cx, 20, native.systemFont, 40)
local tx = tapText.x
local ty = tapText.y
tapText:setFillColor(0, 0, 0)	

-- load the balloon
local balloon = display.newImageRect('assets/balloon.png', 112, 112)
balloon.x = cx
balloon.y = cy
balloon.alpha = 0.8
physics.addBody(balloon, 'dynamic', {radius = 55, bounce = 0.3})
balloon.myName = 'balloon'

local function pushBalloon(  )
	balloon:applyLinearImpulse(0, -0.75, balloon.x, balloon.y)
	tapCount = tapCount + 1
	tapText.text = tapCount
end
balloon:addEventListener('tap', pushBalloon)

local function showGameOver()
	local gameOverPanel = display.newGroup()
	gameOverPanel.x = cx 
	gameOverPanel.y = cy - 80
	local gameOverPanelBg = display.newRect(0, 0, 180, 120)
	gameOverPanelBg:setFillColor(0, 0, 0)
	gameOverPanel:insert(gameOverPanelBg)
	local gameOverTxt = display.newText('GAME OVER', 0, -20, native.systemFont, 20)
	gameOverPanel:insert(gameOverTxt)

	local function handleButtonEvent(event)
		if (event.phase == 'began') then
			print ('button was tapped!')
			if gameOverPanel then
				-- cannot remove the group, it is needed to solve immediately
				display.remove(gameOverPanel) 
				gameOverPanel = nil
				-- gameOverPanel:removeSelf()
				tapCount = 0
				tapText.text = tapCount
				balloon.y = cy
				balloon:addEventListener('tap', pushBalloon)
			end
		end
	end

	local restartBtn = widget.newButton(
		{
			left = -90,
	        top = 0,
	        id = "rBtn",
	        label = "Restart",
	        onEvent = handleButtonEvent
		}
	)
	gameOverPanel:insert(restartBtn) 
end

local function onLocalCollision( self, event )
    if ( event.phase == "began" ) then
        -- print( self.myName .. ": collision began with " .. event.other.myName )
        showGameOver()
        balloon:removeEventListener('tap', pushBalloon)
    end

    -- elseif ( event.phase == "ended" ) then
    --     print( self.myName .. ": collision ended with " .. event.other.myName )
    -- end
end

platform.collision = onLocalCollision
platform:addEventListener( "collision" )

-- balloon.collision = onLocalCollision
-- balloon:addEventListener( "collision" )



