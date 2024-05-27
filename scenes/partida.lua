---@diagnostic disable: undefined-global
local composer = require("composer")
local relayaout = require("librerias.relayout")

local w, h, cx, cy = relayaout._W, relayaout._H, relayaout._CX, relayaout._CY
math.randomseed(os.time()) --Semilla para los random
--Escena 
local scene = composer.newScene()

--Grupos
local grpPartida
local grpJugadores = {}

--Objetos
local turno = true
local usuario1_text
local usuario2_text
local usuario3_text
local usuario4_text

local dado1
local dado2
local dice1
local dice2
local boton
local ronda = 1

local tirarDados = false

local imgHex = {
    "Imagenes/hexagonos/12.png",
    "Imagenes/hexagonos/13.png",
    "Imagenes/hexagonos/14.png",
    "Imagenes/hexagonos/15.png",
    "Imagenes/hexagonos/16.png",
    "Imagenes/hexagonos/17.png"
}

local imgNum = {
    "Imagenes/hexagonos/19.png",
    "Imagenes/hexagonos/20.png",
    "Imagenes/hexagonos/21.png",
    "Imagenes/hexagonos/22.png",
    "Imagenes/hexagonos/23.png",
    "Imagenes/hexagonos/29.png",
    "Imagenes/hexagonos/24.png",
    "Imagenes/hexagonos/25.png",
    "Imagenes/hexagonos/26.png",
    "Imagenes/hexagonos/27.png",
    "Imagenes/hexagonos/28.png"
    
}

local imgCartas = {

}

local pasarTurno

--Son arreglos para guardar las cartas que aparecen en la pantalla
local cartasjugador = {{}, {}, {}, {}}


    local grafo = {
        {2,9,nil},
        {1,3,nil},
        {2,4,11},
        {3,5,nil},
        {4,6,13},
        {5,7,nil},
        {6,15,nil},
        {9,18,nil},
        {1,8,10},
        {9,11,20},
        {3,10,12},
        {11,13,22},
        {5,12,14},
        {13,15,24},
        {7,14,16},
        {15,26,nil},
        {18,28,nil},
        {8,17,19},
        {18,20,30},
        {10,19,21},
        {20,22,32},
        {12,21,23},
        {22,24,34},
        {14,23,25},
        {24,26,36},
        {16,25,27},
        {26,28,nil},
        {17,29,nil},
        {28,30,39},
        {19,29,31},
        {30,32,41},
        {21,31,33},
        {32,34,43},
        {23,33,35},
        {34,36,45},
        {25,35,37},
        {36,38,47},
        {27,37,nil},
        {29,40,nil},
        {39,41,48},
        {31,40,42},
        {41,43,50},
        {33,42,44},
        {43,45,52},
        {35,44,46},
        {45,47,54},
        {37,46,nil},
        {40,49,nil},
        {48,50,nil},
        {42,49,51},
        {50,52,nil},
        {44,51,53},
        {52,54,nil},
        {46,53,nil}
    }


--Variable para almacenar el tipo y el numero que le corresponde a cada hexagono en 1 el tipo y en 2 la probabilidad
local numeroHexagonos = {
    {0,0,{1,2,3,9,10,11}}, 
    {0,0,{3,4,5,11,12,13}}, 
    {0,0,{5,6,7,13,14,15}}, 
    {0,0,{8,9,10,18,19,20}}, 
    {0,0,{10,11,12,20,21,22}}, 
    {0,0,{12,13,14,22,23,24}}, 
    {0,0,{14,15,16,24,25,26}}, 
    {0,0,{17,18,19,28,29,30}}, 
    {0,0,{19,20,21,30,31,32}}, 
    {0,0,{21,22,23,32,33,34}}, 
    {0,0,{23,24,25,34,35,36}}, 
    {0,0,{25,26,27,36,37,38}}, 
    {0,0,{29,30,31,39,40,41}}, 
    {0,0,{31,32,33,41,42,43}}, 
    {0,0,{33,34,35,43,44,45}}, 
    {0,0,{35,36,37,45,46,47}}, 
    {0,0,{40,41,42,48,49,50}}, 
    {0,0,{42,43,44,50,51,52}}, 
    {0,0,{44,45,46,52,53,54}}
  }

local posicion = 1  
local probHex = {}
local hexagonosM = {}
local verticesC = {}
local verticeClase = {}
local aristas = {}
local caminosFlag = false
local aristaClase = {}
local especiales = {{1,1,1,1,1}, {1,2,1,1,1}, {1,3,1,1,1}, {1,4,1,1,1}}
local cartaRobar = {}

--Variable para controlar las repeticiones de los hexagonos
local rep = {0,0,0,0,0,0}

--Variable para las probabilidades
local probabilidad = {1,2,2,2,2,0,2,2,2,2,1}

--Jugadores
local jugadores={}
local jugadorActual = 1;
--local jugando = display.newText("", display.contentCenterX - 400 , display.contentHeight-200, native.systemFont, 70)

--Cronometro
local textoTiempo = display.newText("", display.contentWidth-330, display.contentHeight-500, native.systemFont, 70)
local tiempoTotal = 40
local tiempoRestante = tiempoTotal
local temporizador
local seguir
local background2
local pasar

local posicionLadronA = nil
local probabilidadA = 0


local cantidadesCartas = {}

local textoRonda = display.newText("", 150, display.contentHeight - 100, native.systemFont, 50)
local textoPuntos = {}
local textoEspeciales = {{},{},{},{}}
local textoCartasT = {}
local cuadrosJugando = {}

local actualizaDado

local btnAceptarT = {}
local btnJugadores
local btnBanco

--Bolillo y Sebastian
local cartasDadas = 0
local cartasEspeciales
local rocaBank
local vacaBank
local trigoBank
local arbolBank
local ladrilloBank
local especialesUser
local rocaUser
local vacaUser
local trigoUser
local arbolUser
local ladrilloUser
local tradeo
local tradeoTexto
local usuariosTradeando = {}
local btnRechazar

local elegir
local tradear
local tradearJugadores
local seleccionParaDar
local seleccionParaDarJugador


--Creacion de clases

Jugador = {
    numero = 0,
    nombre = "",
    puntos = 0,
    cartas = 0,
    casasD = 4,
    ciudadesD = 5, 
    caminosD = 15, 
    casasC = 0,
    cartas1 = 0, --arboles
    cartas2 = 0, --trigo
    cartas3 = 0, --ladrillo
    cartas4 = 0, --vacas 
    cartas5 = 0, --roca
    cartas6 = 0,  --especiales
    --cartasR = {}
    casaL = 2,
    caminoL = 2

}

Vertice = {
    ocupado = false, 
    tipoC = 0,
    jugador = 0,
    activo = true
}

Camino = {
    ocupado = false,
    verticeI = nil,
    verticeF = nil,
    inclinacion = 0,
    jugador = 0
}

Jugador.__index = Jugador

Vertice.__index = Vertice 

Camino.__index = Camino


function Jugador:nuevo(nombre)
    local nuevo_jugador = {}
    setmetatable(nuevo_jugador,self)
    self.__index = self
    nuevo_jugador.nombre = nombre
    return nuevo_jugador
end

function Vertice:nuevo()
    local nuevo_vertice = {}
    setmetatable(nuevo_vertice,self)
    self.__index = self
    return nuevo_vertice
end

function Camino:nuevo()
    local nuevo_camino = {}
    setmetatable(nuevo_camino,self)
    self.__index = self
    return nuevo_camino
end

-- Funciones
local function pasalo()
    
    textoTiempo.isVisible = false
    if ronda >= 2 then
        if tirarDados == false then
            actualizaDado()
        else
            tirarDados = false
        end
        timer.pause(temporizador);
    end
    background2.isVisible = true
    for i = 1, 54 do
        verticesC[i].isVisible = false
    end
    for i = 1, 72 do
        aristas[i].isVisible = false
    end
    for i = 1, 6 do
        cantidadesCartas[i].isVisible = false
    end

    --[[for i = 1, 4 do
        for j=1, 5 do
            cartaEsp[i][j].isVisi
        end
        
    end]]

    pasar.isVisible = true
    seguir.isVisible = true
    textoRonda.isVisible = false
    --jugando.isVisible = false
end

local function saberJugador(event,CartaRecibir, Dar)
    local imagenClicada = event.target
    local posi
    for i, imagen in ipairs(btnAceptarT) do
        if imagen == imagenClicada then
            posi = i
            break
        end 
    end
    seleccionParaDarJugador(true, CartaRecibir, Dar, posi)
    
    
end

local function tradeoPlayers(CartaRecibir, Dar, bank, user)
    bank.isVisible = false
    user.isVisible = false
    local rec
    local da
    if CartaRecibir ==1 then
        rec = 'arbol'
    elseif CartaRecibir == 2 then
        rec = 'trigo'
    elseif CartaRecibir == 3 then
        rec = 'arcilla'
    elseif CartaRecibir == 4 then
        rec = 'vacas'
    elseif CartaRecibir == 5 then
        rec = 'rocas'
    end
    if Dar ==1 then
        da = 'arbol'
    elseif Dar == 2 then
        da = 'trigo'
    elseif Dar == 3 then
        da = 'arcilla'
    elseif Dar == 4 then
        da = 'vacas'
    elseif Dar == 5 then
        da = 'rocas'
    end
    tradeoTexto = display.newText("El jugador, "..jugadores[jugadorActual].nombre.." ha ofrecido "..da.." a cambio de " ..rec, cx, cy -500, native.systemFont, 70)
    textoTiempo.isVisible = false
    background2.isVisible = true
    btnBanco.isVisible = false
    btnJugadores.isVisible = false
    textoRonda.isVisible = false
    
    for i = 1, 54 do
        verticesC[i].isVisible = false
    end
    for i = 1, 72 do
        aristas[i].isVisible = false
    end
    for i = 1, 6 do
        cantidadesCartas[i].isVisible = false
    end

    local usuario1 = display.newImageRect(grpPartida,"Imagenes/CartasM/usuario4.png", 285, 370)
    usuario1.x = cx - 300 
    usuario1.y = cy - 300
    usuariosTradeando[1] = usuario1

    local aceptar3 = display.newImageRect(grpPartida,"Imagenes/Menu/aceptar.png", 285, 100)
    aceptar3.x = cx - 300
    aceptar3.y = cy + 470
    btnAceptarT[3] = aceptar3

    local usuario2 = display.newImageRect(grpPartida,"Imagenes/CartasM/usuario3.png", 285, 370)
    usuario2.x = cx + 300
    usuario2.y = cy - 300
    usuariosTradeando[2] = usuario2

    local aceptar4 = display.newImageRect(grpPartida,"Imagenes/Menu/aceptar.png", 285, 100)
    aceptar4.x = cx + 300
    aceptar4.y = cy + 470
    btnAceptarT[4] = aceptar4

    local usuario3 = display.newImageRect(grpPartida,"Imagenes/CartasM/usuario1.png", 285, 370)
    usuario3.x = cx - 300
    usuario3.y = cy + 300
    usuariosTradeando[3] = usuario3

    local aceptar1 = display.newImageRect(grpPartida,"Imagenes/Menu/aceptar.png", 285, 100)
    aceptar1.x = cx - 300
    aceptar1.y = cy - 120
    btnAceptarT[2] = aceptar1

    local usuario4 = display.newImageRect(grpPartida,"Imagenes/CartasM/usuario2.png", 285, 370)
    usuario4.x = cx + 300
    usuario4.y = cy + 300
    usuariosTradeando[4] = usuario4

    local aceptar2 = display.newImageRect(grpPartida,"Imagenes/Menu/aceptar.png", 285, 100)
    aceptar2.x = cx + 300
    aceptar2.y = cy - 120
    btnAceptarT[1] = aceptar2

    

    

    btnRechazar = display.newImageRect(grpPartida,"Imagenes/Menu/rechazar.png", 285, 100)
    btnRechazar.x = cx
    btnRechazar.y = cy + 50

    if jugadorActual == 1 then
        btnAceptarT[1].isVisible = false
    elseif jugadorActual == 2 then
        btnAceptarT[2].isVisible = false
    elseif jugadorActual == 3  then
        btnAceptarT[3].isVisible = false
    else
        btnAceptarT[4].isVisible = false
    end
   
    for i =1, 4 do
        btnAceptarT[i]:addEventListener("tap", function(event) saberJugador(event, CartaRecibir, Dar) end)
    end
    --jugando.isVisible = false
