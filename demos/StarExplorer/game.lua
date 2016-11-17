
local composer = require( "composer" )

local scene = composer.newScene()

-- -----------------------------------------------------------------------------------
-- Code outside of the scene event functions below will only be executed ONCE unless
-- the scene is removed entirely (not recycled) via "composer.removeScene()"
-- -----------------------------------------------------------------------------------

-- include basic physics setup
local physics = require('physics')
physics.start()
physics.setGravity(0, 0)

-- configure image sheet
local sheetOptions = 
{
	frames =
    {
        {   -- 1) asteroid 1
            x = 0,
            y = 0,
            width = 102,
            height = 85
        },
        {   -- 2) asteroid 2
            x = 0,
            y = 85,
            width = 90,
            height = 83
        },
        {   -- 3) asteroid 3
            x = 0,
            y = 168,
            width = 100,
            height = 97
        },
        {   -- 4) ship
            x = 0,
            y = 265,
            width = 98,
            height = 79
        },
        {   -- 5) laser
            x = 98,
            y = 265,
            width = 14,
            height = 40
        },
    }
}

-- loading the sprite sheet
local objectSheet = graphics.newImageSheet('assets/gameObjects.png', sheetOptions)

-- configure levelUp scores
local levelUpScoresTable = {}

-- initializing variables
local lives = 3		
local score = 0
local curLevel = 1
local levels = 5
local died = false
-- initializing the table to reserve the levelUp scores
for i = 1, levels do
	local len = #levelUpScoresTable
	if i == 1 then
		levelUpScoresTable[1] = 10
	else
		levelUpScoresTable[len + 1] = i * 10 + levelUpScoresTable[len]
	end
end

-- reserve asteroids in the table
local asteroidsTalbe

local ship
local livesText 
local scoreText
local levelText

local backGroup
local mainGroup
local uiGroup

local fireLoopTimer
local gameLoopTimer

-- sounds
local explosionSound
local fireSound
local bgMusic

-- update lives and score
local function updateText()
	livesText.text = 'Lives:' .. lives
	scoreText.text = 'Score:' .. score
	levelText.text = 'Level:' .. curLevel
end

-- creating asteroids
local function createAsteroid(  )
	local newAsteroid = display.newImageRect(mainGroup, objectSheet, 1, 102, 85)
	table.insert(asteroidsTalbe, newAsteroid)
	physics.addBody(newAsteroid, 'dynamic', {radius = 40, bounce = 0.8})
	newAsteroid.myName = 'asteroid'

	-- placement of asteroids
	local whereFrom = math.random(3)
	if (whereFrom == 1) then
		-- from the left
		newAsteroid.x = -60
		newAsteroid.y = math.random(500)
		newAsteroid:setLinearVelocity(math.random(40, 120), math.random(20, 60))

	elseif (whereFrom == 2) then
		-- from the top
		newAsteroid.x = math.random(sW)
		newAsteroid.y = -60
		newAsteroid:setLinearVelocity(math.random(-40, 40), math.random(40, 120))

	elseif (whereFrom == 3) then
		-- from the right
		newAsteroid.x = sW + 60
		newAsteroid.y = math.random(500)
		newAsteroid:setLinearVelocity(math.random(-120, -40), math.random(20, 60))

	end

	-- rotation of asteroid
	newAsteroid:applyTorque(math.random(-6, 6))
end

-- firing mechanics
local function fireLaser()
	-- play fire sound
	sfx:play('fireSound')

	local newLaser = display.newImageRect(mainGroup, objectSheet, 5, 14, 40)
	physics.addBody(newLaser, 'dynamic', {isSensor = true})
	newLaser.isBullet = true
	newLaser.myName = 'laser'

	-- init the placement of newLaser
	newLaser.x = ship.x; newLaser.y = ship.y
	newLaser:toBack()

	-- movement of newLaser
	transition.to(newLaser,
		{
			y = -40,
			time = 800,
			onComplete = function ()
				display.remove(newLaser)
			end,
		}
	)
end

