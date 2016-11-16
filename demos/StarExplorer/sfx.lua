-- @Author: Alan
-- @Date:   2016-11-16 22:12:59
-- @Last Modified by:   Alan
-- @Last Modified time: 2016-11-16 22:51:27
local sfx = {}

sfx.CHANNEL_BG = 1
sfx.CHANNEL_UI = 2

-- explosionSound = audio.loadSound('audio/explosion.wav')
-- fireSound = audio.loadSound('audio/fire.wav')
-- bgMusic = audio.loadStream('audio/80s-Space-Game_Looping.wav')

sfx.bgMenu = {
	handle = audio.loadStream('audio/Midnight-Crawlers_Looping.wav'),
	channel = sfx.CHANNEL_BG
}

sfx.bgGame = {
	handle = audio.loadStream('audio/80s-Space-Game_Looping.wav'),
	channel = sfx.CHANNEL_BG
}

sfx.bgHighScores = {
	handle = audio.loadStream('audio/Escape_Looping.wav'),
	channel = sfx.CHANNEL_BG
}

sfx.explosionSound = {
	handle = audio.loadSound('audio/explosion.wav'),
	channel = sfx.CHANNEL_UI
}

sfx.fireSound = {
	handle = audio.loadSound('audio/fire.wav'),
	channel = sfx.CHANNEL_UI
}

function sfx:initVolumn()
	audio.setVolume( 0.7, { channel = self.CHANNEL_BG } )  --bg music track
	audio.setVolume( 0.8, { channel = self.CHANNEL_UI } )  --ui
end

function sfx:init()
	audio.reserveChannels(2)
	self:initVolumn()
end

function sfx:play(name, options)
    if not isSoundOn then
  		return
    end
    --reset volume
    self:initVolumn()
    if not options then
  		options = {}
    end

    local reservedChannel = self[name].channel

    if reservedChannel and reservedChannel ~= 0 then
  		audio.stop(reservedChannel)
  		options.channel = reservedChannel
    else
		local availableChannel = audio.findFreeChannel( 3 )
		audio.setVolume( 1, { channel=availableChannel } )
		options.channel = availableChannel
    end
    return audio.play(self[name].handle, options)
end

function sfx:pause(channel)
    audio.pause(channel)
end

function sfx:stop(channel)
    if not channel then
  		audio.stop()
    else
  		audio.stop(channel)
    end
end

function sfx:pause(channel)
  	audio.pause(channel)
end

function sfx:resume(channel)
  	audio.resume(channel)
end

function sfx:fadeOut(channel, time)
  	audio.fadeOut(channel, time)
end

function sfx:dispose(channel)
	audio.dispose(channel)
end

sfx:init()

return sfx