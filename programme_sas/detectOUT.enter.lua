
-- si un joueur se présente devant la porte
-- on l'ajoute à la liste entrante

if(salle_bloque == false and contains(player_enter, database.getPlayer(id).name) == false)then
    player_enter[#player_enter +1] = database.getPlayer(id).name
end    


if(salle_bloque == true)then system.print("salle_bloque")end
-- si la salle est utilisé et que le joueur fait parti de la liste
-- la porte s'ouvre sinon elle reste fermée (suite detectIN)
if(salle_bloque and joueur_autorise(database.getPlayer(id).name))then
    system.print("ouverture de porte")
    	doorOUT.activate()
    
elseif(salle_bloque and joueur_autorise(database.getPlayer(id).name) == false)then
    system.print(database.getPlayer(id).name .. " n'est pas autorisé à entrer ")
    
elseif(salle_bloque == false  or(salle_bloque == false and sas_state == 0))then
    doorOUT.activate()
    sas_start()
end

