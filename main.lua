require("affichage")
require("gameplay")

--screenWidth = love.graphics.getWidth()
--screenHeight = love.graphics.getHeight()

limiteGauche = -200
limiteDroite = love.graphics.getWidth() - limiteGauche

positionRaquetteDebut_X = 75
positionRaquetteDebut_Y = love.graphics.getHeight()/2
positionBalleDebut_X = 102
positionBalleDebut_Y = love.graphics.getHeight()/2

premierService = 1

listeBalle = {}
VITESSE_BASEX = 4
VITESSE_BASEY = 4

listeRaquette = {}

listeBonus= {}
nbBonus = 3
tailleBonus = 32
TimerBonus = 0
TimerActivation = 0

listePiege= {}

nRaquette = 0

-- Règles du jeu
nbBalle = 3

--Ajoute une balle dans la liste des balles. Chaîne de caractère en paramètre.
function AjouterBalle(balleName)
  --Création d'un balle et modification de son origine image
  Balle = {}
  Balle.name = balleName
  Balle.image = love.graphics.newImage("images/"..balleName..".png")
  Balle.x = positionBalleDebut_X
  Balle.y = positionBalleDebut_Y
  Balle.vitesseX = VITESSE_BASEX
  Balle.vitesseY = VITESSE_BASEY
  Balle.orientationX = 1
  Balle.orientationY = 1
  Balle.Ox = Balle.image:getWidth()/2
  Balle.Oy = Balle.image:getHeight()/2
  --Ajout de la balle dans une liste
  table.insert(listeBalle, Balle)
end

--Ajoute une raquette dans la liste des raquettes. Chaîne de caractère en paramètre.
function AjouterRaquette(raquetteName, player)
  --Création d'une raquette et modification de son origine image
  Raquette = {}
  Raquette.name = raquetteName
  Raquette.image = love.graphics.newImage("images/"..raquetteName..".png")
  Raquette.x = positionRaquetteDebut_X
  Raquette.y = positionRaquetteDebut_Y
  Raquette.Ox = Raquette.image:getWidth()/2
  Raquette.Oy = Raquette.image:getHeight()/2
  if player == 1  then
    Raquette.x = positionRaquetteDebut_X
    Raquette.y = positionRaquetteDebut_Y
  elseif player == 2 then
    Raquette.x = screenWidth - positionRaquetteDebut_X
    Raquette.y = screenHeight/2
  end
  --Ajout de la raquette dans une liste
  nRaquette = nRaquette + 1
  listeRaquette["Raquette"..nRaquette] = Raquette
end

function AjouterBonus (indexBonus)
  math.randomseed(os.time())
  if indexBonus >= 1 and indexBonus <= nbBonus then
    Bonus = {}
    Bonus.x = screenWidth/2 - tailleBonus/2
    Bonus.y = math.random(0, screenHeight - tailleBonus)
    Bonus.vitesse = 3
    Bonus.type = indexBonus
    table.insert(listeBonus, indexBonus, Bonus)
    TimerBonus = math.random(5,10)
    TimerActivation = 1
  else 
    print("Le bonus n'existe pas!")
  end
end

function AjouterPiege()
  local VitessePiege = 1
  Piege1 = {}
  math.randomseed(os.time())
  Piege1.taillePiegeX = 20
  Piege1.taillePiegeY = math.random(100,200)
  Piege1.positionPiegeX = screenWidth/2 - Piege1.taillePiegeX
  Piege1.positionPiegeY = math.random(0, screenHeight/2 - Piege1.taillePiegeY)
  Piege1.vitesse = VitessePiege

  Piege2 = {}
  Piege2.taillePiegeX = 20
  Piege2.taillePiegeY = math.random(100,200)
  Piege2.positionPiegeX = screenWidth/2 - Piege2.taillePiegeX
  Piege2.positionPiegeY = math.random(screenHeight/2, screenHeight - Piege2.taillePiegeY)
  Piege2.vitesse = VitessePiege

  for _,b in pairs(listeBalle) do
    if (b.x > 0 and b.x < Piege1.positionPiegeX - 100) or (b.x > Piege1.positionPiegeX + 100 and b.x < screenWidth) then
      table.insert(listePiege, 1, Piege1)
      table.insert(listePiege, 2, Piege2)
      PIEGE_ACTIVE = true
    end
  end
end

function love.load(dt)
  screenWidth = love.graphics.getWidth()
  screenHeight = love.graphics.getHeight()

  pointJoueur1 = 0
  pointJoueur2 = 0
  
  intervalleDetectionGaucheDroite = 5
  intervalleDetectionHautBas = 10

  premierService = 1
  math.randomseed(os.time())
  premierService = math.random(1,2) 

  START = false
  PERDUE_POINT = false
  JOUEUR_PERD = false
  RESTART = false
  SERVICE = false
  CollisionHaut = false
  CollisionBas = false
  CollisionRaquetteGauche = false
  CollisionRaquetteDroite = false
  CollisionRaquetteHaut = false
  CollisionRaquetteBas = false
  BONUS_EN_JEU = false
  BONUS_ACTIVATION = false
  RECORD_BATTU = false
  POSITION_RAQUETTE_OK = false
  PIEGE_ACTIVE = false
  CIBLE_RAQUETTE_GAUCHE = false
  CIBLE_RAQUETTE_DROITE = false

  Chrono = 0

  nouveauRecord = 0
  record = 0

  timer = 0
  rotationBalle = 0
  
  AjouterBalle("Balle1")
  AjouterRaquette("Raquette1",1)
  AjouterRaquette("Raquette1",2)
  
  
  PlacementBalle(1)

  angleBalle = 0

  math.randomseed(os.time())
  TimerBonus = math.random(5,10)
  
end

function love.update(dt)

  angleBalle = CalculAngleBalle(1,"Raquette1", "Raquette2")
  
  Service(1,"Raquette1", "Raquette2")

  if JOUEUR_PERD == false then
    DeplacerRaquette("Raquette1", "Raquette2")
    DeplacerBalle(1, "Raquette1", "Raquette2")
    RotationBalle()
  end

  GestionCollision(1, "Raquette1", "Raquette2")

  Perdre(1)

  BonusManagement(dt)
  CollisionBalleBonus()
  ActiverBonus(1,dt)

  if START == true then
    Chrono = Chrono + dt
  elseif START == false then
    Chrono = 0
  end

  if PIEGE_ACTIVE == true then
    DeplacerPiege()
    CollisionPiegeBalle()
  end

end

function love.keypressed(key)
  
  if key == "space" and START == false and JOUEUR_PERD == false and Service(1,"Raquette1", "Raquette2") == true then
    DeplacerBalleDepart(1)
    START = true
  end

  if key == "space" and JOUEUR_PERD == true then
    JOUEUR_PERD = false
    RECORD_BATTU = false
  end
  
end

function love.draw()
  
  AffichageDynamique()
  AfficherBalle("Balle1")
  AfficherRaquette("Raquette1")
  AfficherRaquette("Raquette1")
  AfficherBonus()

  if PIEGE_ACTIVE == true then
    AfficherPiege(indexBonusActivation)
  end
end