-----------------------------------------------------------------------------------------
--
-- main.lua
--
-----------------------------------------------------------------------------------------

-- Your code here
local turno = true

local background = display.newImageRect( "Imagenes/fondoH.png", 2800, 1200 )
background.x = display.contentCenterX
background.y = display.contentCenterY

local cartasEspeciales = display.newImageRect( "Imagenes/tcartas.png", 100, 140)
cartasEspeciales.x = display.contentCenterX + 550
cartasEspeciales.y = display.contentHeight- 90

local arbolBank = display.newImageRect("Imagenes/arbol.png", 100, 140)
arbolBank.x = display.contentCenterX + 660
arbolBank.y = display.contentHeight-90

local ladrilloBank = display.newImageRect("Imagenes/ladrillo.png", 100, 140)
ladrilloBank.x = display.contentCenterX + 770
ladrilloBank.y = display.contentHeight- 90

local trigoBank = display.newImageRect("Imagenes/trigo.png", 100, 140)
trigoBank.x = display.contentCenterX + 880
trigoBank.y = display.contentHeight- 90

local vacaBank = display.newImageRect("Imagenes/vaca.png", 100, 140)
vacaBank.x = display.contentCenterX + 990
vacaBank.y = display.contentHeight- 90

local rocaBank = display.newImageRect("Imagenes/roca.png", 100, 140)
rocaBank.x = display.contentCenterX + 1100
rocaBank.y = display.contentHeight- 90

local dado1 = display.newImageRect("Imagenes/dado1.png", 200, 200)
dado1.x = display.contentCenterX + 850
dado1.y = display.contentHeight- 300

local dado2 = display.newImageRect("Imagenes/dado2.png", 200, 200)
dado2.x = display.contentCenterX + 1050
dado2.y = display.contentHeight- 300

local tablero = display.newImageRect("Imagenes/tablero2.png", 1612, 967)
tablero.x = display.contentCenterX 
tablero.y = display.contentCenterY-70

local usuario = display.newImageRect("Imagenes/usuario.png", 200, 200)
usuario.x = display.contentWidth-260 
usuario.y = display.contentHeight-700

local usuario2 = display.newImageRect("Imagenes/usuario.png", 200, 200)
usuario2.x = display.contentWidth-10
usuario2.y = display.contentHeight-700

local usuario3 = display.newImageRect("Imagenes/usuario.png", 200, 200)
usuario3.x = display.contentWidth-260 
usuario3.y = display.contentHeight-1000

local usuario4 = display.newImageRect("Imagenes/usuario.png", 200, 200)
usuario4.x = display.contentWidth-10
usuario4.y = display.contentHeight-1000

local boton = display.newImageRect("Imagenes/usuario.png", 100, 100)
boton.x = display.contentCenterX
boton.y = display.contentHeight-100

math.randomseed(os.time())


local function actualizaDado()
    local dice1 = math.random(6)
    local dice2 = math.random(6)
    if turno == true then
        turno = false
        if dice1 == 1 then
            dado1.fill = { type="image", filename="Imagenes/dado1.png" }
        elseif dice1 == 2 then
            dado1.fill = { type="image", filename="Imagenes/dado2.png" }
        elseif dice1 == 3 then
            dado1.fill = { type="image", filename="Imagenes/dado3.png" }
        elseif dice1 == 4 then
            dado1.fill = { type="image", filename="Imagenes/dado4.png" }
        elseif dice1 == 5 then
            dado1.fill = { type="image", filename="Imagenes/dado5.png" }
        elseif dice1 == 6 then
            dado1.fill = { type="image", filename="Imagenes/dado6.png" }    
        end
    
        if dice2 == 1 then
            dado2.fill = { type="image", filename="Imagenes/dado1.png" }
        elseif dice2 == 2 then
            dado2.fill = { type="image", filename="Imagenes/dado2.png" }
        elseif dice2 == 3 then
            dado2.fill = { type="image", filename="Imagenes/dado3.png" }
        elseif dice2 == 4 then
            dado2.fill = { type="image", filename="Imagenes/dado4.png" }
        elseif dice2 == 5 then
            dado2.fill = { type="image", filename="Imagenes/dado5.png" }
        elseif dice2 == 6 then
            dado2.fill = { type="image", filename="Imagenes/dado6.png" }    
        end
    end
end

local function pasarTurno()
    turno = true
end

boton:addEventListener("tap", pasarTurno)

dado1:addEventListener("tap", actualizaDado)
dado2:addEventListener("tap", actualizaDado)
