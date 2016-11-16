-- @Author: Alan
-- @Date:   2016-11-16 14:01:51
-- @Last Modified by:   Alan
-- @Last Modified time: 2016-11-17 00:00:27


-- define the global variable
cX = display.contentCenterX
cY = display.contentCenterY
sW = display.contentWidth
sH = display.contentHeight

-- sound of game
isSoundOn = true
sfx = require('sfx')

local composer = require('composer')
math.randomseed(os.time())

-- -- hide the status bar
-- display.setStatusBar(display.HiddenStatusBar)

-- -- reserve channel 2 for bgMusic
-- audio.reserveChannels(2)

-- -- reduce the overall volume of the channels
-- audio.setVolume(0.5, {channel = 1})
-- audio.setVolume(0.6, {channel = 2})
-- audio.setVolume(0.6, {channel = 3})
-- audio.setVolume(0.6, {channel = 4})

-- go to the menu secen
composer.gotoScene('menu')