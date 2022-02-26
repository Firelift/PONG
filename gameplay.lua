function PlacementBalle(indexBalle)
 
  Balle = listeBalle[indexBalle]
  if START == false and PERDUE_POINT == false then
    if premierService == 1 then
      Balle.x = positionBalleDebut_X
      Balle.y = positionBalleDebut_Y
    elseif premierService == 2 then
      Balle.x = love.graphics.getWidth() - positionBalleDebut_X 
      Balle.y = positionBalleDebut_Y
    end 
  else 
    if Balle.x < limiteGauche  then
      Balle.x = positionBalleDebut_X
      Balle.y = positionBalleDebut_Y
    elseif Balle.x > limiteDroite  then
      Balle.x = love.graphics.getWidth() - positionBalleDebut_X
      Balle.y = positionBalleDebut_Y
    end
  
  end 

end

function DeplacerBalleDepart(indexBalle)
  
  Balle = listeBalle[indexBalle]
  Raquette1 = listeRaquette[nameRaq1]
  Raquette2 = listeRaquette[nameRaq2]
 
  if PERDUE_POINT == true then
    Balle.orientationX = Balle.orientationX*-1
  else
    if premierService == 1 then
      Balle.orientationX = 1
    elseif premierService == 2 then
      Balle.orientationX = -1
    end
  end

  if angleBalle < 0.1 and angleBalle > -0.1 then
    math.randomseed(os.time())
    local orientation = math.random(1,2)
    angleBalle = math.random(-80,80)/100
    if orientation == 1 then
      Balle.orientationY = -Balle.orientationY
    end
  end
end

function DeplacerBalle(indexBalle, nameRaq1, nameRaq2)
  Balle = listeBalle[indexBalle]
  Raquette1 = listeRaquette[nameRaq1]
  Raquette2 = listeRaquette[nameRaq2]
  

  if START == true then
    if CollisionHaut == true or CollisionBas == true then
      Balle.orientationY = Balle.orientationY*-1
      CollisionHaut = false
      CollisionBas = false
    end
    if CollisionRaquetteGauche == true or CollisionRaquetteDroite == true then
      Balle.orientationX = Balle.orientationX*-1
      CollisionRaquetteGauche = false
      CollisionRaquetteDroite = false
    end
    if (CollisionRaquetteBas == true and Balle.orientationY == -1) or (CollisionRaquetteHaut == true and Balle.orientationY == 1) then
      Balle.orientationY = Balle.orientationY*-1  
      CollisionRaquetteBas = false
      CollisionRaquetteHaut = false
    end

    Balle.x = Balle.x + Balle.vitesseX*Balle.orientationX*math.abs(math.cos(angleBalle))
    Balle.y = Balle.y  + Balle.vitesseY*Balle.orientationY*math.abs(math.sin(angleBalle))
    
  end

end

function RotationBalle()
  timer = timer + 1
  if START == true and timer > 5 then
    rotationBalle = rotationBalle + 0.1
    timer = 0
  end
end

