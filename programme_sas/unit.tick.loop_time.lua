-- start quelqu'un entre dans le sas

-- salle occupé
    
    -- can enter
        -- start admin



-- salle libre 
    -- start SAS
















----------------
-- SAS ACTIVE
----------------
if(sas_state == 1 and participants)then 
    participants.content = list_player_in()
    participants:_update(screenS)
    titre.content = player_title()
    titre:_update(screenS)
	-- bloquer la salle blocquage_radio_oui
        if(blocquage_radio_oui)then
            if(blocquage_radio_oui:_clicked(screenS))then
                doorIN.activate()
                sas_state = 2
                salle_bloque = true
                
                for k,v in pairs(player_enter)do
                    player_list[k] = v
                end
                gestion_admin()
                screenS.clear()
                
                -- // afficher la direction    
            end
        end
	-- ne pas bloquer la salle blocquage_radio_non
        if(blocquage_radio_non)then
            if(blocquage_radio_non:_clicked(screenS))then
                doorIN.activate()
                sas_state = 0
                -- // afficher la direction    
            end
        end
        -- sortir // vider les caches et faire sortir le joueur
        if(btn_sortir)then
            if(btn_sortir:_clicked(screenS))then
            system.print("libération de la salle")
            doorOUT.activate()
            sas_state = 3
                fermeture_time(10)
            end
        -- // afficher la direction 
        end
end
-------------------------
-- LIBERATION DE LA SALLE
-------------------------
if(liberation)then
    if(liberation:_clicked(screenM))then
        system.print("libération de la salle")
        doorOUT.activate()
        sas_state = 3
        fermeture_time(1)
    end
end

----------------
-- CLAVIER ACTIVE
----------------
if(clavier_actif == true)then
    if(screenM.getMouseState() == 0) then mouse_click = false end

    if(screenM.getMouseState() > 0 and mouse_click == false)then -- click sur souris
        mouse_click = true
        mouseX= screenM.getMouseX()
        mouseY= screenM.getMouseY()

        -- inscrire
        if(inscrire:_clicked(screenM))then
            for k,v in pairs(player_list)do
                if(v== "")then
                    if(enter_txt ~= "")then
                    player_list[k] = enter_txt
                    enter_txt = ""
                    BDD_player_update()
                    gestion_admin()
                    end
                end
            end
        end
        -- Annuler
        if(cancel:_clicked(screenM))then
            gestion_admin()
        end
        
        for k,v in pairs(lettre_table)do
            if(v:_clicked(screenM))then
                -- si lettre
                if( v.name ~= "upper_btn" and v.name ~= "back")then
                    if(type_case == "lowercase") then 
                        enter_txt = enter_txt .. v.name:lower()
                    end
                    if(type_case == "uppercase") then 
                        enter_txt = enter_txt .. v.name:upper()
                    end
                end
                -- upper ?
                if( v.name == "upper_btn") then -- uppercase appuyé
                    if(type_case == "lowercase") then -- lower actif
                        v.content = "Majuscules"
                        type_case = "uppercase"
                    elseif(type_case == "uppercase") then -- si upper
                        v.content = "minuscules"
                        type_case = "lowercase"
                    end
                    v:_update(screenM)
                end

                -- si back
                if(v.name == "back")then
                    enter_txt = enter_txt:sub(1, -2)
                end

                dir_print.content= "<div> : " .. enter_txt .."</div>"
            end
        end
        system.print("mouse x : " .. mouseX .. " mouse y : " .. mouseY)
    end
    dir_print:_update(screenM)
end
----------------
-- CLAVIER DESACTIVE
----------------

if(screenM.getMouseState() > 0 and clavier_actif == false)then
    mouseX= screenM.getMouseX()
    mouseY= screenM.getMouseY()
    system.print("mouse x : " .. mouseX .. " mouse y : " .. mouseY)
    -- Delete player
    nbr_player = 0
    for k,v in pairs(player_list)do nbr_player = nbr_player +1 end
    for k,v in pairs(player_list_del)do
        if(nbr_player > 1)then
            if((mouseX > v.x[1] and mouseX < v.x[2] ) and 
            (mouseY > v.y[1] and mouseY < v.y[2]))then
                player_list[k] = ""
                BDD_player_update()
            end
        end
    end
    -- heures
        -- UP
        if((mouseX > block_heures.clickZone.up.x[1] and mouseX < block_heures.clickZone.up.x[2] ) and 
            (mouseY > block_heures.clickZone.up.y[1] and mouseY < block_heures.clickZone.up.y[2]))then
            heures_set = heures_set + 1
            block_heures.content = time_setter("hour")
            block_heures:_update(screenM)
            block_minutes.content = time_setter("minute")
                block_minutes:_update(screenM)
            
        end
        -- DOWN
        if((mouseX > block_heures.clickZone.down.x[1] and mouseX < block_heures.clickZone.down.x[2] ) and 
            (mouseY > block_heures.clickZone.down.y[1] and mouseY < block_heures.clickZone.down.y[2]))then
            
            heures_set = heures_set - 1
            block_heures.content = time_setter("hour")
            block_heures:_update(screenM)
            block_minutes.content = time_setter("minute")
                block_minutes:_update(screenM)
            
        end
    -- minutes
        -- UP
        if((mouseX > block_minutes.clickZone.up.x[1] and mouseX < block_minutes.clickZone.up.x[2] ) and 
            (mouseY > block_minutes.clickZone.up.y[1] and mouseY < block_minutes.clickZone.up.y[2]))then
                minutes_set = minutes_set + 1
                block_minutes.content = time_setter("minute")
                block_minutes:_update(screenM)
                    block_heures.content = time_setter("hour")
                    block_heures:_update(screenM)
                
            end
        -- DOWN
        if((mouseX > block_minutes.clickZone.down.x[1] and mouseX < block_minutes.clickZone.down.x[2] ) and 
        (mouseY > block_minutes.clickZone.down.y[1] and mouseY < block_minutes.clickZone.down.y[2]))then
                
                minutes_set = minutes_set - 1
                block_minutes.content = time_setter("minute")
                block_minutes:_update(screenM)
            block_heures.content = time_setter("hour")
            block_heures:_update(screenM)
                
            end
        -- AJOUT DUN PLAYER ET ACTIVATION DU CLAVIER
        if(admin_participants_add:_clicked(screenM))then
            player_add()
        end
end

if(entre_confirme == false)then
    if(screenS.getMouseState() == 0) then mouse_click = false end

    if(screenS.getMouseState() > 0 and mouse_click == false)then -- click sur souris
        mouse_click = true
        mouseX= screenS.getMouseX()
        mouseY= screenS.getMouseY()
        system.print("mouse x : " .. mouseX .. " mouse y : " .. mouseY)
        -- bloquer la salle
        -- ne pas bloquer la salle
        -- Entrer maintenant
        -- Sortir
    end
end

