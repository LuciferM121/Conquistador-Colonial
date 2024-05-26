---@diagnostic disable: undefined-global

local composer = require("composer")
local widget = require("widget")
local relayaout = require("librerias.relayout")
local w, h, cx, cy = relayaout._W, relayaout._H, relayaout._CX, relayaout._CY

--Escena 
local scene = composer.newScene()

--Grupos
local sceneGroup

-- Funciones
local function exit()
    composer.gotoScene("scenes.menu");
end

--Eventos de la escena
function scene:create(event)
    print("scene:create - game")
    sceneGroup = display.newGroup()
    self.view:insert(sceneGroup)

    local background = display.newImageRect(sceneGroup,"Imagenes/fondoH.png", w,h)
    background.x = cx
    background.y = cy

    -- Título
    local title = display.newText({
        parent = sceneGroup,
        text = "CONFIGURACIÓN",
        x = display.contentCenterX,
        y = 150,
        font = native.systemFontBold,
        fontSize = 72
    })
    title:setFillColor(0, 0, 0)

    local sonido = display.newImageRect(sceneGroup,"Imagenes/configuracion/sonido.png", 100,100)
    sonido.x = display.contentCenterX - 400
    sonido.y = 350
   
    -- Checkbox de Sonido
    local soundCheckbox = widget.newSwitch({
        left = display.contentCenterX - 200,  -- Ajustar posición horizontal
        top = 300,  -- Ajustar posición vertical
        style = "checkbox",
        id = "soundCheckbox",
        width = 100,  -- Aumentar tamaño
        height = 100,  -- Aumentar tamaño
        initialSwitchState = true,
        onPress = function(event)
            print("Sound checkbox is " .. (event.target.isOn and "on" or "off"))
        end
    })
    sceneGroup:insert(soundCheckbox)

    local soundLabel = display.newText({
        parent = sceneGroup,
        text = "SONIDO",
        x = display.contentCenterX + 100,  -- Ajustar posición horizontal
        y = soundCheckbox.y,
        font = native.systemFontBold,
        fontSize = 48  -- Aumentar tamaño de fuente
    })
    soundLabel:setFillColor(0, 0, 0)

    local musica = display.newImageRect(sceneGroup,"Imagenes/configuracion/musica.png", 100,100)
    musica.x = display.contentCenterX - 400
    musica.y = 550

    -- Checkbox de Música
    local musicCheckbox = widget.newSwitch({
        left = display.contentCenterX - 200,  -- Ajustar posición horizontal
        top = 500,  -- Ajustar posición vertical
        style = "checkbox",
        id = "musicCheckbox",
        width = 100,  -- Aumentar tamaño
        height = 100,  -- Aumentar tamaño
        initialSwitchState = true,
        onPress = function(event)
            print("Music checkbox is " .. (event.target.isOn and "on" or "off"))
        end
    })
    sceneGroup:insert(musicCheckbox)

    local musicLabel = display.newText({
        parent = sceneGroup,
        text = "MÚSICA",
        x = display.contentCenterX + 100,  -- Ajustar posición horizontal
        y = musicCheckbox.y,
        font = native.systemFontBold,
        fontSize = 48  -- Aumentar tamaño de fuente
    })

    musicLabel:setFillColor(0, 0, 0)

    local salir = display.newImageRect(sceneGroup,"Imagenes/Menu/salir.png", 450,150)
    salir.x = cx 
    salir.y = cy + 400

    salir:addEventListener("tap", exit)

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