function DeplacerRaquette(Raq1, Raq2)
  local vitesse = 4
  Raquette1 = listeRaquette[Raq1]
  Raquette2 = listeRaquette[Raq2]
  local RaquetteService = nil
  local RaquetteRetourService = nil
  if premierService == 1 then
    RaquetteService = Raquette1
    RaquetteRetourService = Raquette2
  elseif premierService == 2 then
    RaquetteService = Raquette2
    RaquetteRetourService = Raquette1
  end
  if premierService == 1 then
    if START == false then     
      if  RaquetteService.y >= positionBalleDebut_Y - RaquetteService.image:getHeight()/2 - 5 and RaquetteService.y <= positionBalleDebut_Y + RaquetteService.image:getHeight()/2 + 5 then
        POSITION_RAQUETTE_OK = true
      else
        POSITION_RAQUETTE_OK = false
      end
      if POSITION_RAQUETTE_OK == true then
        if love.keyboard.isDown("z") and RaquetteService.y > positionBalleDebut_Y - RaquetteService.image:getHeight()/2   then
          RaquetteService.y = RaquetteService.y - vitesse
        elseif love.keyboard.isDown("s") and RaquetteService.y < positionBalleDebut_Y + RaquetteService.image:getHeight()/2    then
          RaquetteService.y = RaquetteService.y + vitesse  
        end 
      else
        if love.keyboard.isDown("z") and RaquetteService.y > RaquetteService.image:getHeight()/2 then
          RaquetteService.y = RaquetteService.y - vitesse
        elseif love.keyboard.isDown("s") and RaquetteService.y < screenHeight - RaquetteService.image:getHeight()/2  then
          RaquetteService.y = RaquetteService.y + vitesse  
        end 
      end 
      if love.keyboard.isDown("up") and RaquetteRetourService.y > RaquetteRetourService.image:getHeight()/2 then
        RaquetteRetourService.y = RaquetteRetourService.y - vitesse
      elseif love.keyboard.isDown("down") and RaquetteRetourService.y < screenHeight - RaquetteRetourService.image:getHeight()/2  then
        RaquetteRetourService.y = RaquetteRetourService.y + vitesse  
      end 
    else
      if love.keyboard.isDown("z") and RaquetteService.y > RaquetteService.image:getHeight()/2 then
        RaquetteService.y = RaquetteService.y - vitesse
      elseif love.keyboard.isDown("s") and RaquetteService.y < screenHeight - RaquetteService.image:getHeight()/2  then
        RaquetteService.y = RaquetteService.y + vitesse  
      end 
      if love.keyboard.isDown("up") and RaquetteRetourService.y > RaquetteRetourService.image:getHeight()/2 then
        RaquetteRetourService.y = RaquetteRetourService.y - vitesse
      elseif love.keyboard.isDown("down") and RaquetteRetourService.y < screenHeight - RaquetteRetourService.image:getHeight()/2  then
        RaquetteRetourService.y = RaquetteRetourService.y + vitesse  
      end 
    end
  elseif premierService == 2 then
    if START == false then     
      if  RaquetteService.y >= positionBalleDebut_Y - RaquetteService.image:getHeight()/2 - 5 and RaquetteService.y <= positionBalleDebut_Y + RaquetteService.image:getHeight()/2 + 5 then
        POSITION_RAQUETTE_OK = true
      else
        POSITION_RAQUETTE_OK = false
      end
      if POSITION_RAQUETTE_OK == true then
        if love.keyboard.isDown("up") and RaquetteService.y > positionBalleDebut_Y - RaquetteService.image:getHeight()/2   then
          RaquetteService.y = RaquetteService.y - vitesse
        elseif love.keyboard.isDown("down") and RaquetteService.y < positionBalleDebut_Y + RaquetteService.image:getHeight()/2    then
          RaquetteService.y = RaquetteService.y + vitesse  
        end 
      else
        if love.keyboard.isDown("up") and RaquetteService.y > RaquetteService.image:getHeight()/2 then
          RaquetteService.y = RaquetteService.y - vitesse
        elseif love.keyboard.isDown("down") and RaquetteService.y < screenHeight - RaquetteService.image:getHeight()/2  then
          RaquetteService.y = RaquetteService.y + vitesse  
        end 
      end 
      if love.keyboard.isDown("z") and RaquetteRetourService.y > RaquetteRetourService.image:getHeight()/2 then
        RaquetteRetourService.y = RaquetteRetourService.y - vitesse
      elseif love.keyboard.isDown("s") and RaquetteRetourService.y < screenHeight - RaquetteRetourService.image:getHeight()/2  then
        RaquetteRetourService.y = RaquetteRetourService.y + vitesse  
      end 
    else
      if love.keyboard.isDown("up") and RaquetteService.y > RaquetteService.image:getHeight()/2 then
        RaquetteService.y = RaquetteService.y - vitesse
      elseif love.keyboard.isDown("down") and RaquetteService.y < screenHeight - RaquetteService.image:getHeight()/2  then
        RaquetteService.y = RaquetteService.y + vitesse  
      end 
      if love.keyboard.isDown("z") and RaquetteRetourService.y > RaquetteRetourService.image:getHeight()/2 then
        RaquetteRetourService.y = RaquetteRetourService.y - vitesse
      elseif love.keyboard.isDown("s") and RaquetteRetourService.y < screenHeight - RaquetteRetourService.image:getHeight()/2  then
        RaquetteRetourService.y = RaquetteRetourService.y + vitesse  
      end 
    end
  end
