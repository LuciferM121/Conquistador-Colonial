---@diagnostic disable: undefined-global

local turno = true
local usuario1_text
local usuario2_text
local usuario3_text
local usuario4_text

display.setStatusBar( display.HiddenStatusBar )

local background = display.newImageRect( "Imagenes/fondoH.png", 2800, 1200 )
background.x = display.contentCenterX
background.y = display.contentCenterY

local tablero = display.newImageRect("Imagenes/tablero2.png", 1209, 726)
tablero.x = display.contentCenterX -100
tablero.y = display.contentCenterY-70

local cartasEspeciales = display.newImageRect( "Imagenes/tcartas.png", 100, 140)
cartasEspeciales.x = display.contentWidth - 650
cartasEspeciales.y = display.contentHeight- 90

local arbolBank = display.newImageRect("Imagenes/arbol.png", 100, 140)
arbolBank.x = display.contentWidth - 540
arbolBank.y = display.contentHeight-90

local ladrilloBank = display.newImageRect("Imagenes/ladrillo.png", 100, 140)
ladrilloBank.x = display.contentWidth - 430
ladrilloBank.y = display.contentHeight- 90

local trigoBank = display.newImageRect("Imagenes/trigo.png", 100, 140)
trigoBank.x = display.contentWidth - 320
trigoBank.y = display.contentHeight- 90

local vacaBank = display.newImageRect("Imagenes/vaca.png", 100, 140)
vacaBank.x = display.contentWidth - 210 
vacaBank.y = display.contentHeight- 90

local rocaBank = display.newImageRect("Imagenes/roca.png", 100, 140)
rocaBank.x = display.contentWidth -100
rocaBank.y = display.contentHeight- 90

local dado1 = display.newImageRect("Imagenes/dado1.png", 200, 200)
dado1.x = display.contentWidth -350
dado1.y = display.contentHeight- 300

local dado2 = display.newImageRect("Imagenes/dado2.png", 200, 200)
dado2.x = display.contentWidth- 150
dado2.y = display.contentHeight- 300

local usuario = display.newImageRect("Imagenes/usuario.png", 150, 150)
usuario.x = display.contentWidth-350 
usuario.y = display.contentHeight-750

local usuario2 = display.newImageRect("Imagenes/usuario.png", 150, 150)
usuario2.x = display.contentWidth-150
usuario2.y = display.contentHeight-750

local usuario3 = display.newImageRect("Imagenes/usuario.png", 150, 150)
usuario3.x = display.contentWidth-350 
usuario3.y = display.contentHeight-1000

local usuario4 = display.newImageRect("Imagenes/usuario.png", 150, 150)
usuario4.x = display.contentWidth-150
usuario4.y = display.contentHeight-1000

local boton = display.newImageRect("Imagenes/avanzar.png", 100, 100)
boton.x =  display.contentWidth -100
boton.y = display.contentHeight-500

local vacio1 = display.newImageRect("Imagenes/vacia.png", 100, 140)
vacio1.x = 180
vacio1.y = 200

local vacio2 = display.newImageRect("Imagenes/vacia.png", 100, 140)
vacio2.x = 180
vacio2.y = 350

local vacio3 = display.newImageRect("Imagenes/vacia.png", 100, 140)
vacio3.x = 180
vacio3.y = 500

local vacio4 = display.newImageRect("Imagenes/vacia.png", 100, 140)
vacio4.x = 180
vacio4.y = 650

local vacio5 = display.newImageRect("Imagenes/vacia.png", 100, 140)
vacio5.x = 180
vacio5.y = 800

local vacio6 = display.newImageRect("Imagenes/vacia.png", 100, 140)
vacio6.x = 180
vacio6.y = 1025

local barco = display.newImageRect("Imagenes/barco1.png", 200, 120)
barco.x = display.contentCenterX -70
barco.y = 100

local barco2 = display.newImageRect("Imagenes/barco2.png", 200, 120)
barco2.x = display.contentCenterX -350
barco2.y = 100

local barco3 = display.newImageRect("Imagenes/barco3.png", 200, 120)
barco3.x = display.contentCenterX - 490
barco3.y = display.contentCenterY + 50

local barco4 = display.newImageRect("Imagenes/barco4.png", 200, 120)
barco4.x = display.contentCenterX - 490
barco4.y = display.contentCenterY - 200

local barco5 = display.newImageRect("Imagenes/barco5.png", 200, 120)
barco5.x = display.contentCenterX + 220
barco5.y = display.contentCenterY - 310

local barco6 = display.newImageRect("Imagenes/barco6.png", 200, 120)
barco6.x = display.contentCenterX + 200
barco6.y = display.contentCenterY + 150

local barco7 = display.newImageRect("Imagenes/barco6.png", 200, 120)
barco7.x = display.contentCenterX - 50
barco7.y = display.contentCenterY + 300

local hexagono1 = display.newImageRect("Imagenes/hexagonos/12.png", 145, 180)
hexagono1.x = display.contentCenterX + 7 
hexagono1.y = display.contentCenterY - 70

local numero = display.newImageRect("Imagenes/hexagonos/18.png", 50, 100)
numero.x = display.contentCenterX + 7 
numero.y = display.contentCenterY - 35

math.randomseed(os.time()) --Semilla para los random


local function actualizaDado() --Función para cambiar la imagen de los dados
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

local function pasarTurno() --Función para pasar el Turno al siguiente jugador. 
    turno = true
end

boton:addEventListener("tap", pasarTurno) --Se le agrega el evento al objeto para pasar Turno
dado1:addEventListener("tap", actualizaDado) --Se le agrega el evento a los dados para que puedan lanzarse
dado2:addEventListener("tap", actualizaDado)

--Declaracion de la clase Jugador
Jugador = {
    nombre = "",
    puntos = 0,
    cartas = 0,
    casasD = 4,
    ciudadesD = 5, 
    caminosD = 15, 
    casasC = 0
}

Jugador.__index = Jugador

function Jugador:nuevo(nombre)
    local nuevo_jugador = {}
    setmetatable(nuevo_jugador,self)
    self.__index = self
    nuevo_jugador.nombre = nombre
    return nuevo_jugador
end    

local jugador1 = Jugador:nuevo("Evan")
usuario1_text = display.newText(jugador1.nombre, display.contentWidth -150, display.contentHeight-880, native.systemFont, 50 )
usuario1_text:setFillColor(0,0,0);

local jugador2 = Jugador:nuevo("Omar")
usuario2_text = display.newText(jugador2.nombre, display.contentWidth - 350 , display.contentHeight-880, native.systemFont, 50 )
usuario2_text:setFillColor(0,0,0);

local jugador1 = Jugador:nuevo("Sebas")
usuario3_text = display.newText(jugador1.nombre, display.contentWidth - 350, display.contentHeight-640, native.systemFont, 50 )
usuario3_text:setFillColor(0,0,0);

local jugador1 = Jugador:nuevo("Bolillo")
usuario4_text = display.newText(jugador1.nombre, display.contentWidth -150, display.contentHeight-640, native.systemFont, 50 )
usuario4_text:setFillColor(0,0,0);