end


local function salirAlMenu()
    
    --local currentScene = composer.getSceneName("current")
    --if currentScene then
    --    composer.removeScene(currentScene, true)
    --end
    --composer.gotoScene("scenes.menu")
    native.requestExit()
    
end

local function ganador(jugador)
    textoTiempo.isVisible = false
    timer.pause(temporizador);
    background2.isVisible = true
    for i = 1, 54 do
        verticesC[i].isVisible = false
    end
    for i = 1, 72 do
        aristas[i].isVisible = false
    end
    for i = 1, 6 do
        cantidadesCartas[i].isVisible = false
    end
    local trofeo = display.newImageRect(grpPartida,"Imagenes/Construccion/trofeo.png", 500, 500)
    trofeo.x = cx
    trofeo.y = cy
    local textoGanaste = display.newText("¡Felicidades, "..jugador.." has ganado!", cx, cy -300, native.systemFont, 70)
    local salir = display.newImageRect(grpPartida,"Imagenes/Menu/salir.png", 450,150)
    salir.x = cx
    salir.y = cy + 400
    salir:addEventListener("tap", salirAlMenu)
    --pasar.isVisible = true
    --seguir.isVisible = true
    --jugando.isVisible = false
end

local function verificarGanador()
    for i =1, 4 do
        if jugadores[i].puntos == 10 then
            ganador(jugadores[i].nombre)
        end
    end

end

local function actualizarTextoRecursos()
    cantidadesCartas[1].text = string.format(jugadores[jugadorActual].cartas1)
    cantidadesCartas[2].text = string.format(jugadores[jugadorActual].cartas2)
    cantidadesCartas[3].text = string.format(jugadores[jugadorActual].cartas3)
    cantidadesCartas[4].text = string.format(jugadores[jugadorActual].cartas4)
    cantidadesCartas[5].text = string.format(jugadores[jugadorActual].cartas5)
    cantidadesCartas[6].text = string.format(jugadores[jugadorActual].cartas6)
    
end

local function actualizarTextoCartasT()
    for i = 1, 4 do
        textoCartasT[i].text = string.format(jugadores[i].cartas1 + jugadores[i].cartas2 + jugadores[i].cartas3 + jugadores[i].cartas4 + jugadores[i].cartas5)
    end
end

local function actualizarTextoPuntos()
    for i = 1, 4 do
        textoPuntos[i].text = string.format(jugadores[i].puntos)
    end
end

local function actualizarTextoEspeciales()
    for i = 1, 4 do
        for j = 1, 5 do
            textoEspeciales[i][j].text = string.format(especiales[i][j])
        end
        
    end
end

local function desactivarCaminos()
    for i =1, 72 do
        if aristaClase[i].ocupado == false then
            aristas[i].isVisible = false
        end
    end        
end

local function colocarHexagonos() --Funcion para randomizar el tipo de hexagono
    local valor
    local bandera = false
    while bandera == false do
        valor = math.random(6)
        if valor < 6 then
            if rep[valor] < 4 then
                rep[valor] = rep[valor] + 1
                numeroHexagonos[posicion][1] = valor
                posicion = posicion + 1
                return valor 
            end
        elseif rep[valor] < 1 then
            rep[valor] = rep[valor] + 1
            numeroHexagonos[posicion][1] = valor
            numeroHexagonos[posicion][2] = 7
            posicion = posicion + 1
            return valor
        end   
    end
end

local function asignarProbabilidad(posicion) --Funcion para randomizar la probabilidad de hexagono
    local valor
    local bandera = false
    while bandera == false do
        valor = math.random(11)
        if probabilidad[valor] > 0 then
        probabilidad[valor] = probabilidad[valor] - 1
        numeroHexagonos[posicion][2] = valor 
        return valor
        end   
    end
end

local function actualizarRecursos() --La funcion mas larga, es para actualizar las cartas de los jugadores, si usted que lee esto tiene una idea para hacerla corta, adelante
    for i =1, 4 do
        if jugadores[i].cartas1 == 0 then 
            cartasjugador[i][1].fill = { type="image", filename="Imagenes/CartasM/vacia.png" }
        elseif jugadores[i].cartas1 >=3 then
            cartasjugador[i][1].fill = { type="image", filename="Imagenes/CartasM/cartas13.png" }
        elseif jugadores[i].cartas1 ==2 then
            cartasjugador[i][1].fill = { type="image", filename="Imagenes/CartasM/cartas12.png" }
        else
            cartasjugador[i][1].fill = { type="image", filename="Imagenes/CartasM/cartas11.png" }
        end
        if jugadores[i].cartas2 == 0 then 
            cartasjugador[i][2].fill = { type="image", filename="Imagenes/CartasM/vacia.png" }
        elseif jugadores[i].cartas2 >=3 then
            cartasjugador[i][2].fill = { type="image", filename="Imagenes/CartasM/cartas23.png" }
        elseif jugadores[i].cartas2 ==2 then
            cartasjugador[i][2].fill = { type="image", filename="Imagenes/CartasM/cartas22.png" }
        else
            cartasjugador[i][2].fill = { type="image", filename="Imagenes/CartasM/cartas21.png" }
        end
        if jugadores[i].cartas3 == 0 then 
            cartasjugador[i][3].fill = { type="image", filename="Imagenes/CartasM/vacia.png" }
        elseif jugadores[i].cartas3 >=3 then
            cartasjugador[i][3].fill = { type="image", filename="Imagenes/CartasM/cartas33.png" }
        elseif jugadores[i].cartas3 ==2 then
            cartasjugador[i][3].fill = { type="image", filename="Imagenes/CartasM/cartas32.png" }
        else
            cartasjugador[i][3].fill = { type="image", filename="Imagenes/CartasM/cartas31.png" }
        end
        if jugadores[i].cartas4 == 0 then 
            cartasjugador[i][4].fill = { type="image", filename="Imagenes/CartasM/vacia.png" }
        elseif jugadores[i].cartas4 >=3 then
            cartasjugador[i][4].fill = { type="image", filename="Imagenes/CartasM/cartas43.png" }
        elseif jugadores[i].cartas4 ==2 then
            cartasjugador[i][4].fill = { type="image", filename="Imagenes/CartasM/cartas42.png" }
        else
            cartasjugador[i][4].fill = { type="image", filename="Imagenes/CartasM/cartas41.png" }
        end
        if jugadores[i].cartas5 == 0 then 
            cartasjugador[i][5].fill = { type="image", filename="Imagenes/CartasM/vacia.png" }
        elseif jugadores[i].cartas5 >=3 then
            cartasjugador[i][5].fill = { type="image", filename="Imagenes/CartasM/cartas53.png" }
        elseif jugadores[i].cartas5 ==2 then
            cartasjugador[i][5].fill = { type="image", filename="Imagenes/CartasM/cartas52.png" }
        else
            cartasjugador[i][5].fill = { type="image", filename="Imagenes/CartasM/cartas51.png" }
        end
        if jugadores[i].cartas6 == 0 then 
            cartasjugador[i][6].fill = { type="image", filename="Imagenes/CartasM/vacia.png" }
        else
            cartasjugador[i][6].fill = { type="image", filename="Imagenes/CartasM/tcartas.png" }
        end
    end
    actualizarTextoRecursos()
    actualizarTextoCartasT()
end

local function aumentar(carta, i)
        if carta == 1 then
            jugadores[i].cartas1 = jugadores[i].cartas1 + 1
        elseif carta == 2  then
            jugadores[i].cartas2 = jugadores[i].cartas2 + 1
        elseif carta == 3  then
            jugadores[i].cartas3 = jugadores[i].cartas3 + 1
        elseif carta == 4  then
            jugadores[i].cartas4 = jugadores[i].cartas4 + 1
        elseif carta == 5  then
            jugadores[i].cartas5 = jugadores[i].cartas5 + 1
        end
        actualizarRecursos()
end

local function verOcupacion(j, i)
    if verticeClase[j].ocupado == true then
        aumentar(numeroHexagonos[i][1], verticeClase[j].jugador)
    end
end

local function actualizarTextoTiempo()
    local minutos = math.floor(tiempoRestante / 60)
    local segundos = tiempoRestante % 60
    local tiempoFormateado = string.format("%02d:%02d", minutos, segundos)
    textoTiempo.text = tiempoFormateado
end





local function continuaCaminos(arista)
    for j =1, 72 do
        
        if arista.verticeI == aristaClase[j].verticeI then
            if aristas[j].isVisible == false then
                aristas[j].isVisible = true
            end
        elseif arista.verticeF == aristaClase[j].verticeI then
            if aristas[j].isVisible == false then
                aristas[j].isVisible = true
            end
        elseif arista.verticeI == aristaClase[j].verticeF then
            if aristas[j].isVisible == false then
                aristas[j].isVisible = true
            end
        elseif arista.verticeF == aristaClase[j].verticeF then
            if aristas[j].isVisible == false then
                aristas[j].isVisible = true
            end
        end
        
    end
end

local function activarCaminos()
    for i = 1, 54 do
        if verticeClase[i].jugador == jugadorActual then
          for j = 1, 72 do
            if aristaClase[j].verticeI == verticeClase[i] or aristaClase[j].verticeF == verticeClase[i] then
                aristas[j].isVisible = true
            end             
          end  
        end
    end
end

local function reactivarCaminos()
    activarCaminos()
    for i = 1, 72 do
        if aristaClase[i].jugador == jugadorActual then
            continuaCaminos(aristaClase[i])
        end
    end
end

local function moverLadron(event)
    local imagenClicada = event.target
    local posi = 0
    for i = 1, 19 do
        if hexagonosM[i] == imagenClicada then
                posi = i
                print(posi)
            break
        end
    end

    if probabilidadA == 0 then
        probabilidadA = numeroHexagonos[posi][2] --La probalidad antes de ladron
        posicionLadronA = posi --Ubicacion del ladron
        probHex[posi].fill = { type="image", filename=imgNum[6]}
       -- probHex[posi].isVisible = false
        numeroHexagonos[posi][2] = numeroHexagonos[posi][2] + 40 --Que no de recursos
    else
        probHex[posicionLadronA].fill = { type="image", filename=imgNum[probabilidadA]}
        numeroHexagonos[posicionLadronA][2] = numeroHexagonos[posicionLadronA][2] - 40
        probabilidadA = numeroHexagonos[posi][2]
        posicionLadronA = posi
        numeroHexagonos[posi][2] = numeroHexagonos[posi][2] + 40
        probHex[posicionLadronA].fill = { type="image", filename=imgNum[6]}
    end
    for i = 1, 19 do
        hexagonosM[i]:removeEventListener("tap",moverLadron)
    end
    boton:addEventListener("tap", pasalo)

    --hexagonosM[hexagono].
end

local function obtenerRecursos()
    local probabilidad = dice1 + dice2
    if probabilidad ~= 7 then
        for i =1, 19 do
            if numeroHexagonos[i][2] == probabilidad -1 then
                for j = 1, 6 do
                    verOcupacion(numeroHexagonos[i][3][j], i)
                end
                
            end
        end
    else
        boton:removeEventListener("tap", pasalo)
        for i = 1, 19 do
            hexagonosM[i]:addEventListener("tap",moverLadron)
        end
    end
    