end

function GestionCollision(indexBalle , nameRaquette1, nameRaquette2)
  Balle = listeBalle[indexBalle]
  Raquette1 = listeRaquette[nameRaquette1]
  Raquette2 = listeRaquette[nameRaquette2]
 
  if Balle.y < Balle.image:getHeight()/2  then
    CollisionHaut = true
    Balle.y = Balle.image:getHeight()/2 
  elseif Balle.y > screenHeight - Balle.image:getHeight()/2  then
    CollisionBas = true
    Balle.y = screenHeight - Balle.image:getHeight()/2 
  end
  if START == true then
    if Balle.x > Raquette1.x + Raquette1.image:getWidth()/2 + Balle.image:getWidth()/2 - 50 and Balle.x < Raquette1.x + Raquette1.image:getWidth()/2 + Balle.image:getWidth()/2 then
      if Balle.y > Raquette1.y - Raquette1.image:getHeight()/2 - 10 and Balle.y < Raquette1.y + Raquette1.image:getHeight()/2 + 10 then
        CollisionRaquetteGauche = true
        CIBLE_RAQUETTE_GAUCHE = false
        Balle.x =  Raquette1.x + Raquette1.image:getWidth()/2 + Balle.image:getWidth()/2
        local balleY = Balle.y
        Balle.y = balleY
      end

    elseif Balle.x > Raquette2.x - Raquette2.image:getWidth()/2 - Balle.image:getWidth()/2 and Balle.x < Raquette2.x - Raquette2.image:getWidth()/2 - Balle.image:getWidth()/2 + 50   then
      if Balle.y > Raquette2.y - Raquette2.image:getHeight()/2 -10 and Balle.y < Raquette2.y + Raquette2.image:getHeight()/2 +10  then
        CollisionRaquetteDroite = true
        CIBLE_RAQUETTE_DROITE = false
        Balle.x = Raquette2.x - Raquette2.image:getWidth() - Balle.image:getWidth()/2
        local balleY = Balle.y
        Balle.y = balleY
      end
    end
    
    if CollisionRaquetteGauche == false and CollisionRaquetteDroite == false then
      if (Balle.x < Raquette1.x and Balle.x > Raquette1.x - Raquette1.image:getWidth()/2 -20 ) then
        if (Balle.y < Raquette1.y + Raquette1.image:getHeight()/2 + Balle.image:getHeight()/2 and Balle.y > Raquette1.y + Raquette1.image:getHeight()/2 + Balle.image:getHeight()/2 - intervalleDetectionHautBas) then
          CollisionRaquetteBas = true
     
        elseif (Balle.y > Raquette1.y - Raquette1.image:getHeight()/2 - Balle.image:getHeight()/2 and Balle.y < Raquette1.y - Raquette1.image:getHeight()/2 - Balle.image:getHeight()/2 + intervalleDetectionHautBas) then
          CollisionRaquetteHaut = true 
       
        end 
      end
      if (Balle.x < Raquette2.x + Raquette2.image:getWidth()/2 + 20 and Balle.x > Raquette2.x) then
        if (Balle.y < Raquette2.y + Raquette2.image:getHeight()/2 + Balle.image:getHeight()/2 and Balle.y > Raquette2.y + Raquette2.image:getHeight()/2 + Balle.image:getHeight()/2 - intervalleDetectionHautBas) then
          CollisionRaquetteBas = true
         
        elseif (Balle.y > Raquette2.y - Raquette2.image:getHeight()/2 - Balle.image:getHeight()/2 and Balle.y < Raquette2.y - Raquette2.image:getHeight()/2 - Balle.image:getHeight()/2 + intervalleDetectionHautBas) then
          CollisionRaquetteHaut = true 
           
        end 
      end
    end
  end
end

