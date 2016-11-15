-----------------------------------------------------------------------------------------
--
-- main.lua
--
-----------------------------------------------------------------------------------------

-- adding Physics and start it
local physics = require('physics')
physics.start()

-- load background
local background = display.newImageRect('assets/background.png', 360, 570 )
background.x = display.contentCenterX
background.y = display.contentCenterY

-- load platform
local platform = display.newImageRect('assets/platform.png', 300, 50)
platform.x = display.contentCenterX
platform.y = display.contentHeight - 25
physics.addBody(platform, 'static')

-- textfiled
local tapCount = 0
local tapText = display.newText(tapCount, display.contentCenterX, 20, native.systemFont, 40)
tapText:setFillColor(0, 0, 0)

-- load the balloon
local balloon = display.newImageRect('assets/balloon.png', 112, 112)
balloon.x = display.contentCenterX
balloon.y = display.contentCenterY
balloon.alpha = 0.8
physics.addBody(balloon, 'dynamic', {radius = 55, bounce = 0.3})

local function pushBalloon(  )
	balloon:applyLinearImpulse(0, -0.75, balloon.x, balloon.y)
	tapCount = tapCount + 1
	tapText.text = tapCount
	isDownToBottom()
end
balloon:addEventListener('tap', pushBalloon)

local balloonBottom = display.contentHeight - 25
function isDownToBottom()
	print (balloon.y)
	if (balloon.y + balloon.height) >= balloonBottom then
		local tx = tapText.x
		local ty = tapText.y
		display.remove(tapText)
		local gameOverText = display.newText('GAME OVER', tx, ty, native.systemFont, 40)
	end
end
isDownToBottom()