end


local function actualizarTemporizador()
    tiempoRestante = tiempoRestante - 1
    
    if tiempoRestante <= 0 then
        timer.cancel(temporizador)
        tiempoRestante = 40
        temporizador = timer.performWithDelay(1000, actualizarTemporizador, tiempoTotal)
        pasalo()
    else
        actualizarTextoTiempo()
        
    end
end
function actualizaDado() --Función para cambiar la imagen de los dados
    tirarDados = true
    dice1 = math.random(6)
    dice2 = math.random(6)
    if turno == true then
        turno = false
        dado1.fill = { type="image", filename="Imagenes/dado"..dice1..".png" }
        dado2.fill = { type="image", filename="Imagenes/dado"..dice2..".png" }
        obtenerRecursos()
        boton:addEventListener("tap", pasalo)
    end
end

function pasarTurno() --Función para pasar el Turno al siguiente jugador. 
    textoTiempo.isVisible = true
    if ronda >= 2 then
        timer.resume(temporizador)
        tirarDados = false    
    end
    background2.isVisible = false
    pasar.isVisible = false
    seguir.isVisible = false
    textoRonda.isVisible = true
    --jugando.isVisible = true
    if ronda == 1 then
        boton:removeEventListener("tap", pasalo)
    end
    if ronda >=2 then
        boton:removeEventListener("tap", pasalo)
    end
    if ronda == 1 and jugadorActual == 4 then
        dado1:addEventListener("tap", actualizaDado) --Se le agrega el evento a los dados para que puedan lanzarse
        dado2:addEventListener("tap", actualizaDado)
    end
    for i in ipairs(verticeClase) do
        if ronda > 1 then
            if verticeClase[i].ocupado == true then
                verticesC[i].isVisible = true
            end
        else
            verticesC[i].isVisible = true
        end
        
    end

    for i in ipairs(aristaClase) do
        if aristaClase[i].ocupado == true then
            aristas[i].isVisible = true
        end
    end
    for i = 1, 6 do
        cantidadesCartas[i].isVisible = true
    end
    turno = true
    if jugadorActual ==1 then 
        --jugando.text = jugadores[2].nombre
        cuadrosJugando[jugadorActual].isVisible = false
        jugadorActual = 2
        cuadrosJugando[jugadorActual].isVisible = true
        actualizarRecursos()
        grpJugadores[1].isVisible = false
        grpJugadores[2].isVisible = true


    elseif jugadorActual ==2 then
        actualizarRecursos()
        --jugando.text = jugadores[3].nombre
        cuadrosJugando[jugadorActual].isVisible = false
        jugadorActual = 3
        cuadrosJugando[jugadorActual].isVisible = true
        grpJugadores[2].isVisible = false
        grpJugadores[3].isVisible = true

    elseif jugadorActual ==3 then
        actualizarRecursos()
        --jugando.text = jugadores[4].nombre
        cuadrosJugando[jugadorActual].isVisible = false
        jugadorActual = 4
        cuadrosJugando[jugadorActual].isVisible = true
        grpJugadores[3].isVisible = false
        grpJugadores[4].isVisible = true
    else
        actualizarRecursos()
        --jugando.text = jugadores[1].nombre
        cuadrosJugando[jugadorActual].isVisible = false
        jugadorActual = 1
        cuadrosJugando[jugadorActual].isVisible = true
        ronda = ronda + 1
        if ronda == 2 then
            temporizador = timer.performWithDelay(1000, actualizarTemporizador, tiempoTotal)
            -- Inicializar el objeto de texto con el tiempo restante inicial
            tradeo:addEventListener("tap", elegir)
            btnBanco:addEventListener("tap", tradear)
            btnJugadores:addEventListener("tap",tradearJugadores)
        actualizarTextoTiempo()
        end
        textoRonda.text = "Ronda: "..ronda
        grpJugadores[4].isVisible = false
        grpJugadores[1].isVisible = true

    end
    if ronda >= 2 and jugadorActual > 1 then
        timer.cancel(temporizador)
        tiempoRestante = 40
        temporizador = timer.performWithDelay(1000, actualizarTemporizador, tiempoTotal)
        actualizarTextoTiempo()
    end
    
    desactivarCaminos()
    actualizarTextoRecursos()
    --reactivarCaminos()
end




local function dibujarNumeros()
    --NUMEROS
    local x = -255
    local y = -260

    for i = 1, 19 do
        if i == 4 then
            x = -320
            y = -150
        elseif i == 8 then
            x = -385
            y = -35
        elseif i == 13 then
            x = -320
            y = 75
        elseif i == 17 then
            x = -255
            y = 190
        end
        if numeroHexagonos[i][1] < 6 then
            local numero1 = display.newImageRect(grpPartida,imgNum[asignarProbabilidad(i)], 70, 100)
            numero1.x = display.contentCenterX + x
            numero1.y = display.contentCenterY + y
            table.insert(probHex,numero1)
        else
            local numero1 = display.newImageRect(grpPartida,imgNum[6], 60, 40)
            numero1.x = display.contentCenterX + x
            numero1.y = display.contentCenterY + y
            table.insert(probHex,numero1)
        end
        x = x + 130
    end
end

local function  colocarTextoCartas()
    local x = 180
    local y = 100
    for j =1, 6 do
        local cartas = display.newText("0", x - 90 , y, native.systemFont, 70)
        y = y + 150
        cantidadesCartas[j] = cartas
    end
end

local function colocarCartas()
    local x = 180
    local y = 80
    for i =1, 4 do
        x = 180
        y = 100
        for j =1, 6 do
            local carta = display.newImageRect(grpJugadores[i],"Imagenes/CartasM/vacia.png", 100, 140)
            carta.x =  x
            carta.y =  y
            y = y + 150
            table.insert(cartasjugador[i],carta)
        end
    end
    colocarTextoCartas()
end



local function dibujarHexagonos()
    --HEXAGONOS
    local x = -255
    local y = -295

    for i = 1, 19 do
        if i == 4 then
            x = -320
            y = -182
        elseif i == 8 then
            x = -385
            y = -70
        elseif i == 13 then
            x = -320
            y = 45
        elseif i == 17 then
            x = -255
            y = 160
        end
        local hexagono1 = display.newImageRect(grpPartida,imgHex[colocarHexagonos()], 135, 185)
        hexagono1.x = display.contentCenterX + x
        hexagono1.y = display.contentCenterY + y
        
        table.insert(hexagonosM,hexagono1)
        x = x + 130
    end
end

local function generarVertices()
    for i = 1, 54 do
        verticeClase[i] = Vertice:nuevo()
    end
end

local function colocaImagenArs(x, y)
    local arista = display.newImageRect(grpPartida,"Imagenes/Construccion/circuloMoradito.png", 15, 15)
    arista.x = display.contentCenterX + x 
    arista.y = display.contentCenterY + y
    table.insert(aristas,arista)
    arista.isVisible = false
end

local function agregarAdy()
    local q = 1
    for j = 1, 11 do
        if j == 1 then
            for i = 1, 6 do
                aristaClase[i].verticeI = verticeClase[i]
                aristaClase[i].verticeF = verticeClase[i+1]
                if i % 2 == 0 then
                    aristaClase[i].inclinacion = 1
                else
                    aristaClase[i].inclinacion = 2
                end
            end
        elseif j == 2 then
            for i = 1, 4 do
                aristaClase[i+6].verticeI = verticeClase[q]
                aristaClase[i+6].verticeF = verticeClase[q+8]
                q = q + 2
            end
        elseif j==3 then
            for i = 1, 8 do
                aristaClase[i+10].verticeI = verticeClase[i+7]
                aristaClase[i+10].verticeF = verticeClase[i+8]
                if i % 2 == 0 then
                    aristaClase[i+10].inclinacion = 1
                else
                    aristaClase[i+10].inclinacion = 2
                end
            end
        elseif j == 4 then
            q = 8
            for i =1, 5 do
                aristaClase[i+18].verticeI = verticeClase[q]
                aristaClase[i+18].verticeF = verticeClase[q+10]
                q = q + 2
            end
        elseif j == 5 then
            for i =1, 10 do
                aristaClase[i+23].verticeI = verticeClase[i+16]
                aristaClase[i+23].verticeF = verticeClase[i+17]
                if i % 2 == 0 then
                    aristaClase[i+23].inclinacion = 1
                else
                    aristaClase[i+23].inclinacion = 2
                end
            end
        elseif j == 6 then
            q = 17
            for i =1, 6 do
                aristaClase[i+33].verticeI = verticeClase[q]
                aristaClase[i+33].verticeF = verticeClase[q+11]
                q = q + 2
            end
        elseif j == 7 then
            for i =1, 10 do
                aristaClase[i+39].verticeI = verticeClase[i+27]
                aristaClase[i+39].verticeF = verticeClase[i+28]
                if i % 2 == 0 then
                    aristaClase[i+39].inclinacion = 2
                else
                    aristaClase[i+39].inclinacion = 1
                end
            end
        elseif j == 8 then
            q = 29
            for i =1, 5 do
                aristaClase[i+49].verticeI = verticeClase[q]
                aristaClase[i+49].verticeF = verticeClase[q+10]
                q = q + 2
            end
        elseif j==9 then
            for i = 1, 8 do
                aristaClase[i+54].verticeI = verticeClase[i+38]
                aristaClase[i+54].verticeF = verticeClase[i+39]
                if i % 2 == 0 then
                    aristaClase[i+54].inclinacion = 2
                else
                    aristaClase[i+54].inclinacion = 1
                end
            end
        elseif j == 10 then
            q = 40
            for i =1, 4 do
                aristaClase[i+62].verticeI = verticeClase[q]
                aristaClase[i+62].verticeF = verticeClase[q+8]
                q = q +2
            end
            
        elseif j == 11  then
            for i = 1, 6 do
                aristaClase[i+66].verticeI = verticeClase[i+47]
                aristaClase[i+66].verticeF = verticeClase[i+48]
                if i % 2 == 0 then
                    aristaClase[i+66].inclinacion = 2
                else
                    aristaClase[i+66].inclinacion = 1
                end
            end
        end
    end
end

local function generarAristas()
    for i = 1, 72 do
        aristaClase[i] = Camino:nuevo()
    end
    agregarAdy()
end

local function dibujarArista()
    local x = -285
    local y = -355
    for j = 1, 11 do
        if j == 2 then
            x = -316
            y = -295
            for i =1, 4 do
                colocaImagenArs(x, y)
                x = x + 128 
            end
        elseif j == 1  then
            for i = 1, 6 do
                colocaImagenArs(x, y)
                x = x + 65 
            end
        elseif j==3 then
            x = -350
            y = -240
            for i = 1, 8 do
                colocaImagenArs(x, y)
                x = x + 65 
            end
        elseif j == 4 then
            x = -380
            y = -185
            for i =1, 5 do
                colocaImagenArs(x, y)
                x = x + 128 
            end
        elseif j == 5 then
            x = -415
            y = -128
            for i =1, 10 do
                colocaImagenArs(x, y)
                x = x + 65
            end
        elseif j == 6 then
            x = -445
            y = -70
            for i =1, 6 do
                colocaImagenArs(x, y)
                x = x + 128 
            end
        elseif j == 7 then
            x = -415
            y = -20
            for i =1, 10 do
                colocaImagenArs(x, y)
                x = x + 65
            end
        elseif j == 8 then
            x = -380
            y = 44
            for i =1, 5 do
                colocaImagenArs(x, y)
                x = x + 128 
            end
        elseif j==9 then
            x = -350
            y = 97
            for i = 1, 8 do
                colocaImagenArs(x, y)
                x = x + 65 
            end
        elseif j == 10 then
            x = -315
            y = 155
            for i =1, 4 do
                colocaImagenArs(x, y)
                x = x + 128 
            end
        elseif j == 11  then
            x = -283
            y = 210
            for i = 1, 6 do
                colocaImagenArs(x, y)
                x = x + 65
            end
        end 
   
    end 
    generarAristas()