function Perdre(indexBalle)
  Balle = listeBalle[indexBalle]

  if Balle.x < limiteGauche then
    for i = nbBonus, 1, -1 do
      listeBonus[i] = nil
    end
    BONUS_EN_JEU = false
    PERDUE_POINT = true
    START = false
    premierService = 1
    PlacementBalle(indexBalle)
    BONUS_EN_JEU = false
    nbBalle = nbBalle - 1
    if nouveauRecord <= Chrono then
      nouveauRecord = math.floor(Chrono)
    end
  elseif Balle.x > limiteDroite then
    for i = nbBonus, 1, -1 do
      listeBonus[i] = nil
    end
    BONUS_EN_JEU = false
    PERDUE_POINT = true
    START = false
    premierService = 2
    PlacementBalle(indexBalle)
    BONUS_EN_JEU = false
    nbBalle = nbBalle - 1
    if nouveauRecord <= Chrono then
      nouveauRecord = math.floor(Chrono)
    end
  end

  if nbBalle == 0  then
    JOUEUR_PERD = true
    nbBalle = 3
  end
  
  if nouveauRecord > record then
    record = nouveauRecord
    RECORD_BATTU = true
  end

  
end

function Service(indexBalle, nameRaq1, nameRaq2)
  Balle = listeBalle[indexBalle]
  Raquette1 = listeRaquette[nameRaq1]
  Raquette2 = listeRaquette[nameRaq2]

  if premierService == 1 then
    if Raquette1.y > Balle.y - Raquette1.image:getHeight()/2 - 5 and Raquette1.y <= Balle.y + Raquette1.image:getHeight()/2 + 5  then
     return true
    else
     return false
    end
  elseif premierService == 2 then
    if Raquette2.y > Balle.y - Raquette2.image:getHeight()/2 - 5  and Raquette2.y < Balle.y + Raquette2.image:getHeight()/2 + 5 then
      return true
     else
      return false
    end
  end
end

function CalculAngleBalle (indexBal, nameRaq1, nameRaq2)
  Balle = listeBalle[indexBal]
  Raquette1 = listeRaquette[nameRaq1]
  Raquette2 = listeRaquette[nameRaq2]
  local distanceCentreRaquette
  local angleBalleMax = math.pi/3
  local multiplicateur = 3

  if (CollisionRaquetteGauche == true or (premierService == 1 and START == false))  then
    distanceCentreRaquette = Balle.y - Raquette1.y
    local coefficient = distanceCentreRaquette/Raquette1.image:getHeight()/2
    angleBalle = coefficient*angleBalleMax*multiplicateur
    if angleBalle < 0 then
      Balle.orientationY = -1
    else
      Balle.orientationY = 1
    end
  
  elseif (CollisionRaquetteDroite == true or (premierService == 2 and START == false))  then
    distanceCentreRaquette = Balle.y - Raquette2.y
    local coefficient = distanceCentreRaquette/Raquette2.image:getHeight()/2
    angleBalle = coefficient*angleBalleMax*multiplicateur
    if angleBalle < 0 then
      Balle.orientationY = -1
    else
      Balle.orientationY = 1
    end
  end
  return angleBalle
end 

-- Implémentation des bonus
function BonusManagement(dt)
  if BONUS_EN_JEU == false then
    if START == true and PIEGE_ACTIVE == false then
      TimerBonus = TimerBonus - dt
      if TimerBonus <= 0 then
        math.randomseed(os.time())
        indexBonus = math.random(1,nbBonus)
        sensDeplacement = math.random(1,2)
        if sensDeplacement == 1 then
          orientation = -1
        else 
          orientation = 1
        end
        AjouterBonus(indexBonus)
        BONUS_EN_JEU = true
      end
    else 
      table.remove(listeBonus, indexBonus)
    end
  end
  if BONUS_EN_JEU == true  then
  DeplacerBonus(indexBonus)
  end
end

function DeplacerBonus(indexBonus) 
  if listeBonus[indexBonus].y < 0 or listeBonus[indexBonus].y > screenHeight - tailleBonus then
      orientation = -orientation 
  end 
  listeBonus[indexBonus].y = listeBonus[indexBonus].y + listeBonus[indexBonus].vitesse*orientation
end

function DeplacerPiege()
  
end