-- firing mechanics sostenuto
local function fireLasers( event )

	local phase = event.phase

	if not died then
		if phase == 'began' then
			if not fireLoopTimer then
				-- start the timer to fire laser sostenuto
				fireLoopTimer = timer.performWithDelay(200, fireLaser, 0)
			elseif fireLoopTimer and fireLoopTimer ~= 0 then
				timer.resume(fireLoopTimer)
			end
		elseif phase == 'ended' or phase == 'canceled' then
			timer.pause(fireLoopTimer)
		end
	end	

	-- prevent the propagation
	return true
end

-- moving the ship
local function dragShip(event)
	-- get target and phase of event
	local ship = event.target
	local phase = event.phase

	if (phase == 'began') then
		-- set touch focus on the ship
		display.currentStage:setFocus(ship)
		-- store initial offset position
		ship.touchOffsetX = event.x - ship.x
		ship.touchOffsetY = event.y - ship.y

	elseif (phase == 'moved') then
		-- move the ship to the new touch position
		ship.x = event.x - ship.touchOffsetX
		ship.y = event.y - ship.touchOffsetY

	elseif (phase == 'ended' or phase == 'canceled') then
		-- release touch focus on the ship
		display.currentStage:setFocus(nil)

	end

	-- prevents touch propagation to underlying objects
	return true 
end

-- game loop in order to create asteroids and clean up dead ones
local function gameLoop()
	-- create new asteroid
	createAsteroid()

	-- remove asteroids which have drifted off screen
	for i = #asteroidsTalbe, 1, -1 do
		local thisAsteroid = asteroidsTalbe[i]
		if( thisAsteroid.x < -100 or 
			thisAsteroid.x > sW + 100 or
			thisAsteroid.y < -100 or
			thisAsteroid.y > sH + 100 )
		then
			display.remove(thisAsteroid)
			table.remove(asteroidsTalbe, i)
		end
	end
end

