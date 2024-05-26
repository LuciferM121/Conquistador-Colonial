---@diagnostic disable: undefined-global
local composer = require("composer")
local widget = require("widget")
local relayaout = require("librerias.relayout")
local musicManager = require("musicManager") -- Agregar esta línea

local w, h, cx, cy = relayaout._W, relayaout._H, relayaout._CX, relayaout._CY

-- Escena
local scene = composer.newScene()

-- Funciones
local function exit()
    composer.gotoScene("scenes.menu")
end

-- Eventos de la escena
function scene:create(event)
    print("scene:create - configuracion")
    local sceneGroup = self.view
    local background = display.newImageRect(sceneGroup, "Imagenes/fondoH.png", w, h)
    background.x = cx
    background.y = cy

    -- Título
    local title = display.newText({ parent = sceneGroup, text = "CONFIGURACIÓN", x = display.contentCenterX, y = 150, font = native.systemFontBold, fontSize = 72 })
    title:setFillColor(0, 0, 0)

    local musica = display.newImageRect(sceneGroup, "Imagenes/configuracion/musica.png", 100, 100)
    musica.x = display.contentCenterX - 400
    musica.y = 350

    -- Checkbox de Música
    local musicCheckbox = widget.newSwitch({
        left = display.contentCenterX - 200,
        top = 300,
        style = "checkbox",
        id = "musicCheckbox",
        width = 100,
        height = 100,
        initialSwitchState = musicManager.isMusicPlaying(),
        onPress = function(event)
            local isOn = event.target.isOn
            print("Music checkbox is " .. (isOn and "on" or "off"))
            musicManager.toggleMusic()
        end
    })
    sceneGroup:insert(musicCheckbox)

    local musicLabel = display.newText({ parent = sceneGroup, text = "MÚSICA", x = display.contentCenterX + 100, y = musicCheckbox.y, font = native.systemFontBold, fontSize = 48 })
    musicLabel:setFillColor(0, 0, 0)

    local salir = display.newImageRect(sceneGroup, "Imagenes/Menu/salir.png", 450, 150)
    salir.x = cx
    salir.y = cy + 400
    salir:addEventListener("tap", exit)
end

function scene:show(event)
    if event.phase == "will" then
    elseif event.phase == "did" then
    end
end

function scene:hide(event)
    if event.phase == "will" then
    elseif event.phase == "did" then
    end
end

function scene:destroy(event)
    if event.phase == "will" then
    elseif event.phase == "did" then
    end
end

scene:addEventListener("create", scene)
scene:addEventListener("show", scene)
scene:addEventListener("hide", scene)
scene:addEventListener("destroy", scene)

return scene