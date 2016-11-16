
local composer = require( "composer" )

local scene = composer.newScene()

-- -----------------------------------------------------------------------------------
-- Code outside of the scene event functions below will only be executed ONCE unless
-- the scene is removed entirely (not recycled) via "composer.removeScene()"
-- -----------------------------------------------------------------------------------
local bgMusic

local background
local settingsHeader
local soundTxt
local soundSwitchBtn
local returnBtn

local function returnToMenu(  )
	composer.removeScene('menu')
	composer.gotoScene('menu', 
		{time = 800, effect = 'crossFade'}
	)
end

local function switchTheSound(  )
	if isSoundOn then
		isSoundOn = false
		soundSwitchBtn.text = 'Turn On'
		if bgMusic and bgMusic ~= nil then
			sfx:pause(bgMusic)
		end
	else
		isSoundOn = true
		soundSwitchBtn.text = 'Turn Off'
		if bgMusic and bgMusic ~= nil then
			sfx:resume(bgMusic)
		elseif not bgMusic then		
			bgMusic = sfx:play('bgHighScores', {loops = -1})
		end
	end
end

-- -----------------------------------------------------------------------------------
-- Scene event functions
-- -----------------------------------------------------------------------------------

-- create()
function scene:create( event )

	local sceneGroup = self.view
	-- Code here runs when the scene is first created but has not yet appeared on screen
	local background = display.newImageRect(sceneGroup, 'assets/background.png', 800, 1400)
	background.x = cX
	background.y = cY

	settingsHeader = display.newText(sceneGroup, 'Settings', cX, cY - 100, native.systemFont, 40)
	settingsHeader:setFillColor(0.7)

	soundTxt = display.newText(sceneGroup, 'Sounds:', cX - 180, cY + 100, native.systemFont, 40)
	soundTxt:setFillColor(0.7)
	soundTxt.anchorX = 1

	local soundSwitchBtnTxt
	if isSoundOn then
		soundSwitchBtnTxt = 'Turn Off'
	else
		soundSwitchBtnTxt = 'Turn On'
	end
	soundSwitchBtn = display.newText(sceneGroup, soundSwitchBtnTxt, cX + 100, cY + 100, native.systemFont, 40)
	soundSwitchBtn:setFillColor(0.7)
	soundTxt.anchorX = 0

	returnBtn = display.newText(sceneGroup, 'Return', cX, cY + 240, native.systemFont, 40)
	returnBtn:setFillColor(0.7)

	soundSwitchBtn:addEventListener('tap', switchTheSound)
	returnBtn:addEventListener('tap', returnToMenu)
end


-- show()
function scene:show( event )

	local sceneGroup = self.view
	local phase = event.phase

	if ( phase == "will" ) then
		-- Code here runs when the scene is still off screen (but is about to come on screen)

	elseif ( phase == "did" ) then
		-- Code here runs when the scene is entirely on screen
		bgMusic = sfx:play('bgHighScores', {loops = -1})
	end
end


-- hide()
function scene:hide( event )

	local sceneGroup = self.view
	local phase = event.phase

	if ( phase == "will" ) then
		-- Code here runs when the scene is on screen (but is about to go off screen)

	elseif ( phase == "did" ) then
		-- Code here runs immediately after the scene goes entirely off screen
		sfx:stop(bgMusic)
	end
end


-- destroy()
function scene:destroy( event )

	local sceneGroup = self.view
	-- Code here runs prior to the removal of scene's view
	sfx:dispose(bgMusic)
end


-- -----------------------------------------------------------------------------------
-- Scene event function listeners
-- -----------------------------------------------------------------------------------
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )
-- -----------------------------------------------------------------------------------

return scene
