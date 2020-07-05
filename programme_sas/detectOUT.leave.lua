doorOUT.deactivate()

if(sas_state ~= 3 and salle_bloque == false)then
    doorOUT.deactivate()
end

-- si le joueur ressort sans réserver la salle
if(sas_state == 3)then
	player_enter = {}
	sas_state = 0
end

