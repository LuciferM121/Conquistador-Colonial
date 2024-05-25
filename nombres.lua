---@diagnostic disable: undefined-global
local composer = require("composer")
local relayaout = require("librerias.relayout")

local w, h, cx, cy = relayaout._W, relayaout._H, relayaout._CX, relayaout._CY

--Escena 
local scene = composer.newScene()

--Grupos
local grpJug

-- Variables para los text fields
local textField1, textField2, textField3, textField4

-- Funciones
local function enviarDatos()
    -- Validar que los campos no estén vacíos
    if textField1.text == "" or textField2.text == "" or textField3.text == "" or textField4.text == "" then
        print("Por favor, llena todos los campos.")
        return
    end
    
    -- Pasar los datos a la siguiente escena
    local opciones = {
        effect = "fade",
        time = 500,
        params = {
            jugador1 = textField1.text,
            jugador2 = textField2.text,
            jugador3 = textField3.text,
            jugador4 = textField4.text
        }
    }
    
    composer.gotoScene("scenes.partida", opciones)
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

    local lblTitle = display.newText("Conquistador Colonial", cx, cy - 400, native.systemFont, 100)
    lblTitle.fill = { 0, 0, 0 }
    grpJug:insert(lblTitle)

    local salir = display.newImageRect(grpJug,"Imagenes/Menu/salir.png", 450,140)
    salir.x = cx + 400 
    salir.y = cy + 400
    grpJug:insert(salir)

    local jugar = display.newImageRect(grpJug,"Imagenes/Menu/jugar.png", 450,140)
    jugar.x = cx - 400  
    jugar.y = cy + 400
    grpJug:insert(jugar)

    -- Crear TextFields para nombres de jugadores
    textField1 = native.newTextField(cx - 400, cy , 300, 50)
    textField1.placeholder = "Nombre Jugador 1"
    grpJug:insert(textField1)

    local jug1 = display.newText("Jugador 1", cx - 400, cy - 100, native.systemFont, 60)
    jug1.fill = { 0, 0, 0 }
    grpJug:insert(jug1)

    textField2 = native.newTextField(cx + 400, cy , 300, 50)
    textField2.placeholder = "Nombre Jugador 2"
    grpJug:insert(textField2)

    local jug2 = display.newText("Jugador 2", cx + 400, cy - 100, native.systemFont, 60)
    jug2.fill = { 0, 0, 0 }
    grpJug:insert(jug2)

    textField3 = native.newTextField(cx - 400, cy + 200, 300, 50)
    textField3.placeholder = "Nombre Jugador 3"
    grpJug:insert(textField3)

    local jug3 = display.newText("Jugador 3", cx - 400, cy + 100, native.systemFont, 60)
    jug3.fill = { 0, 0, 0 }
    grpJug:insert(jug3)

    textField4 = native.newTextField(cx + 400, cy + 200, 300, 50)
    textField4.placeholder = "Nombre Jugador 4"
    grpJug:insert(textField4)

    local jug4 = display.newText("Jugador 4", cx + 400, cy + 100, native.systemFont, 60)
    jug4.fill = { 0, 0, 0 }
    grpJug:insert(jug4)

    jugar:addEventListener("tap", enviarDatos)
    salir:addEventListener("tap", salirAlMenu)
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
        -- Eliminar los text fields para liberar recursos
        if textField1 then
            textField1:removeSelf()
            textField1 = nil
        end
        if textField2 then
            textField2:removeSelf()
            textField2 = nil
        end
        if textField3 then
            textField3:removeSelf()
            textField3 = nil
        end
        if textField4 then
            textField4:removeSelf()
            textField4 = nil
        end
    elseif (event.phase == "did") then
    end
end

scene:addEventListener("create", scene)
scene:addEventListener("show", scene)
scene:addEventListener("hide", scene)
scene:addEventListener("destroy", scene)

return scene
