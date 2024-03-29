---@diagnostic disable: undefined-global
local composer = require("composer")
local relayaout = require("librerias.relayout")

local w, h, cx, cy = relayaout._W, relayaout._H, relayaout._CX, relayaout._CY

--Escena 
local scene = composer.newScene()

--Grupos
local grpMenu


--Eventos de la escena
function scene:create(event)
    print("scene:create - menu")
    grpMenu = display.newGroup()
    self.view:insert(grpMenu)

    local background = display.newImageRect(grpMenu,"Imagenes/fondoH.png", w,h)
    background.x = cx
    background.y = cy

    local lblTitle = display.newText("Conquistador Colonial", cx, 100, native.systemFont, 76)
    lblTitle.fill = { 0, 0, 0 }
    grpMenu:insert(lblTitle)

    local btnPlay = display.newRoundedRect( grpMenu, cx, cy, 500, 200, 20)
    btnPlay.fill = { 1, 1, 1 }
    btnPlay.alpha = 0.4;

    local lblPlay = display.newText("Play", cx, cy + 4, native.systemFont, 50)
    lblPlay.fill = { 0, 0, 0 } 
    grpMenu:insert(lblPlay)

    --btnPlay:addEventListener("tap", gotoGame)


end

function scene:show(event)
    if(event.phase == "will") then
    elseif (event.phase == "did") then
    end
end


function scene:hide(event)
    if(event.phase == "will") then
    elseif (event.phase == "did") then
    end
end

function scene:destroy(event)
    if(event.phase == "will") then
    elseif (event.phase == "did") then
    end
end

scene:addEventListener("create", scene)
scene:addEventListener("show", scene)
scene:addEventListener("hide", scene)
scene:addEventListener("destroy", scene)

return scene