end

local function dibujarVertices()
    local x = -255
    local y = -295
    local ubx = - 60
    local uby = - 40
    for i = 1, 19 do
        if i == 4 then
            x = -320
            y = -182
        elseif i == 8 then
            x = -385
            y = -70
        elseif i == 13 then
            x = -320
            y = 45
        elseif i == 17 then
            x = -255
            y = 160
        end
        uby = - 40
        ubx = - 60 
        
        for j =1, 2 do
            local vertice = display.newImageRect(grpPartida,"Imagenes/Construccion/circulo.png", 15, 15)
            vertice.x = display.contentCenterX + x + ubx
            vertice.y = display.contentCenterY + y + uby
            table.insert(verticesC, vertice)
            uby = uby * 2
            ubx = ubx + 60 
        end
        x = x + 130
        if i == 3 or i == 7 or i == 12 or i == 16 or i == 19 then 
            local vertice = display.newImageRect(grpPartida,"Imagenes/Construccion/circulo.png", 15, 15)
            uby = uby/4
            vertice.x = display.contentCenterX + x - 65
            vertice.y = display.contentCenterY + y + uby
            table.insert(verticesC, vertice)

        elseif i == 13 then
            local vertice = display.newImageRect(grpPartida,"Imagenes/Construccion/circulo.png", 15, 15)
            vertice.x = display.contentCenterX + x - 255
            vertice.y = display.contentCenterY + y - 75
            table.insert(verticesC, vertice)
            
            local vertice = display.newImageRect(grpPartida,"Imagenes/Construccion/circulo.png", 15, 15)
            vertice.x = display.contentCenterX + x - 195
            vertice.y = display.contentCenterY + y + 30
            table.insert(verticesC, vertice)
        end
        
        if i == 17 or i == 18 or i == 19 then
            local vertice = display.newImageRect(grpPartida,"Imagenes/Construccion/circulo.png", 15, 15)
            uby = uby/4
            vertice.x = display.contentCenterX + x - 130
            vertice.y = display.contentCenterY + y + 60
            table.insert(verticesC, vertice)

            local vertice = display.newImageRect(grpPartida,"Imagenes/Construccion/circulo.png", 15, 15)
            vertice.x = display.contentCenterX + x - 190
            vertice.y = display.contentCenterY + y + 30
            table.insert(verticesC, vertice)
        end

        if i == 19 then
            local vertice = display.newImageRect(grpPartida,"Imagenes/Construccion/circulo.png", 15, 15)
            vertice.x = display.contentCenterX + x + 65
            vertice.y = display.contentCenterY + y - 195
            table.insert(verticesC, vertice)
            
            local vertice = display.newImageRect(grpPartida,"Imagenes/Construccion/circulo.png", 15, 15)
            vertice.x = display.contentCenterX + x
            vertice.y = display.contentCenterY + y - 80
            table.insert(verticesC, vertice)
            
            local vertice = display.newImageRect(grpPartida,"Imagenes/Construccion/circulo.png", 15, 15)
            vertice.x = display.contentCenterX + x - 65
            vertice.y = display.contentCenterY + y + 30
            table.insert(verticesC, vertice)
        end
        generarVertices()
    end
end

local function noSonAdyacentes(vertice1, vertice2)
    -- Verificar si vertice2 no está en la lista de adyacencia de vertice1
    for i, vecino in ipairs(grafo[vertice1]) do
        if vecino == vertice2 then
            return false
        end
    end
    -- Verificar si vertice1 no está en la lista de adyacencia de vertice2
    for i, vecino in ipairs(grafo[vertice2]) do
        if vecino == vertice1 then
            return false
        end
    end
    -- Si no se encontró en ninguna lista, entonces no son adyacentes
    return true
end

local function colocarCasas()

    for i in ipairs(verticesC) do
        if verticeClase[i].ocupado == false then
        verticesC[i].isVisible = false
        end    
    end
   
    for posicion = 1, 54 do
        if verticeClase[posicion].ocupado == true and verticeClase[posicion].jugador == jugadorActual then
            local banderaNoAdyacentes = true
            for i in ipairs(verticesC) do
                if verticeClase[i].ocupado == false then
                    if i ~= posicion then
                        banderaNoAdyacentes = noSonAdyacentes(posicion,i)
                        for j in ipairs(aristaClase) do
                            if (aristaClase[j].verticeI == verticeClase[i] or aristaClase[j].verticeF == verticeClase[i]) and aristaClase[j].ocupado == true and aristaClase[j].jugador == jugadorActual then
                                if banderaNoAdyacentes then
                                    verticesC[i].isVisible = true
                                end
                            end
                        end   
                    end
                end
            end
        end
    end   
end

local function intercambio(a,b) --Arregla las posiciones de los vertices
    local aux = verticesC[b]  
    verticesC[b] = verticesC[a]
    verticesC[a] = aux
end

local function verificarRecursos(i)
    if i == 1 then
        if jugadores[jugadorActual].cartas1>=1 and jugadores[jugadorActual].cartas2>=1 and jugadores[jugadorActual].cartas3>=1 and jugadores[jugadorActual].cartas4>=1 then
            return true
        end
    elseif i == 2 then 
        if jugadores[jugadorActual].cartas2>=3 and jugadores[jugadorActual].cartas5>=2 then
            return true
        end
    else
        if jugadores[jugadorActual].cartas1>=1 and jugadores[jugadorActual].cartas3>=1 then
            return true
        end 
    end
    return false
end

local function cambiarImagenC(event) --Coloca las casas 
    if jugadores[jugadorActual].ciudadesD >0 then
        local imagenClicada = event.target
        local posicion
        for i, imagen in ipairs(verticesC) do
            if imagen == imagenClicada then
                posicion = i
                break
            end 
        end
    
        if (verificarRecursos(2)) and verticeClase[posicion].jugador == jugadorActual then
            
            verticeClase[posicion].ocupado = true
            verticeClase[posicion].jugador = jugadorActual
            verticeClase[posicion].tipoC = 1
            
            jugadores[jugadorActual].cartas2 = jugadores[jugadorActual].cartas2 -3
            jugadores[jugadorActual].cartas5 = jugadores[jugadorActual].cartas5 -2
            imagenClicada.fill = { type="image", filename="Imagenes/Construccion/ciudad"..jugadorActual..".png" }
            imagenClicada:toFront()
            --imagenClicada:scale(5,5)
            imagenClicada.width = 75
            imagenClicada.height = 90
            actualizarRecursos()
            jugadores[jugadorActual].puntos = jugadores[jugadorActual].puntos + 1
            jugadores[jugadorActual].casasD = jugadores[jugadorActual].casasD + 1
            jugadores[jugadorActual].ciudadesD = jugadores[jugadorActual].ciudadesD - 1
            actualizarTextoPuntos()
            verificarGanador()
        end
    end

end
        
function cambiarCiudad()
    for i = 1, 54 do
        if verticeClase[i].ocupado == true and verticeClase[i].jugador == jugadorActual then
            verticesC[i]:addEventListener("tap", cambiarImagenC)
        end
    end
end

function quitar()
    for i = 1, 54 do
        if verticeClase[i].ocupado == true and verticeClase[i].jugador == jugadorActual then
            verticesC[i]:removeEventListener("tap", cambiarImagenC)
        end
    end
    ciudades:removeEventListener("tap", quitar)
    ciudades:addEventListener("tap", cambiarCiudad)
    
end

local function cambiarImagen(event) --Coloca las casas 
    if jugadores[jugadorActual].casasD > 0 then
        local imagenClicada = event.target
        local posicion
        for i, imagen in ipairs(verticesC) do
            if imagen == imagenClicada then
                posicion = i
                break
            end 
        end
        if verticeClase[posicion].ocupado == false then
            local banderaNoAdyacentes = true
            for i in ipairs(verticesC) do
                if verticeClase[i].ocupado == true then
                    banderaNoAdyacentes = noSonAdyacentes(posicion,i)
                    if banderaNoAdyacentes == false then
                        break
                    end
                end
            end


            if (verificarRecursos(1) or (ronda == 1 and jugadores[jugadorActual].casaL >= 1)) and banderaNoAdyacentes == true then
                
                verticeClase[posicion].ocupado = true
                verticeClase[posicion].jugador = jugadorActual
                verticeClase[posicion].tipoC = 1
                if ronda ==1 then
                    jugadores[jugadorActual].casaL = jugadores[jugadorActual].casaL -1
                    if jugadores[jugadorActual].caminoL == 0 and jugadores[jugadorActual].casaL == 0 then
                        boton:addEventListener("tap", pasalo) --Se le agrega el evento al objeto para pasar Turno
                    end 
                else
                    jugadores[jugadorActual].cartas1 = jugadores[jugadorActual].cartas1 -1
                    jugadores[jugadorActual].cartas2 = jugadores[jugadorActual].cartas2 -1
                    jugadores[jugadorActual].cartas3 = jugadores[jugadorActual].cartas3 -1
                    jugadores[jugadorActual].cartas4 = jugadores[jugadorActual].cartas4 -1
                end
                imagenClicada.fill = { type="image", filename="Imagenes/Construccion/casa"..jugadorActual..".png" }
                imagenClicada:toFront()
                --imagenClicada:scale(5,5)
                imagenClicada.width = 75
                imagenClicada.height = 90
                actualizarRecursos()
                jugadores[jugadorActual].puntos = jugadores[jugadorActual].puntos + 1
                jugadores[jugadorActual].casasD = jugadores[jugadorActual].casasD -1
                actualizarTextoPuntos()
                verificarGanador()
                activarCaminos()
            end
            banderaNoAdyacentes = true
            --print(posicion)
            
        end
        
    end
    
        
end

local function cambiarImagen2(event) --Coloca las casas 
    if jugadores[jugadorActual].caminosD > 0 then
        local imagenClicada = event.target
        local posicion
        for i, imagen in ipairs(aristas) do
            if imagen == imagenClicada then
                posicion = i
                break
            end 
        end
    
        if verificarRecursos(0) or (ronda ==1 and jugadores[jugadorActual].caminoL > 0) or (caminosFlag == true and jugadores[jugadorActual].caminoL > 0) then
            if ronda ==1 then
                jugadores[jugadorActual].caminoL = jugadores[jugadorActual].caminoL -1
                if jugadores[jugadorActual].caminoL == 0 and jugadores[jugadorActual].casaL == 0 then
                    boton:addEventListener("tap", pasalo) --Se le agrega el evento al objeto para pasar Turno
                end 
            else
                jugadores[jugadorActual].cartas1 = jugadores[jugadorActual].cartas1 -1
                jugadores[jugadorActual].cartas3 = jugadores[jugadorActual].cartas3 -1
            end
            imagenClicada.fill = { type="image", filename="Imagenes/caminos/"..jugadorActual..aristaClase[posicion].inclinacion..".png" }
            imagenClicada.width = 75
            imagenClicada.height = 70
            imagenClicada:removeEventListener("tap",cambiarImagen2)
            actualizarRecursos() 
            continuaCaminos(aristaClase[posicion])
            aristaClase[posicion].ocupado = true
            aristaClase[posicion].jugador = jugadorActual
            jugadores[jugadorActual].caminosD = jugadores[jugadorActual].caminosD -1  
        end            
    end
    
