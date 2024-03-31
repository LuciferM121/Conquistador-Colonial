---@diagnostic disable: undefined-global
-----------------------------------------------------------------------------------------
--
-- main.lua
--
-----------------------------------------------------------------------------------------

-- Your code here

local composer = require('composer')
composer.recycleOnSceneChange = true
composer.gotoScene("scenes.partida")

