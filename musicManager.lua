-- musicManager.lua
local M = {}

local audio = require("audio")
local backgroundMusic = audio.loadStream("musica/musicalol.mp3")
local isMusicPlaying = false
local musicVolume = 0.10 -- Establecer volumen al 7%

audio.setVolume(musicVolume, { channel=1 })

function M.playMusic()
    if not isMusicPlaying then
        audio.play(backgroundMusic, { channel=1, loops = -1 })
        isMusicPlaying = true
    end
end

function M.stopMusic()
    if isMusicPlaying then
        audio.stop(1) -- Detener la música en el canal 1
        isMusicPlaying = false
    end
end

function M.toggleMusic()
    if isMusicPlaying then
        M.stopMusic()
    else
        M.playMusic()
    end
end

function M.isMusicPlaying()
    return isMusicPlaying
end

return M