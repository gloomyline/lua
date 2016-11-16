
local composer = require( "composer" )

local scene = composer.newScene()

-- -----------------------------------------------------------------------------------
-- Code outside of the scene event functions below will only be executed ONCE unless
-- the scene is removed entirely (not recycled) via "composer.removeScene()"
-- -----------------------------------------------------------------------------------

-- declare the bgMusic of this scene
local bgMusic

local function gotoGame(  )
	composer.removeScene('game')
	composer.gotoScene('game', 
		{
			time = 800, 
			effect = 'crossFade',
		}
	)
end

local function gotoSettings(  )
	composer.removeScene('settings')
	composer.gotoScene('settings', 
		{
			time = 800, 
			effect = 'crossFade',
		}
	)
end

local function gotoHighScores(  )
	composer.removeScene('highScores')
	composer.gotoScene('highScores', 
		{
			time = 800,
			effect = 'crossFade',
		}
	)
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

	local title = display.newImageRect(sceneGroup, 'assets/title.png', 500, 80)
	title.x = cX
	title.y = 240

	local playBtn = display.newText(sceneGroup, 'Play', cX, 600, native.systemFont, 40)
	playBtn:setFillColor(0.82, 0.86, 1)

	local settingsBtn = display.newText(sceneGroup, 'Settings', cX, 700, native.systemFont, 40)
	settingsBtn:setFillColor(0.75, 0.80, 1)

	local highScoresBtn = display.newText(sceneGroup, 'HighScores', cX, 800, native.systemFont, 40)
	highScoresBtn:setFillColor(0.75, 0.78, 1)

	playBtn:addEventListener('tap', gotoGame)
	settingsBtn:addEventListener('tap', gotoSettings)
	highScoresBtn:addEventListener('tap', gotoHighScores)

	-- bgMusic = audio.loadStream('audio/Midnight-Crawlers_Looping.wav')
end

-- show()
function scene:show( event )

	local sceneGroup = self.view
	local phase = event.phase

	if ( phase == "will" ) then
		-- Code here runs when the scene is still off screen (but is about to come on screen)

	elseif ( phase == "did" ) then
		-- Code here runs when the scene is entirely on screen

		-- start bgMusic
		-- audio.play(bgMusic, {channel = 2, loops = -1})
		bgMusic = sfx:play('bgMenu', {loops = -1})
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

		-- stop bgMusic
		-- audio.stop(2)
		sfx:stop(bgMusic)
	end
end


-- destroy()
function scene:destroy( event )

	local sceneGroup = self.view
	-- Code here runs prior to the removal of scene's view

	-- dispose bgMusic
	audio.dispose(bgMusic)
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