function CollisionBalleBonus()
  if BONUS_EN_JEU == true then
    for n = #listeBalle, 1, -1 do
      if listeBalle[n].x > listeBonus[indexBonus].x - listeBalle[n].image:getWidth()/2 and listeBalle[n].x < listeBonus[indexBonus].x + tailleBonus + listeBalle[n].image:getWidth()/2 then
        if listeBalle[n].y > listeBonus[indexBonus].y - listeBalle[n].image:getHeight()/2 - 2 and listeBalle[n].y < listeBonus[indexBonus].y + tailleBonus + listeBalle[n].image:getHeight()/2 + 2 then
          for i = nbBonus, 1, -1 do
            listeBonus[i] = nil
          end   
          indexBonusActivation = indexBonus
          indexBalle = n
          BONUS_EN_JEU = false
          BONUS_ACTIVATION = true
          if listeBalle[n].orientationX == 1 then
            CIBLE_RAQUETTE_GAUCHE = true
          elseif listeBalle[n].orientationX == -1 then
            CIBLE_RAQUETTE_DROITE = true
          end
        end
      end
    end
  end
end

function ActiverBonus(nBalle, dt) 
  local balle = listeBalle[nBalle]
  if BONUS_ACTIVATION == true then
    if indexBonusActivation == 1 then
      local boostVitesse = 3 
      TimerActivation = TimerActivation - dt
      if TimerActivation < 0 then
        listeBalle[indexBalle].vitesseX = VITESSE_BASEX 
        listeBalle[indexBalle].vitesseY = VITESSE_BASEY 
        BONUS_ACTIVATION = false
      else
        listeBalle[indexBalle].vitesseX = VITESSE_BASEX + boostVitesse
        listeBalle[indexBalle].vitesseY = VITESSE_BASEY + boostVitesse
      end
    elseif indexBonusActivation == 2 then
      math.randomseed(os.time())
      local orientation = math.random(1,2)
      local minAngle = 20
      local maxAngle = 80
      if orientation == 1 then
        math.randomseed(os.time())
        angleBalle = math.random(minAngle,maxAngle)/100
      else
        math.randomseed(os.time())
        angleBalle = math.random(minAngle,maxAngle)/100
        balle.orientationY = - balle.orientationY
      end
      BONUS_ACTIVATION = false
    elseif indexBonusActivation == 3 then
      if PIEGE_ACTIVE == false then
        AjouterPiege()
        math.randomseed(os.time())
        local sensPiege = math.random(1,4)
        if sensPiege == 1 then
          orientationPiege1 = 1
          orientationPiege2 = 1
        elseif sensPiege == 2 then
          orientationPiege1 = -1
          orientationPiege2 = 1
        elseif sensPiege == 3 then
          orientationPiege1 = 1
          orientationPiege2 = -1
        elseif sensPiege == 4 then
          orientationPiege1 = -1
          orientationPiege2 = -1
        end       
      end
      if PIEGE_ACTIVE == true then
        if (CIBLE_RAQUETTE_GAUCHE == false and CIBLE_RAQUETTE_DROITE == false) or START == false then
          PIEGE_ACTIVE = false
          BONUS_ACTIVATION = false
          for n,p in pairs(listePiege) do
            listePiege[n] = nil
          end
        end
      end  
    end
  end
end

function DeplacerPiege()
  for _,p in pairs(listePiege) do
    if p.positionPiegeY < screenHeight/2 then
      if p.positionPiegeY > 0 and p.positionPiegeY < screenHeight/2 - p.taillePiegeY  then
        p.positionPiegeY = p.positionPiegeY + p.vitesse*orientationPiege1
      else 
        orientationPiege1 = -orientationPiege1
        p.positionPiegeY = p.positionPiegeY + p.vitesse*orientationPiege1
      end
    else
      if p.positionPiegeY > screenHeight/2  and p.positionPiegeY < screenHeight - p.taillePiegeY  then
        p.positionPiegeY = p.positionPiegeY + p.vitesse*orientationPiege2
      else
        orientationPiege2 = -orientationPiege2
        p.positionPiegeY = p.positionPiegeY + p.vitesse*orientationPiege2
      end
    end  
  end 
end

function CollisionPiegeBalle()
  for _,b in pairs(listeBalle) do
    for _,p in pairs(listePiege) do
      if b.x > p.positionPiegeX - b.image:getWidth()/2 and b.x < p.positionPiegeX + p.taillePiegeX + b.image:getWidth()/2 then
        if b.y > p.positionPiegeY - 10 and b.y < p.positionPiegeY + p.taillePiegeY + 10 then
          b.orientationX = -b.orientationX
          local bx = b.x
          local by = b.y
          b.x = bx
          b.y = by
        end
      end
    end
  end
end