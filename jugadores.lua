---@diagnostic disable: undefined-global
local composer = require("composer")
local relayaout = require("librerias.relayout")

local w, h, cx, cy = relayaout._W, relayaout._H, relayaout._CX, relayaout._CY

--Escena 
local scene = composer.newScene()

--Grupos
local grpJug

-- Funciones
local function jugar2()
    composer.gotoScene("scenes.nombres");
    
end

local function jugar3()
    composer.gotoScene("scenes.partida");
    
end

local function jugar4()
    composer.gotoScene("scenes.nombres");
    
end

local function salirAlMenu()
    composer.gotoScene("scenes.menu");
    
end

--Eventos de la escena
function scene:create(event)
    print("scene:create - game")
    grpJug = display.newGroup()
    self.view:insert(grpJug)

    local background = display.newImageRect(grpJug,"Imagenes/fondoH.png", w,h)
    background.x = cx
    background.y = cy

    local lblTitle = display.newText("Conquistador Colonial", cx, cy, native.systemFont, 100)
    lblTitle.fill = { 0, 0, 0 }
    grpJug:insert(lblTitle)

    local logo = display.newImageRect(grpJug,"Imagenes/image.png", 500,500)
    logo.x = cx
    logo.y = 250

    local jug2 = display.newImageRect(grpJug,"Imagenes/Menu/2jug.png", 450,140)
    jug2.x = cx - 400
    jug2.y = cy + 200
   
    local jug3 = display.newImageRect(grpJug,"Imagenes/Menu/3jug.png", 450,140)
    jug3.x = cx + 400 
    jug3.y = cy + 200

    local jug4 = display.newImageRect(grpJug,"Imagenes/Menu/4jug.png", 450,140)
    jug4.x = cx - 400 
    jug4.y = cy + 400

    local salir = display.newImageRect(grpJug,"Imagenes/Menu/salir.png", 450,140)
    salir.x = cx + 400 
    salir.y = cy + 400
    
    
    salir:addEventListener("tap", salirAlMenu)
    jug2:addEventListener("tap", jugar2)
    jug3:addEventListener("tap", jugar3)
    jug4:addEventListener("tap", jugar4)

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