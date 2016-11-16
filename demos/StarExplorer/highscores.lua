
local composer = require( "composer" )

local scene = composer.newScene()

-- -----------------------------------------------------------------------------------
-- Code outside of the scene event functions below will only be executed ONCE unless
-- the scene is removed entirely (not recycled) via "composer.removeScene()"
-- -----------------------------------------------------------------------------------

-- initialize variables
local json = require('json')
local scoresTable = {}
local filePath = system.pathForFile('scores.json', system.DocumentsDirectory)
local bgMusic

local function loadScores(  )
	local file = io.open(filePath, 'r')

	if file then
		local contents = file:read('*a')
		io.close(file)
		scoresTable = json.decode(contents)
	end

	if scoresTable == nil or #scoresTable == 0 then
		for i = 1, 10 do
			scoresTable[#scoresTable + 1] = 0
		end
	end
end

local function saveScores(  )
	-- in order to save the tenth highest scores by removing the rest scores from the scoresTable
	for i = #scoresTable, 11, -1 do
		table.remove(scoresTable, i)
	end

	local file = io.open(filePath, 'w')
	if file then
		file:write(json.encode(scoresTable))
		io.close(file)
	end
end

local function gotoGame(  )
	composer.removeScene('game')
	composer.gotoScene('game',
		{time = 800, effect = 'crossFade',}
	)
end

local function gotoMenu(  )
	
	composer.removeScene('menu')
	composer.gotoScene('menu', 
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

	-- load previous scores
	loadScores()

	-- Insert the saved score from the last game into the table, then reset it
	-- scoresTable:insert(composer.getVariable('finalScore'))
	table.insert(scoresTable, composer.getVariable('finalScore'))
	composer.setVariable('finalScore', 0)

	-- sort the table entries from highest to lowest
	table.sort(scoresTable, function (a, b) return a > b end)

	-- save the scores
	saveScores()

	local background = display.newImageRect(sceneGroup, 'assets/background.png', 800, 1400)
	background.x = cX
	background.y = cY

	local highScoresHeader = display.newText(sceneGroup, 'HighScores', cX, 100, native.systemFont, 40)

	-- create the ten objects of scoresText
	for i = 1, 10 do
		if scoresTable[i] then
			local yPos = 150 + (i * 50)

			local rankNum = display.newText(sceneGroup, tostring(i) .. ')', cX - 10, yPos, native.systemFont, 32)
			rankNum:setFillColor(0.8)
			rankNum.anchorX = 1

			local thisScore = display.newText(sceneGroup, scoresTable[i], cX + 10, yPos, native.systemFont, 32)
			thisScore.anchorX = 0
		end
	end

	-- add button to replay
	local replayBtn = display.newText(sceneGroup, 'Replay', cX, 760, native.systemFont, 36)
	replayBtn:setFillColor(0.75, 0.78, 1)
	replayBtn:addEventListener('tap', gotoGame)

	-- add button to return to the menu scene
	local menuBtn = display.newText(sceneGroup, 'Menu', cX, 810, native.systemFont, 36)
	menuBtn:setFillColor(0.75, 0.78, 1)
	menuBtn:addEventListener('tap', gotoMenu)

	-- bgMusic = audio.loadStream('audio/Escape_Looping.wav')
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