end

local function COMOQUIERAS2()  --Les agrega la funcion de que sis on tocadas se puedan convertir a casa o ciudad. 
    for i = 1, 72 do
        aristas[i]:addEventListener("tap",cambiarImagen2)
    end
end


local function COMOQUIERAS()  --Les agrega la funcion de que sis on tocadas se puedan convertir a casa o ciudad. 
    for i = 1, 54 do
        verticesC[i]:addEventListener("tap",cambiarImagen)
    end
end

local function hazLaLuz()

    dibujarVertices()
    intercambio(28,30)
    intercambio(29,30)
    intercambio(32,31)
    intercambio(33,32)
    intercambio(33,34)
    intercambio(34,35)
    intercambio(35,36)
    intercambio(36,37)
    intercambio(37,38)
    intercambio(38,52)
    intercambio(39,52)
    intercambio(40,52)
    intercambio(41,52)
    intercambio(42,43)
    intercambio(43,44)
    intercambio(47,44)
    intercambio(45,48)
    intercambio(46,49)
    intercambio(49,50)
    intercambio(47,53)
    intercambio(49,52)
    intercambio(51,48)
    intercambio(48,53)
    intercambio(53,52)
    COMOQUIERAS()

end

local btnvisibles = false


local function aparecerBotonesDeTradeo()
    btnJugadores = display.newImageRect(grpPartida,"Imagenes/Menu/jugadores.png", 200,80)
    btnJugadores.x = cx - 400
    btnJugadores.y = cy + 350
    
    btnBanco = display.newImageRect(grpPartida,"Imagenes/Menu/banco.png", 200,80)
    btnBanco.x = cx - 400
    btnBanco.y = cy + 250
    
    btnJugadores.isVisible = false
    btnBanco.isVisible = false

end

function elegir()
    if btnvisibles == false then
        btnJugadores.isVisible = true
        btnBanco.isVisible = true
        btnvisibles = true
    else
        btnJugadores.isVisible = false
        btnBanco.isVisible = false
        btnvisibles = false
    end
end

local bandEspeciales = false
local cartaEsp = {{},{},{},{}}

local function colocarTextoEspeciales()
    

    for i = 1, 4 do
        local x = 300
        local y = 850

        for j = 1, 5 do
            textoEspeciales[i][j] = display.newText(grpPartida,"0", x, y+85, native.systemFont, 30 )
            textoEspeciales[i][j]:setFillColor(255,255,255);
            textoEspeciales[i][j].isVisible = false
            x = x + 120
        end

    end
end


local function ladronEsp()
    if especiales[jugadorActual][1] > 0 then
        especiales[jugadorActual][1] = especiales[jugadorActual][1] - 1
        actualizarRecursos()
        jugadores[jugadorActual].cartas6 = jugadores[jugadorActual].cartas6 - 1
        actualizarTextoEspeciales()
        actualizarRecursos()
        for i = 1, 19 do
            hexagonosM[i]:addEventListener("tap",moverLadron)
        end
    end
    
end

local function puntoMas()
    if especiales[jugadorActual][2] > 0 then
        especiales[jugadorActual][2] = especiales[jugadorActual][2] - 1
        jugadores[jugadorActual].cartas6 = jugadores[jugadorActual].cartas6 - 1
        actualizarRecursos()
        actualizarTextoEspeciales()
        jugadores[jugadorActual].puntos = jugadores[jugadorActual].puntos + 1
        actualizarTextoPuntos()
    end
    
end

local function dosCaminos()
    if especiales[jugadorActual][3] > 0 then
        especiales[jugadorActual][3] = especiales[jugadorActual][3] - 1
        actualizarRecursos()
        jugadores[jugadorActual].cartas6 = jugadores[jugadorActual].cartas6 - 1
        actualizarTextoEspeciales()
        caminosFlag = true
        jugadores[jugadorActual].caminoL = jugadores[jugadorActual].caminoL + 2
        activarCaminos()
    end
    
end

local function robarTodo(event)
    especiales[jugadorActual][3] = especiales[jugadorActual][5] - 1
    actualizarRecursos()
    jugadores[jugadorActual].cartas6 = jugadores[jugadorActual].cartas6 - 1
    actualizarTextoEspeciales()

    local imagenClicada = event.target
    local posi = 0
    for i = 1, 5 do
        if cartaRobar[i] == imagenClicada then
                posi = i
                print(posi)
            break
        end
    end

    local acumulado = 0

    for i = 1, 4 do
        if posi == 1 then
            acumulado = acumulado + jugadores[i].cartas1
        elseif posi == 2 then
            acumulado = acumulado + jugadores[i].cartas2
        elseif posi == 3 then
            acumulado = acumulado + jugadores[i].cartas3
        elseif posi == 4 then
            acumulado = acumulado + jugadores[i].cartas4
        else
            acumulado = acumulado + jugadores[i].cartas5
        end
    end

    for i = 1, 4 do
        if posi == 1 then
            jugadores[i].cartas1 = 0
        elseif posi == 2 then
            jugadores[i].cartas2 = 0
        elseif posi == 3 then
            jugadores[i].cartas3 = 0
        elseif posi == 4 then
            jugadores[i].cartas4 = 0
        else
            jugadores[i].cartas5 = 0
        end
    end

    if posi == 1 then
        jugadores[jugadorActual].cartas1 = acumulado
    elseif posi == 2 then
        jugadores[jugadorActual].cartas2 = acumulado
    elseif posi == 3 then
        jugadores[jugadorActual].cartas3 = acumulado
    elseif posi == 4 then
        jugadores[jugadorActual].cartas4 = acumulado
    else
        jugadores[jugadorActual].cartas5 = acumulado
    end

    actualizarRecursos()
    actualizarTextoRecursos()
    actualizarTextoCartasT()
    
end

local function mostrarCartasRobarTodo()
    if especiales[jugadorActual][5] > 0 then
        for i = 1, 5 do
        cartaRobar[i].isVisible = true
        end
    end
    
end

local function colocarCartasRobarTodo()
    local x = 260
    local y = 80
    for i = 1, 5 do
        cartaRobar[i] = display.newImageRect(grpPartida,"Imagenes/CartasM/cartas"..i.."1.png", 100, 140)
        cartaRobar[i].x =  x    
        cartaRobar[i].y =  y
        cartaRobar[i]:addEventListener("tap",robarTodo)
        cartaRobar[i].isVisible = false
        y = y + 150
    end
    
end

local function colocarCartasEspeciales()
        for i = 1,4 do
            local x = 300
            local y = 850
    
            cartaEsp[i][1] = display.newImageRect(grpPartida,"Imagenes/CartasM/ladron.png", 100, 140)
            cartaEsp[i][1].x = x
            cartaEsp[i][1].y = y
            cartaEsp[i][1]:addEventListener("tap",ladronEsp)
            x = x + 120
            cartaEsp[i][1].isVisible = false
    
            cartaEsp[i][2] = display.newImageRect(grpPartida,"Imagenes/CartasM/punto.png", 100, 140)
            cartaEsp[i][2].x = x
            cartaEsp[i][2].y = y
            cartaEsp[i][2]:addEventListener("tap",puntoMas)
            x = x + 120
            cartaEsp[i][2].isVisible = false
    
            cartaEsp[i][3] = display.newImageRect(grpPartida,"Imagenes/CartasM/dcaminos.png", 100, 140)
            cartaEsp[i][3].x = x
            cartaEsp[i][3].y = y
            cartaEsp[i][3]:addEventListener("tap",dosCaminos)
            x = x + 120
            cartaEsp[i][3].isVisible = false
    
            cartaEsp[i][4] = display.newImageRect(grpPartida,"Imagenes/CartasM/dcartas.png", 100, 140)
            cartaEsp[i][4].x = x
            cartaEsp[i][4].y = y
            x = x + 120
            cartaEsp[i][4].isVisible = false
    
            cartaEsp[i][5] = display.newImageRect(grpPartida,"Imagenes/CartasM/especiales.png", 100, 140)
            cartaEsp[i][5].x = x
            cartaEsp[i][5].y = y
            cartaEsp[i][3]:addEventListener("tap",mostrarCartasRobarTodo)
            cartaEsp[i][5].isVisible = false
        end
end


local function tarjetasEspeciales()
    
    if bandEspeciales == false then
        actualizarTextoEspeciales()
        for i = 1, 5 do
            cartaEsp[jugadorActual][i].isVisible = true
            textoEspeciales[jugadorActual][i].isVisible = true
        end
    end

    if bandEspeciales == true then
        actualizarTextoEspeciales()
        for i = 1, 5 do
            cartaEsp[jugadorActual][i].isVisible = false
            textoEspeciales[jugadorActual][i].isVisible = false
        end
    end

    if bandEspeciales == false then
        bandEspeciales = true
    elseif bandEspeciales == true then
        bandEspeciales = false
    end

end


--Bolillo y SeRaTo12
local function terminar()
    rocaBank.isVisible = false
    trigoBank.isVisible = false
    vacaBank.isVisible = false
    ladrilloBank.isVisible = false
    arbolBank.isVisible = false
    cartasEspeciales.isVisible = false

    especialesUser.isVisible = false
    rocaUser.isVisible = false
    vacaUser.isVisible = false
    trigoUser.isVisible = false
    arbolUser.isVisible = false
    ladrilloUser.isVisible = false
    --elegir()
    
end



local function arbolTrade(event, carta)
    local i = jugadorActual
    if  verticeClase[4].ocupado or verticeClase[5].ocupado then
        if verticeClase[4].jugador == jugadorActual or verticeClase[5].jugador == jugadorActual then
            jugadores[i].cartas1 = jugadores[i].cartas1 - 2
        else
            jugadores[i].cartas1 = jugadores[i].cartas1 - 3
        end
    else
        jugadores[i].cartas1 = jugadores[i].cartas1 - 3
    end
    arbolUser.isVisible=false
    
    actualizarRecursos()
    local contador = true
    seleccionParaDar(contador,carta)
end


local function arbolTradeJugador(event, cartaRecibir, Dar, bank)
    tradeoPlayers(cartaRecibir, 1, bank, arbolUser)
    ladrilloUser.isVisible = false
    vacaUser.isVisible = false
    rocaUser.isVisible = false
    trigoUser.isVisible = false
end

local function trigoTradeJugador(event, cartaRecibir, Dar, bank)
    tradeoPlayers(cartaRecibir, 2, bank, trigoUser)
    arbolUser.isVisible = false
    ladrilloUser.isVisible = false
    vacaUser.isVisible = false
    rocaUser.isVisible = false
end

local function ladrilloTradeJugador(event, cartaRecibir, Dar, bank)
    tradeoPlayers(cartaRecibir, 3, bank, ladrilloUser)
    arbolUser.isVisible = false
    vacaUser.isVisible = false
    rocaUser.isVisible = false
    trigoUser.isVisible = false
end

local function vacaTradeJugador(event, cartaRecibir, Dar, bank)
    tradeoPlayers(cartaRecibir, 4, bank, vacaUser)
    arbolUser.isVisible = false
    ladrilloUser.isVisible = false
    rocaUser.isVisible = false
    trigoUser.isVisible = false
end

local function rocaTradeJugador(event, cartaRecibir, Dar, bank)
    tradeoPlayers(cartaRecibir, 5, bank, rocaUser)
    arbolUser.isVisible = false
    ladrilloUser.isVisible = false
    vacaUser.isVisible = false
    trigoUser.isVisible = false
end


