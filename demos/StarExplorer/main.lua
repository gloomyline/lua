-- @Author: Alan
-- @Date:   2016-11-16 14:01:51
-- @Last Modified by:   Alan
-- @Last Modified time: 2016-11-16 17:47:53


-- define the global variable
cX = display.contentCenterX
cY = display.contentCenterY
sW = display.contentWidth
sH = display.contentHeight

local composer = require('composer')
math.randomseed(os.time())

-- -- hide the status bar
-- display.setStatusBar(display.HiddenStatusBar)

-- reserve channel 1 for bgMusic
audio.reserveChannels(1)
-- reduce the overall volume of the channel
audio.setVolume(0.5, {channel = 1})

-- go to the menu secen
composer.gotoScene('menu')