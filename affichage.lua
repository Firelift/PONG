
function AfficherBalle(nomBalle)
    for n,b in pairs(listeBalle) do
    
      if b.name == nomBalle then
        Balle = listeBalle[n]
        love.graphics.draw(Balle.image, Balle.x, Balle.y, rotationBalle, 1, 1, Balle.Ox, Balle.Oy)
      end
      
    end
end

function AfficherRaquette(nomRaquette)
    for n,r in pairs(listeRaquette) do
      if r.name == nomRaquette then
        Raquette = listeRaquette[n] 
        love.graphics.draw(Raquette.image, Raquette.x, Raquette.y, 0, 1, 1, Raquette.Ox, Raquette.Oy)
      end
    end
end

function AfficherBonus()
  if START == true and BONUS_EN_JEU == true then
    for _,b in pairs(listeBonus) do
      if b.type == 1 then
        love.graphics.setColor(1,0,0) 
      elseif b.type == 2 then
        love.graphics.setColor(0,0,1)
      elseif b.type == 3 then
        love.graphics.setColor(1,1,0)
      end
      love.graphics.rectangle("fill", b.x, b.y, tailleBonus, tailleBonus)
      love.graphics.setColor(1, 1, 1, 1)
    end
  end
end

function AfficherPiege(indexB)
     if indexB == 3  then
      for n,p in pairs(listePiege) do
        love.graphics.setColor(1, 1, 0)
        love.graphics.rectangle("fill", p.positionPiegeX, p.positionPiegeY, p.taillePiegeX, p.taillePiegeY)
        love.graphics.setColor(1, 1, 1, 1)
      end
     end
end

function AffichageDynamique()
  if START == false and JOUEUR_PERD == false then
    love.graphics.print("RESISTE LE PLUS LONGTEMPS POSSIBLE!", screenWidth/2 - 120, 20, 0, 1, 1)
    love.graphics.print(nbBalle.." BALLES RESTANTES", screenWidth/2 - 60, 35, 0, 1, 1)
  end

  if START == true then
    love.graphics.print(math.floor(Chrono).." secondes", screenWidth/2 -40, 20, 0, 1, 1)
  end

  if JOUEUR_PERD == true then
    if RECORD_BATTU == true then
      love.graphics.print("FELICITATIONS! TON RECORD EST AMELIORE.", screenWidth/2 - 150, 20, 0, 1, 1)
      love.graphics.print("TON NOUVEAU RECORD EST DE "..record.." SECONDES!", screenWidth/2 - 150, 35, 0, 1, 1)
      love.graphics.print("APPUIE SUR ESPACE POUR BATTRE TON RECORD!", screenWidth/2 - 160, 50, 0, 1, 1)
    else
      love.graphics.print("TON RECORD EST DE "..record.." SECONDES!", screenWidth/2 - 120, 20, 0, 1, 1)
      love.graphics.print("APPUIE SUR ESPACE POUR BATTRE TON RECORD!", screenWidth/2 - 160, 35, 0, 1, 1)
    end
  end
  
end