local function trigoTrade(event, carta)
    local i = jugadorActual
    if verticeClase[1].ocupado or verticeClase[2].ocupado then
        if verticeClase[1].jugador == jugadorActual or verticeClase[2].jugador == jugadorActual then
            jugadores[i].cartas2 = jugadores[i].cartas2 - 2
        else
            jugadores[i].cartas2 = jugadores[i].cartas2 - 3
        end
    else
        jugadores[i].cartas2 = jugadores[i].cartas2 - 3
    end
    
    trigoUser.isVisible=false
    
    actualizarRecursos()
    local contador = true
    seleccionParaDar(contador,carta)
end

local function rocaTrade(event, carta)
    local i = jugadorActual

    if verticeClase[15].ocupado  or verticeClase[16].ocupado  then
        if verticeClase[15].jugador == jugadorActual or verticeClase[16].jugador == jugadorActual  then
            jugadores[i].cartas5 = jugadores[i].cartas5 - 2
        else
            jugadores[i].cartas5 = jugadores[i].cartas5 - 3
        end
    else
        jugadores[i].cartas5 = jugadores[i].cartas5 - 3
    end
    rocaUser.isVisible = false
   
    actualizarRecursos()
    local contador = true
    seleccionParaDar(contador,carta)
end

local function ladrilloTrade(event, carta)
    local i = jugadorActual

    if verticeClase[29].ocupado  or verticeClase[39].ocupado then
        if verticeClase[29].jugador == jugadorActual or verticeClase[39].jugador == jugadorActual then
            jugadores[i].cartas3 = jugadores[i].cartas3 - 2
        else
            jugadores[i].cartas3 = jugadores[i].cartas3 - 3
        end
    else
        jugadores[i].cartas3 = jugadores[i].cartas3 - 3
    end
    
    ladrilloUser.isVisible = false
    
    actualizarRecursos()
    local contador = true
    seleccionParaDar(contador,carta)
end

local function vacaTrade(event, carta)
    local i = jugadorActual
    if verticeClase[18].ocupado  or verticeClase[8].ocupado then
        if verticeClase[18].jugador == jugadorActual or verticeClase[8].jugador == jugadorActual then
            jugadores[i].cartas4 = jugadores[i].cartas4 - 2
        else
            jugadores[i].cartas4 = jugadores[i].cartas4 - 3
        end
    else
        jugadores[i].cartas4 = jugadores[i].cartas4 - 3
    end

   
    vacaUser.isVisible = false
    
    actualizarRecursos()
    local contador = true
    seleccionParaDar(contador,carta)
end



function seleccionParaDar(contador1, carta)
    
    arbolUser.isVisible = false
    ladrilloUser.isVisible = false
    vacaUser.isVisible = false
    rocaUser.isVisible = false
    trigoUser.isVisible = false
    print("tuputamadrejimbo")
    if contador1 then
        print(carta)
        if carta == 1 then
            jugadores[jugadorActual].cartas1 = jugadores[jugadorActual].cartas1 + 1
        elseif carta == 2 then
            jugadores[jugadorActual].cartas2 = jugadores[jugadorActual].cartas2 + 1
        elseif carta == 3 then
            jugadores[jugadorActual].cartas3 = jugadores[jugadorActual].cartas3 + 1
        elseif carta == 4 then
            jugadores[jugadorActual].cartas4 = jugadores[jugadorActual].cartas4 + 1
        elseif carta == 5 then
            jugadores[jugadorActual].cartas5 = jugadores[jugadorActual].cartas5 + 1
        elseif carta == 6 then
            jugadores[jugadorActual].cartas6 = jugadores[jugadorActual].cartas6 + 1
        end


        print("tuputamadrejimbo2")
        actualizarRecursos()
        timer.resume(temporizador)
        terminar()
        do return end
    end
    
    --actualizarRecursos()

    
    local i = jugadorActual
    if jugadores[i].cartas1 >= 3 then
        arbolUser.fill = { type="image", filename="Imagenes/CartasM/cartas11.png" }
        arbolUser.y = cy - 460
        arbolUser.x = cx - 600
        arbolUser.isVisible = true
    end
    if jugadores[i].cartas2 >=3 then
        trigoUser.fill = { type="image", filename="Imagenes/CartasM/cartas21.png" }
        trigoUser.y = cy - 310
        trigoUser.x = cx - 600
        trigoUser.isVisible = true
    end
    if jugadores[i].cartas3 >= 3 then
        ladrilloUser.fill = { type="image", filename="Imagenes/CartasM/cartas31.png" }
        ladrilloUser.y = cy - 160
        ladrilloUser.x = cx - 600
        ladrilloUser.isVisible = true
    end
    if jugadores[i].cartas4 >= 3 then
        vacaUser.fill = { type="image", filename="Imagenes/CartasM/cartas41.png" }
        vacaUser.y = cy - 10
        vacaUser.x = cx - 600
        vacaUser.isVisible = true
    end

    if jugadores[i].cartas5 >= 3 then
        rocaUser.fill = { type="image", filename="Imagenes/CartasM/cartas51.png" }
        rocaUser.y = cy + 140
        rocaUser.x = cx - 600
        rocaUser.isVisible = true
    end


    arbolUser:addEventListener("tap", function(event) arbolTrade(event, carta) end)
    trigoUser:addEventListener("tap", function(event) trigoTrade(event, carta) end)
    ladrilloUser:addEventListener("tap", function(event) ladrilloTrade(event, carta) end)
    vacaUser:addEventListener("tap", function(event) vacaTrade(event, carta) end)
    rocaUser:addEventListener("tap", function(event) rocaTrade(event, carta) end)
end


local function quitarCartas(dar,jug)
    if dar == 1 then
        jugadores[jug].cartas1 = jugadores[jug].cartas1 - 1
    elseif dar == 2 then
        jugadores[jug].cartas2 = jugadores[jug].cartas2 - 1
    elseif dar == 3 then
        jugadores[jug].cartas3 = jugadores[jug].cartas3 - 1
    elseif dar == 4 then
        jugadores[jug].cartas4 = jugadores[jug].cartas4 - 1
    elseif dar == 5 then
        jugadores[jug].cartas5 = jugadores[jug].cartas5 - 1
    end
end

local function sumarCartas(dar,jug)
    if dar == 1 then
        jugadores[jug].cartas1 = jugadores[jug].cartas1 + 1
    elseif dar == 2 then
        jugadores[jug].cartas2 = jugadores[jug].cartas2 + 1
    elseif dar == 3 then
        jugadores[jug].cartas3 = jugadores[jug].cartas3 + 1
    elseif dar == 4 then
        jugadores[jug].cartas4 = jugadores[jug].cartas4 + 1
    elseif dar == 5 then
        jugadores[jug].cartas5 = jugadores[jug].cartas5 + 1
    end
end


function seleccionParaDarJugador(contador1, cartaRecibir, Dar, jug, bank)
    
    arbolUser.isVisible = false
    ladrilloUser.isVisible = false
    vacaUser.isVisible = false
    rocaUser.isVisible = false
    trigoUser.isVisible = false
    print("tuputamadrejimbo")
    if contador1 then
        print(carta)
        if cartaRecibir == 1 then
            jugadores[jugadorActual].cartas1 = jugadores[jugadorActual].cartas1 + 1
            quitarCartas(cartaRecibir,jug)
            quitarCartas(Dar,jugadorActual)
            sumarCartas(Dar,jug)
        elseif cartaRecibir == 2 then
            jugadores[jugadorActual].cartas2 = jugadores[jugadorActual].cartas2 + 1
            quitarCartas(cartaRecibir,jug)
            sumarCartas(Dar,jug)
            quitarCartas(Dar,jugadorActual)
        elseif cartaRecibir == 3 then
            jugadores[jugadorActual].cartas3 = jugadores[jugadorActual].cartas3 + 1
            quitarCartas(cartaRecibir,jug)
            sumarCartas(Dar,jug)
            quitarCartas(Dar,jugadorActual)
        elseif cartaRecibir == 4 then
            jugadores[jugadorActual].cartas4 = jugadores[jugadorActual].cartas4 + 1
            quitarCartas(cartaRecibir,jug)
            sumarCartas(Dar,jug)
            quitarCartas(Dar,jugadorActual)
        elseif cartaRecibir == 5 then
            jugadores[jugadorActual].cartas5 = jugadores[jugadorActual].cartas5 + 1
            quitarCartas(cartaRecibir,jug)
            quitarCartas(Dar,jugadorActual)
            sumarCartas(Dar,jug)
        end
        
        print("tuputamadrejimbo2")
        actualizarRecursos()
        timer.resume(temporizador)
        background2.isVisible = false
        for i = #usuariosTradeando, 1, -1 do
            local img = table.remove(usuariosTradeando, i)
            if img and img.removeSelf then
                img:removeSelf()
                img = nil
            end
        end
        for i = #btnAceptarT, 1, -1 do
            local img = table.remove(btnAceptarT, i)
            if img and img.removeSelf then
                img:removeSelf()
                img = nil
            end
        end
        tradeoTexto:removeSelf()
        btnRechazar:removeSelf()
        terminar()
        for i in ipairs(verticeClase) do
            if ronda > 1 then
                if verticeClase[i].ocupado == true then
                    verticesC[i].isVisible = true
                end
            else
                verticesC[i].isVisible = true
            end
            
        end
    
        for i in ipairs(aristaClase) do
            if aristaClase[i].ocupado == true then
                aristas[i].isVisible = true
            end
        end
        for i = 1, 6 do
            cantidadesCartas[i].isVisible = true
        end

        do return end
    end
    
    --actualizarRecursos()

    local i = jugadorActual
    if jugadores[i].cartas1 >= 1 then
        arbolUser.fill = { type="image", filename="Imagenes/CartasM/cartas11.png" }
        arbolUser.y = cy - 460
        arbolUser.x = cx - 600
        arbolUser.isVisible = true
    end
    if jugadores[i].cartas2 >=1 then
        trigoUser.fill = { type="image", filename="Imagenes/CartasM/cartas21.png" }
        trigoUser.y = cy - 310
        trigoUser.x = cx - 600
        trigoUser.isVisible = true
    end
    if jugadores[i].cartas3 >= 1 then
        ladrilloUser.fill = { type="image", filename="Imagenes/CartasM/cartas31.png" }
        ladrilloUser.y = cy - 160
        ladrilloUser.x = cx - 600
        ladrilloUser.isVisible = true
    end
    if jugadores[i].cartas4 >= 1 then
        vacaUser.fill = { type="image", filename="Imagenes/CartasM/cartas41.png" }
        vacaUser.y = cy - 10
        vacaUser.x = cx - 600
        vacaUser.isVisible = true
    end

    if jugadores[i].cartas5 >= 1 then
        rocaUser.fill = { type="image", filename="Imagenes/CartasM/cartas51.png" }
        rocaUser.y = cy + 140
        rocaUser.x = cx - 600
        rocaUser.isVisible = true
    end


    arbolUser:addEventListener("tap", function(event) arbolTradeJugador(event, cartaRecibir, Dar, bank) end)
    trigoUser:addEventListener("tap", function(event) trigoTradeJugador(event, cartaRecibir, Dar, bank) end)
    ladrilloUser:addEventListener("tap", function(event) ladrilloTradeJugador(event, cartaRecibir, Dar, bank) end)
    vacaUser:addEventListener("tap", function(event) vacaTradeJugador(event, cartaRecibir, Dar, bank) end)
    rocaUser:addEventListener("tap", function(event) rocaTradeJugador(event,cartaRecibir, Dar, bank) end)
end


--cancelar tradeo
local function cancelar()
    rocaBank.isVisible = false
    trigoBank.isVisible = false
    vacaBank.isVisible = false
    ladrilloBank.isVisible = false
    arbolBank.isVisible = false
    cartasEspeciales.isVisible = false

    especialesUser.isVisible = false
    rocaUser.isVisible = false
    vacaUser.isVisible = false
    trigoUser.isVisible = false
    arbolUser.isVisible = false
    ladrilloUser.isVisible = false
    timer.resume(temporizador);
    tradeo:removeEventListener("tap", cancelar)
    tradeo:addEventListener("tap", elegir)
