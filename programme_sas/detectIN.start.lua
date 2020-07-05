-- si le joueur est dans le sas depuis l'extérieur et est dans la liste
-- on ouvre la porte 2 

doorIN.activate()


if(salle_bloque == false)then
    sas_state = 1
    doorOUT.deactivate()
end