-- detect level up
local function isLevelUp(  )
	if score >= levelUpScoresTable[#levelUpScoresTable] then return end
	if score >= levelUpScoresTable[curLevel] then
		curLevel = curLevel + 1
		updateText()

		-- release the previous timer
		if gameLoopTimer then
			timer.cancel(gameLoopTimer)
		end

		-- start a new timer
		gameLoopTimer = timer.performWithDelay(1000 - curLevel * 100, gameLoop, 0)
	end
end

-- collision handling

-- restoring the ship
local function restoreShip( )
	ship.isBodyActive = false
	ship:setLinearVelocity(0, 0)
	ship.x = cX
	ship.y = sH - 100

	-- fade in the ship
	transition.to(ship, 
		{
			alpha = 1,
			time = 2000,
			onComplete = function (	)
				ship.isBodyActive = true
				died = false
				-- ship:addEventListener('touch', fireLasers)
			end
		}
	)
end

-- gameOver
local function endGame(  )
	-- save the score in order to access in other scene
	composer.setVariable('finalScore', score)
	
	-- -- return to the menu scene
	-- composer.gotoScene('menu', 
	-- 	{
	-- 		time = 800, 
	-- 		effect = 'crossFade'
	-- 	}
	-- )
	composer.removeScene('highScores')
	composer.gotoScene('highScores', 
		{
			time = 800,
			effect = 'crossFade',
		}
	)
end

-- collision func
local function onCollision( event )
	if (event.phase == 'began') then
		local obj1 = event.object1
		local obj2 = event.object2

		-- collision between laser and asteroid
		if (obj1.myName == 'laser' and obj2.myName == 'asteroid') or
		   (obj1.myName == 'asteroid' and obj2.myName == 'laser')
		then
			-- remove both laser and asteroid
			display.remove(obj1)
			display.remove(obj2)

			-- play explosion sound
			-- audio.play(explosionSound)
			sfx:play('explosionSound')

			-- remove the asteroid from the table
			for i = #asteroidsTalbe, 1, -1 do		-- iterate table to find the one needed remove
				if (asteroidsTalbe[i] == obj1) or 
				   (asteroidsTalbe[i] == obj2)
			    then
			    	table.remove(asteroidsTalbe, i)
			    	break							-- need to break from the loop when find the one
		    	end
			end

			-- increase score
			score = score + 1
			updateText()
			isLevelUp()
		end

		-- collision between ship and asteroid
		if (obj1.myName == 'ship' and obj2.myName == 'asteroid') or
			(obj1.myName == 'asteroid' and obj2.myName == 'ship')
		then
			if died == false then
				died = true
				-- ship:removeEventListener('touch', fireLasers)

				-- audio.play(explosionSound)
				sfx:play('explosionSound')
			
				-- updateLives
				lives = lives - 1
				updateText()

				if lives == 0 then
					display.remove(ship)
					-- gameLoopTimer.pause()
					timer.performWithDelay(2000, endGame)
				else
					ship.alpha = 0
					timer.performWithDelay(1000, restoreShip)
				end
			end
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

	-- pause the physics engine temporarily
	physics.pause()

	-- initialize table to reserve asteroids
	asteroidsTalbe = {}

	-- set up display groups
	backGroup = display.newGroup()
	mainGroup = display.newGroup()
	uiGroup = display.newGroup()
	sceneGroup:insert(backGroup); sceneGroup:insert(mainGroup); sceneGroup:insert(uiGroup)

	-- loading the background
	local background = display.newImageRect(backGroup, 'assets/background.png', 800, 1400)
	background.x = cX; background.y = cY

	-- loading the ship
	ship = display.newImageRect(mainGroup, objectSheet, 4, 98, 79)
	ship.x = cX; ship.y = sH - 100
	physics.addBody(ship, {radius = 30, isSensor = true})
	ship.myName = 'ship'

	-- display lives and score
	livesText = display.newText(uiGroup, 'Lives:' .. lives, 200, 80, native.systemFont, 36)
	scoreText = display.newText(uiGroup, 'Score:' .. score, 400, 80, native.systemFont, 36)
	levelText = display.newText(uiGroup, 'Level:' .. curLevel, 600, 80, native.systemFont, 36)

	-- assign the ship 'tap' event to let the player actually fire lasers
	ship:addEventListener('tap', fireLaser)

	-- assign the ship 'touch' event to let the player fire lasers sostenuto
	ship:addEventListener('touch', fireLasers)

	-- assign the ship 'touch' event to let the player actually move ship
	ship:addEventListener('touch', dragShip)
end


-- show()
function scene:show( event )

	local sceneGroup = self.view
	local phase = event.phase

	if ( phase == "will" ) then
		-- Code here runs when the scene is still off screen (but is about to come on screen)

	elseif ( phase == "did" ) then
		-- Code here runs when the scene is entirely on screen
		physics.start()
		-- collision listener
		Runtime:addEventListener('collision', onCollision)
		-- game loop timer
		gameLoopTimer = timer.performWithDelay(1000, gameLoop, 0)

		-- start bgMusic
		-- audio.play(bgMusic, {channel = 1, loops = -1})
		bgMusic = sfx:play('bgGame', {loops = -1})
		
	end
end


-- hide()
function scene:hide( event )

	local sceneGroup = self.view
	local phase = event.phase

	if ( phase == "will" ) then
		-- Code here runs when the scene is on screen (but is about to go off screen)
		timer.cancel(fireLoopTimer)
		timer.cancel(gameLoopTimer)

	elseif ( phase == "did" ) then
		-- Code here runs immediately after the scene goes entirely off screen
		Runtime:removeEventListener('collision', onCollision)
		physics.pause()

		-- stop the music
		-- audio.stop(1)
		sfx:stop(bgMusic)
	end
end


-- destroy()
function scene:destroy( event )

	local sceneGroup = self.view
	-- Code here runs prior to the removal of scene's view

	-- dispose audio
	-- local explosionSound
	-- local fireSound
	-- local bgMusic
	-- audio.dispose(explosionSound); audio.dispose(fireSound); 
	audio.dispose(bgMusic);
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