end

--tradeo de especiales como los del teleton
local function tradearCartaTeleton()
    --jugadores[jugadorActual].cartas6 = jugadores[jugadorActual].cartas6 +1
    rocaBank.isVisible = false
    trigoBank.isVisible = false
    vacaBank.isVisible = false
    ladrilloBank.isVisible = false
    arbolBank.isVisible = false
    --seleccionParaDar(false, 6)
    if jugadores[jugadorActual].cartas2 >= 1 and jugadores[jugadorActual].cartas4 >= 1 and jugadores[jugadorActual].cartas5 >= 1 then
        jugadores[jugadorActual].cartas2 = jugadores[jugadorActual].cartas2 - 1
        jugadores[jugadorActual].cartas4 = jugadores[jugadorActual].cartas4 - 1
        jugadores[jugadorActual].cartas5 = jugadores[jugadorActual].cartas5 - 1
        jugadores[jugadorActual].cartas6 = jugadores[jugadorActual].cartas6 + 1
        local randEspecial = math.random(5);
        especiales[jugadorActual][randEspecial] = especiales[jugadorActual][randEspecial] + 1
        
        actualizarRecursos()
        terminar()
    else
        cancelar()
    end

end

--tradeo de arbol
local function tradearCartaArbol()
    --jugadores[jugadorActual].cartas1 = jugadores[jugadorActual].cartas1 +1
    rocaBank.isVisible = false
    trigoBank.isVisible = false
    vacaBank.isVisible = false
    ladrilloBank.isVisible = false
    cartasEspeciales.isVisible = false
    seleccionParaDar(false, 1)
end

local function tradearCartaArbolJugador()
    --jugadores[jugadorActual].cartas1 = jugadores[jugadorActual].cartas1 +1
    rocaBank.isVisible = false
    trigoBank.isVisible = false
    vacaBank.isVisible = false
    ladrilloBank.isVisible = false
    cartasEspeciales.isVisible = false
    seleccionParaDarJugador(false, 1, 0, 0, arbolBank)
end

--tradeo de ladrillo
local function tradearCartaLadrillo()
    --jugadores[jugadorActual].cartas3 = jugadores[jugadorActual].cartas3 +1
    rocaBank.isVisible = false
    trigoBank.isVisible = false
    vacaBank.isVisible = false
    arbolBank.isVisible = false
    cartasEspeciales.isVisible = false
    seleccionParaDar(false, 3)
end

local function tradearCartaLadrilloJugador()
    --jugadores[jugadorActual].cartas3 = jugadores[jugadorActual].cartas3 +1
    rocaBank.isVisible = false
    trigoBank.isVisible = false
    vacaBank.isVisible = false
    arbolBank.isVisible = false
    cartasEspeciales.isVisible = false
    seleccionParaDarJugador(false, 3, 0, 0, ladrilloBank)
end

-- trade de trigo
local function tradearCartaTrigo()
    --jugadores[jugadorActual].cartas2 = jugadores[jugadorActual].cartas2 +1
    rocaBank.isVisible = false
    vacaBank.isVisible = false
    ladrilloBank.isVisible = false
    arbolBank.isVisible = false
    cartasEspeciales.isVisible = false
    seleccionParaDar(false, 2)
end

local function tradearCartaTrigoJugador()
    --jugadores[jugadorActual].cartas2 = jugadores[jugadorActual].cartas2 +1
    rocaBank.isVisible = false
    vacaBank.isVisible = false
    ladrilloBank.isVisible = false
    arbolBank.isVisible = false
    cartasEspeciales.isVisible = false
    seleccionParaDarJugador(false, 2, 0, 0, trigoBank)
end
--tradeo de vacas
local function tradearCartaVaca()
    --jugadores[jugadorActual].cartas4 = jugadores[jugadorActual].cartas4 +1
    rocaBank.isVisible = false
    trigoBank.isVisible = false
    ladrilloBank.isVisible = false
    arbolBank.isVisible = false
    cartasEspeciales.isVisible = false
    seleccionParaDar(false, 4)
end

local function tradearCartaVacaJugador()
    --jugadores[jugadorActual].cartas4 = jugadores[jugadorActual].cartas4 +1
    rocaBank.isVisible = false
    trigoBank.isVisible = false
    ladrilloBank.isVisible = false
    arbolBank.isVisible = false
    cartasEspeciales.isVisible = false
    seleccionParaDarJugador(false, 4, 0, 0, vacaBank)
end

--tradeo de rocas
local function tradearCartaRoca()
    --jugadores[jugadorActual].cartas5 = jugadores[jugadorActual].cartas5 +1
    trigoBank.isVisible = false
    vacaBank.isVisible = false
    ladrilloBank.isVisible = false
    arbolBank.isVisible = false
    cartasEspeciales.isVisible = false
    seleccionParaDar(false, 5)
end

local function tradearCartaRocaJugador()
    --jugadores[jugadorActual].cartas5 = jugadores[jugadorActual].cartas5 +1
    trigoBank.isVisible = false
    vacaBank.isVisible = false
    ladrilloBank.isVisible = false
    arbolBank.isVisible = false
    cartasEspeciales.isVisible = false
    seleccionParaDarJugador(false, 5, 0, 0, rocaBank)
end

function contadorCartas()
    
    local total = 0
    
    total = total + jugadores[jugadorActual].cartas1
    total = total + jugadores[jugadorActual].cartas2
    total = total + jugadores[jugadorActual].cartas3
    total = total + jugadores[jugadorActual].cartas4
    total = total + jugadores[jugadorActual].cartas5

    return total
end

--Funciones para tradeo
function tradearJugadores()
    timer.pause(temporizador);
    local cartas = contadorCartas()
    
    if cartas < 1 then
         do return end
    end

    --Banco son lde abajo a la derecha
    cartasEspeciales = display.newImageRect(grpPartida,"Imagenes/CartasM/tcartas.png", 100, 140)
    cartasEspeciales.x = display.contentWidth - 650
    cartasEspeciales.y = display.contentHeight- 90

    arbolBank = display.newImageRect(grpPartida,"Imagenes/CartasM/cartas11.png", 100, 140)
    arbolBank.x = display.contentWidth - 540
    arbolBank.y = display.contentHeight - 90

    ladrilloBank = display.newImageRect(grpPartida,"Imagenes/CartasM/cartas31.png", 100, 140)
    ladrilloBank.x = display.contentWidth - 430
    ladrilloBank.y = display.contentHeight- 90

    trigoBank = display.newImageRect(grpPartida,"Imagenes/CartasM/cartas21.png", 100, 140)
    trigoBank.x = display.contentWidth - 320
    trigoBank.y = display.contentHeight- 90

    vacaBank = display.newImageRect(grpPartida,"Imagenes/CartasM/cartas41.png", 100, 140)
    vacaBank.x = display.contentWidth - 210 
    vacaBank.y = display.contentHeight- 90

    rocaBank = display.newImageRect(grpPartida,"Imagenes/CartasM/cartas51.png", 100, 140)
    rocaBank.x = display.contentWidth -100
    rocaBank.y = display.contentHeight - 90

    especialesUser = display.newImageRect(grpPartida,"Imagenes/CartasM/especiales.png", 100, 140)
    rocaUser = display.newImageRect(grpPartida,"Imagenes/CartasM/cartas53.png", 100, 140)
    vacaUser = display.newImageRect(grpPartida,"Imagenes/CartasM/cartas43.png", 100, 140)
    trigoUser = display.newImageRect(grpPartida,"Imagenes/CartasM/cartas23.png", 100, 140)
    arbolUser = display.newImageRect(grpPartida,"Imagenes/CartasM/cartas13.png", 100, 140)
    ladrilloUser = display.newImageRect(grpPartida,"Imagenes/CartasM/cartas33.png", 100, 140)

    --Banco
    cartasEspeciales.isVisible = true
    arbolBank.isVisible = true
    ladrilloBank.isVisible = true
    trigoBank.isVisible = true
    vacaBank.isVisible = true
    rocaBank.isVisible = true

    especialesUser.isVisible = false
    rocaUser.isVisible = false
    vacaUser.isVisible = false
    trigoUser.isVisible = false
    arbolUser.isVisible = false
    ladrilloUser.isVisible = false

    arbolBank:addEventListener("tap", tradearCartaArbolJugador)
    ladrilloBank:addEventListener("tap", tradearCartaLadrilloJugador)
    trigoBank:addEventListener("tap", tradearCartaTrigoJugador)
    vacaBank:addEventListener("tap", tradearCartaVacaJugador)
    rocaBank:addEventListener("tap", tradearCartaRocaJugador)
    tradeo:removeEventListener("tap", elegir)
    tradeo:addEventListener("tap", cancelar)
end







function tradear()
    timer.pause(temporizador);
    local cartas = contadorCartas()
    
    if cartas < 3 then
         do return end
    end

    --Banco son lde abajo a la derecha
    cartasEspeciales = display.newImageRect(grpPartida,"Imagenes/CartasM/tcartas.png", 100, 140)
    cartasEspeciales.x = display.contentWidth - 650
    cartasEspeciales.y = display.contentHeight- 90

    arbolBank = display.newImageRect(grpPartida,"Imagenes/CartasM/cartas11.png", 100, 140)
    arbolBank.x = display.contentWidth - 540
    arbolBank.y = display.contentHeight - 90

    ladrilloBank = display.newImageRect(grpPartida,"Imagenes/CartasM/cartas31.png", 100, 140)
    ladrilloBank.x = display.contentWidth - 430
    ladrilloBank.y = display.contentHeight- 90

    trigoBank = display.newImageRect(grpPartida,"Imagenes/CartasM/cartas21.png", 100, 140)
    trigoBank.x = display.contentWidth - 320
    trigoBank.y = display.contentHeight- 90

    vacaBank = display.newImageRect(grpPartida,"Imagenes/CartasM/cartas41.png", 100, 140)
    vacaBank.x = display.contentWidth - 210 
    vacaBank.y = display.contentHeight- 90

    rocaBank = display.newImageRect(grpPartida,"Imagenes/CartasM/cartas51.png", 100, 140)
    rocaBank.x = display.contentWidth -100
    rocaBank.y = display.contentHeight - 90

    especialesUser = display.newImageRect(grpPartida,"Imagenes/CartasM/especiales.png", 100, 140)
    rocaUser = display.newImageRect(grpPartida,"Imagenes/CartasM/cartas53.png", 100, 140)
    vacaUser = display.newImageRect(grpPartida,"Imagenes/CartasM/cartas43.png", 100, 140)
    trigoUser = display.newImageRect(grpPartida,"Imagenes/CartasM/cartas23.png", 100, 140)
    arbolUser = display.newImageRect(grpPartida,"Imagenes/CartasM/cartas13.png", 100, 140)
    ladrilloUser = display.newImageRect(grpPartida,"Imagenes/CartasM/cartas33.png", 100, 140)

    --Banco
    cartasEspeciales.isVisible = true
    arbolBank.isVisible = true
    ladrilloBank.isVisible = true
    trigoBank.isVisible = true
    vacaBank.isVisible = true
    rocaBank.isVisible = true

    especialesUser.isVisible = false
    rocaUser.isVisible = false
    vacaUser.isVisible = false
    trigoUser.isVisible = false
    arbolUser.isVisible = false
    ladrilloUser.isVisible = false

    cartasEspeciales:addEventListener("tap", tradearCartaTeleton)
    arbolBank:addEventListener("tap", tradearCartaArbol)
    ladrilloBank:addEventListener("tap", tradearCartaLadrillo)
    trigoBank:addEventListener("tap", tradearCartaTrigo)
    vacaBank:addEventListener("tap", tradearCartaVaca)
    rocaBank:addEventListener("tap", tradearCartaRoca)
    tradeo:removeEventListener("tap", tradear)
    tradeo:addEventListener("tap", cancelar)
