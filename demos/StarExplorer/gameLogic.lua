-- @Author: Alan
-- @Date:   2016-11-16 09:24:56
-- @Last Modified by:   Alan
-- @Last Modified time: 2016-11-16 14:37:21
-----------------------------------------------------------------------------------------
--
-- game.lua
--
-----------------------------------------------------------------------------------------


-- include basic physics setup
local physics = require('physics')
physics.start()
physics.setGravity(0, 0)

-- seed the random number generator
math.randomseed(os.time())

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

-- Initalizing Variables
local lives = 3			
local score = 0
local died = false

local asteroidsTalbe = {}

local ship
local gameLoopTime
local livesText 
local scoreText

local cX = display.contentCenterX
local cY = display.contentCenterY
local sW = display.contentWidth
local sH = display.contentHeight

-- set up display groups
local backGroup = display.newGroup()
local mainGroup = display.newGroup()
local uiGroup = display.newGroup()

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
scoreText = display.newText(uiGroup, 'score:' .. score, 400, 80, native.systemFont, 36)

-- hide the status bar
display.setStatusBar(display.HiddenStatusBar)

-- update lives and score
local function updateText()
	livesText = 'Lives' .. lives
	scoreText = 'score' .. score
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
-- createAsteroid()

-- firing mechanics
function fireLaser()
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

-- assign the ship 'tap' event to let the player actually fire lasers
ship:addEventListener('tap',fireLaser)

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

-- assign the ship 'touch' event to let the player actually move ship
ship:addEventListener('touch', dragShip)

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

-- game loop timer
gameLoopTimer = timer.performWithDelay(1000, gameLoop, 0)

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
			end
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
			scoreText.text = 'Score:' .. score
		end

		-- collision between ship and asteroid
		if (obj1.myName == 'ship' and obj2.myName == 'asteroid') or
			(obj1.myName == 'asteroid' and obj2.myName == 'ship')
		then
			if died == false then
				died = true
				-- updateLives
				lives = lives - 1
				livesText.text = 'Lives:' .. lives

				if lives == 0 then
					display.remove(ship)
				else
					ship.alpha = 0
					timer.performWithDelay(1000, restoreShip)
				end
			end
		end

	end	 
end

-- collision listener
Runtime:addEventListener('collision', onCollision)