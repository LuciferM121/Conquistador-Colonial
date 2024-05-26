---@diagnostic disable: undefined-global
local composer = require("composer")
local relayaout = require("librerias.relayout")

local w, h, cx, cy = relayaout._W, relayaout._H, relayaout._CX, relayaout._CY

--Escena 
local scene = composer.newScene()

--Grupos
local grpMenu

-- Funciones
local function jugar1()
    composer.gotoScene("scenes.jugadores");
end

local function configuracion()
    composer.gotoScene("scenes.configuracion");
end

--Eventos de la escena
function scene:create(event)
    print("scene:create - game")
    grpMenu = display.newGroup()
    self.view:insert(grpMenu)

    local background = display.newImageRect(grpMenu,"Imagenes/fondoH.png", w,h)
    background.x = cx
    background.y = cy

    local lblTitle = display.newText("Conquistador Colonial", cx, cy, native.systemFont, 100)
    lblTitle.fill = { 0, 0, 0 }
    grpMenu:insert(lblTitle)

    local logo = display.newImageRect(grpMenu,"Imagenes/image.png", 500,500)
    logo.x = cx
    logo.y = 250

    local jugar = display.newImageRect(grpMenu,"Imagenes/Menu/jugar.png", 450,150)
    jugar.x = cx - 400
    jugar.y = cy + 200
   
    local opciones = display.newImageRect(grpMenu,"Imagenes/Menu/opciones.png", 450,170)
    opciones.x = cx + 400 
    opciones.y = cy + 200

    local salir = display.newImageRect(grpMenu,"Imagenes/Menu/salir.png", 450,150)
    salir.x = cx 
    salir.y = cy + 400
    
    jugar:addEventListener("tap", jugar1)
    opciones:addEventListener("tap", configuracion)
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