end

--Eventos de la escena
function scene:create(event)
    --Recibir parámetros
    local params = event.params
    local njugador1 = params.jugador1
    local njugador2 = params.jugador2
    local njugador3 = params.jugador3
    local njugador4 = params.jugador4
    --Agregar grupo de imagenes
    grpPartida = display.newGroup()
    self.view:insert(grpPartida)
    for i = 1, 4 do
        local grpjugador = display.newGroup()
        table.insert(grpJugadores,grpjugador)
    end

    local background = display.newImageRect(grpPartida,"Imagenes/fondoH.png", 2800, 1200 )
    background.x = display.contentCenterX
    background.y = display.contentCenterY

    --Tablero
    local tablero = display.newImageRect(grpPartida, "Imagenes/tablero2.png", 1209, 726)
    tablero.x = display.contentCenterX -100
    tablero.y = display.contentCenterY-70
    
    --Hexagonos
    dibujarHexagonos()

    --Probabilidades
    dibujarNumeros()
    hazLaLuz()
    
    textoRonda.text = "Ronda: 1"
    --Barcos
    local barco = display.newImageRect(grpPartida,"Imagenes/barco1.png", 200, 120)
    barco.x = display.contentCenterX -70
    barco.y = 100
    
    local barco2 = display.newImageRect(grpPartida,"Imagenes/barco2.png", 200, 120)
    barco2.x = display.contentCenterX -350
    barco2.y = 100
    
    local barco3 = display.newImageRect(grpPartida,"Imagenes/barco3.png", 200, 120)
    barco3.x = display.contentCenterX - 490
    barco3.y = display.contentCenterY + 50
    
    local barco4 = display.newImageRect(grpPartida,"Imagenes/barco4.png", 200, 120)
    barco4.x = display.contentCenterX - 490
    barco4.y = display.contentCenterY - 200
    
    local barco5 = display.newImageRect(grpPartida,"Imagenes/barco5.png", 200, 120)
    barco5.x = display.contentCenterX + 220
    barco5.y = display.contentCenterY - 310
    
    local barco6 = display.newImageRect(grpPartida,"Imagenes/barco6.png", 200, 120)
    barco6.x = display.contentCenterX + 200
    barco6.y = display.contentCenterY + 150
    
    local barco7 = display.newImageRect(grpPartida,"Imagenes/barco6.png", 200, 120)
    barco7.x = display.contentCenterX - 50
    barco7.y = display.contentCenterY + 300
    
    --Jugadores
    local usuario3 = display.newImageRect(grpPartida,"Imagenes/CartasM/usuario1.png", 142.5, 195)
    usuario3.x = display.contentWidth - 350 
    usuario3.y = display.contentHeight - 750
    
    local usuario4 = display.newImageRect(grpPartida,"Imagenes/CartasM/usuario2.png", 142.5, 195)
    usuario4.x = display.contentWidth - 150
    usuario4.y = display.contentHeight - 750

    local usuario1 = display.newImageRect(grpPartida,"Imagenes/CartasM/usuario4.png", 142.5, 195)
    usuario1.x = display.contentWidth-350 
    usuario1.y = display.contentHeight-1000

    local usuario2 = display.newImageRect(grpPartida,"Imagenes/CartasM/usuario3.png", 142.5, 195)
    usuario2.x = display.contentWidth-150
    usuario2.y = display.contentHeight-1000

    --Marcos
    local cuadro1 = display.newImageRect(grpPartida,"Imagenes/configuracion/cuadrado.png", 230, 240)
    cuadro1.x = display.contentWidth-350 
    cuadro1.y = display.contentHeight-1000
    cuadrosJugando[1] = cuadro1

    local cuadro2 = display.newImageRect(grpPartida,"Imagenes/configuracion/cuadrado.png", 230, 240)
    cuadro2.x = display.contentWidth-150
    cuadro2.y = display.contentHeight-1000
    cuadro2.isVisible = false
    cuadrosJugando[2] = cuadro2

    local cuadro3 = display.newImageRect(grpPartida,"Imagenes/configuracion/cuadrado.png", 230, 240)
    cuadro3.x = display.contentWidth - 350 
    cuadro3.y = display.contentHeight - 750
    cuadro3.isVisible = false
    cuadrosJugando[3] = cuadro3

    local cuadro4 = display.newImageRect(grpPartida,"Imagenes/configuracion/cuadrado.png", 230, 240)
    cuadro4.x = display.contentWidth - 150
    cuadro4.y = display.contentHeight - 750
    cuadro4.isVisible = false
    cuadrosJugando[4] = cuadro4


    --Alta de jugadores
    jugadores[1] = Jugador:nuevo(njugador2) --Verde
    --jugando.text = njugador1
    jugadores[1].numero = 1
    usuario1_text = display.newText(grpPartida,jugadores[1].nombre, display.contentWidth -150, display.contentHeight-920, native.systemFont, 50 )
    usuario1_text:setFillColor(0,0,0);
    textoPuntos[2] = display.newText(grpPartida,"0", display.contentWidth - 150, display.contentHeight-1080, native.systemFont, 30 )
    textoCartasT[2] = display.newText(grpPartida,"0", display.contentWidth - 70, display.contentHeight-1000, native.systemFont, 30 )
    textoCartasT[2]:setFillColor(0,0,0);
    textoPuntos[2]:setFillColor(0,0,0);

    --table.insert(jugadores,jugador1)


    jugadores[2] = Jugador:nuevo(njugador1)
    jugadores[2].numero = 2
    usuario2_text = display.newText(grpPartida,jugadores[2].nombre, display.contentWidth - 350 , display.contentHeight-920, native.systemFont, 50 )
    usuario2_text:setFillColor(0,0,0);
    textoPuntos[1] = display.newText(grpPartida,"0", display.contentWidth -350 , display.contentHeight-1080, native.systemFont, 30 )
    textoCartasT[1] = display.newText(grpPartida,"0", display.contentWidth - 270, display.contentHeight-1000, native.systemFont, 30 )
    textoCartasT[1]:setFillColor(0,0,0);
    textoPuntos[1]:setFillColor(0,0,0);
    --table.insert(jugadores,jugador2)
    

    jugadores[3] = Jugador:nuevo(njugador3)
    jugadores[3].numero = 3
    usuario3_text = display.newText(grpPartida,jugadores[3].nombre, display.contentWidth - 350, display.contentHeight-675, native.systemFont, 50 )
    usuario3_text:setFillColor(0,0,0);
    textoPuntos[3] = display.newText(grpPartida,"0", display.contentWidth - 350, display.contentHeight-830, native.systemFont, 30 )
    textoCartasT[3] = display.newText(grpPartida,"0", display.contentWidth - 270, display.contentHeight-750, native.systemFont, 30 )
    textoCartasT[3]:setFillColor(0,0,0);
    textoPuntos[3]:setFillColor(0,0,0);

    jugadores[4] = Jugador:nuevo(njugador4)
    jugadores[4].numero = 4
    usuario4_text = display.newText(grpPartida,jugadores[4].nombre, display.contentWidth -150, display.contentHeight-675, native.systemFont, 50 )
    usuario4_text:setFillColor(0,0,0);
    textoPuntos[4] = display.newText(grpPartida,"0", display.contentWidth - 150, display.contentHeight-830, native.systemFont, 30 )
    textoCartasT[4] = display.newText(grpPartida,"0", display.contentWidth - 70, display.contentHeight-750, native.systemFont, 30 )
    textoCartasT[4]:setFillColor(0,0,0);
    textoPuntos[4]:setFillColor(0,0,0);
    
    colocarCartas()
    colocarCartasEspeciales()
    colocarTextoEspeciales()
    colocarCartasRobarTodo()
    grpPartida:insert(grpJugadores[jugadores[1].numero])
    grpPartida:insert(grpJugadores[jugadores[2].numero])
    grpJugadores[2].isVisible = false
    grpPartida:insert(grpJugadores[jugadores[3].numero])
    grpJugadores[3].isVisible = false
    grpPartida:insert(grpJugadores[jugadores[4].numero])
    grpJugadores[4].isVisible = false
    --jugadores[1].cartas1 = 2
    --jugadores[2].cartas1 = 3
    --jugadores[3].cartas3 = 1
    --jugadores[4].cartas5 = 2

    --Dados
    dado1 = display.newImageRect(grpPartida,"Imagenes/dado1.png", 200, 200)
    dado1.x = display.contentWidth -350
    dado1.y = display.contentHeight- 300

    dado2 = display.newImageRect(grpPartida,"Imagenes/dado2.png", 200, 200)
    dado2.x = display.contentWidth- 150
    dado2.y = display.contentHeight- 300

    --Avanzar
    boton = display.newImageRect(grpPartida,"Imagenes/avanzar.png", 100, 100)
    boton.x =  display.contentWidth -100
    boton.y = display.contentHeight-500

    --Objetos
    local casas = display.newImageRect(grpPartida,"Imagenes/Construccion/casa.png", 105, 140)
    casas.x = display.contentCenterX-160
    casas.y = display.contentHeight-100

    local ciudades = display.newImageRect(grpPartida,"Imagenes/Construccion/ciudad.png", 105, 140)
    ciudades.x = display.contentCenterX - 30
    ciudades.y = display.contentHeight-100

    local camino = display.newImageRect(grpPartida,"Imagenes/Construccion/camino.png", 105, 140)
    camino.x = display.contentCenterX +110
    camino.y = display.contentHeight- 100
    
    tradeo = display.newImageRect(grpPartida,"Imagenes/Construccion/tradeo.png", 300, 100)
    tradeo.x = display.contentCenterX-400
    tradeo.y = display.contentHeight-100

    background2 = display.newImageRect(grpPartida,"Imagenes/fondoH.png", 2800, 1200 )
    background2.x = display.contentCenterX
    background2.y = display.contentCenterY
    background2:toFront()

    pasar = display.newImageRect(grpPartida,"Imagenes/pasar.png", 512, 512 )
    pasar.x = display.contentCenterX
    pasar.y = display.contentCenterY
    pasar:toFront()

    seguir = display.newText("Pasa al siguiente jugador", display.contentCenterX , display.contentCenterY+400, native.systemFont, 70)
    seguir:toFront()

    background2.isVisible = false
    pasar.isVisible = false
    seguir.isVisible = false
    aparecerBotonesDeTradeo()
    dibujarArista()
    COMOQUIERAS2()
    
    camino:addEventListener("tap",reactivarCaminos)
    pasar:addEventListener("tap", pasarTurno)
    
    casas:addEventListener("tap", colocarCasas)
    ciudades:addEventListener("tap", cambiarCiudad)
    --tradeo:addEventListener("tap", tradear)
    
    cartasjugador[1][6]:addEventListener("tap",tarjetasEspeciales)
    cartasjugador[2][6]:addEventListener("tap",tarjetasEspeciales)
    cartasjugador[3][6]:addEventListener("tap",tarjetasEspeciales)
    cartasjugador[4][6]:addEventListener("tap",tarjetasEspeciales)
    
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
    --if(event.phase == "will") then
    --elseif (event.phase == "did") then
    --end
    print("destroy")
    if grpPartida then
        grpPartida:removeSelf()
        grpPartida = nil
    end
end

scene:addEventListener("create", scene)
scene:addEventListener("show", scene)
scene:addEventListener("hide", scene)
scene:addEventListener("destroy", scene)

return scene