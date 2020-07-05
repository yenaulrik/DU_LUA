
---------------------------
--[[ BDD de test
BDD.setStringValue(1,"_CooL_")
BDD.setStringValue(2,"Malky")
BDD.setStringValue(3,"Movix")
BDD.setStringValue(4,"_Czeeaz")
BDD.setStringValue(5,"lkll")
BDD.setStringValue(6,"Moviazeazex")
BDD.setStringValue(7,"eeeee")
]]--
------------------
-- VAR
------------------
unit.setTimer("loop_time", 0.2)
unit.setTimer("seconde", 1)

nom_salle = "Usine Bleu"
time_lock = 0
time_now = 0
minutes_set = 0
heures_set = 2
salle_bloque = salle_bloque or false
timer_fermeture = nil
player_enter = player_enter or {}
player_list = player_list or {"","","","","","",""}
clavier_actif = clavier_actif or false
enter_txt = enter_txt or ""
-- list des positions des noms de player pour la suppression
player_list_del = {
    {x= {0.91 ,0.995},y= {0.34 ,0.40}},
    {x= {0.91 ,0.995},y= {0.41 ,0.47}},
    {x= {0.91 ,0.995},y= {0.49 ,0.55}},
    {x= {0.91 ,0.995},y= {0.56 ,0.62}},
    {x= {0.91 ,0.995},y= {0.64 ,0.70}},
    {x= {0.91 ,0.995},y= {0.71 ,0.77}},
    {x= {0.91 ,0.995},y= {0.79 ,0.85}}
    }

------------------
-- SVG
------------------

plus_add = [[<svg width="50px" height="50px"><circle fill="#ffffff" stroke="#9ce4fc" stroke-width="2" cx="20" cy="21" r="15" fill-opacity="1" stroke-opacity="1"></circle>
<line stroke="#8fd3ea" stroke-width="3" x1="20" y1="7" x2="20" y2="35" fill-opacity="1" stroke-opacity="1"></line>
<line stroke="#8fd3ea" stroke-width="3" x1="6" y1="20" x2="34" y2="20" fill-opacity="1" stroke-opacity="1"></line></svg>]]

croix = [[<svg height="50" width="50"><line fill="none" stroke="#ff0000" x1="2" y1="2" x2="30" y2="30" id="svg_4" fill-opacity="1" stroke-opacity="1" stroke-width="5"></line>
<line fill="none" stroke="#ff0000" stroke-width="5" x1="30" y1="2" x2="2" y2="30" id="svg_3" fill-opacity="1" stroke-opacity="1"></line></svg>]]
radio_uncheck = [[<circle fill="#ffffff" stroke="#000000" stroke-width="2" stroke-dasharray="null" stroke-linejoin="null" stroke-linecap="null" cx="16" cy="15.1" r="10" id="svg_7" stroke-opacity="1" fill-opacity="1"></circle>]]

fleche_haut = [[<svg height="50" width="50"><path fill="#e2e2e2" stroke="grey" stroke-dasharray="null" stroke-linejoin="null" stroke-linecap="null" opacity="1" d="M3.17,32 L17.7,19 L32,32 L25,32 L25,45 L10.5,45 L10.5,32 z" fill-opacity="1" stroke-opacity="1" stroke-width="2"></path></svg>]]
fleche_bas = [[<svg height="50" width="50"><path fill="#e2e2e2" stroke="grey" stroke-dasharray="null" stroke-linejoin="null" stroke-linecap="null" opacity="1" d="M3.17,32 L17.7,19 L32,32 L25,32 L25,45 L10.5,45 L10.5,32 z" fill-opacity="1" stroke-opacity="1" stroke-width="2"transform="rotate(180, 17, 32)"></path></svg>]]

------------------
-- FONCTIONS RENDER ECRANS
------------------

-------- SAS ---------

-- premier affichage de l'écran SAS SCREEN S
function sas_start()
    screenS.clear()
    sas_titre:_render(screenS)
    sas_description:_render(screenS)
    sas_blocquage:_render(screenS)
    sas_blocquage_details:_render(screenS)
    sas_blocquage_oui:_render(screenS)
    sas_blocquage_non:_render(screenS)
    sas_participants:_render(screenS)
    sas_btn_sortir:_render(screenS)
end
-- met a jour l'écran entier
function sas_update()
    sas_titre.content = player_title()
    sas_participants.content = list_player_in()
    sas_titre:_update(screenS)
    sas_participants:_update(screenS)
end

-------- EXTERIEUR ---------

function ext_start()
    out_etat:_render(screenXS)
    out_time:_render(screenXS)
    out_user:_render(screenXS)
end 

function ext_update()
    out_etat.content = etat_de_la_salle()
    out_time.content = temps_restant()
    out_user.content = utilisateurs()
    out_etat:_update(screenXS)
    out_time:_update(screenXS)
    out_user:_update(screenXS)
end

---------- ADMIN ------------

function admin_start()
    screenM.clear()
    --screenS.clear()
    admin_titre:_render(screenM)
    admin_temps_gestion:_render(screenM)
    admin_participants:_render(screenM)
    admin_participants_list:_render(screenM)
    admin_block_heures:_render(screenM)
    admin_block_minutes:_render(screenM)
    admin_participants_add:_render(screenM)
    admin_liberation:_render(screenM)
end

function admin_update_all()
    admin_titre.content = admin_titre()
    admin_block_minutes.content = admin_time_setter("minute")
    admin_block_heures.content = admin_time_setter("hour")
    admin_participants_list.content = admin_text_player_list()
    admin_participants_add.content = admin_btn_add()
    --
    admin_titre:_update(screenM)
    admin_block_heures:_update(screenM)
    admin_block_minutes:_update(screenM)
    admin_participants_list:_update(screenM)
    admin_participants_add:_update(screenM)
end

function admin_titre_update()
    admin_titre.content = admin_titre()
    admin_titre:_update(screenM)
end

function admin_block_time_upadte()
    admin_block_minutes.content = admin_time_setter("minute")
    admin_block_heures.content = admin_time_setter("hour")
    admin_block_minutes:_update(screenM)
    admin_block_minutes:_update(screenM)
end

function admin_participants_list_update()
    admin_participants_list.content = admin_text_player_list()
    admin_participants_list:_update(screenM)
end

------------------
-- FONCTIONS UTILS
------------------

-- crée un timer avec unit.tick(seconde) qui renvoie true à la fin du timer   
-- return true if player is allow to enter in BDD
function fermeture_time(t)
    if(type(t)== "number")then
    screenM.clear();screenS.clear()
    system.print("Fermeture lancée, veuillez sortir de la salle")
    timer_fermeture = t
    else
        screenS.clear(); screenM.clear();player_enter = {};salle_bloque = false
        BDD.clear();
        -- vider les variables, fermer les portes, vider la bdd, effacer les screens
        system.print("session Terminée")
        timer_fermeture = nil
    end
end

-- retourne true si je joueur est dans player list
function joueur_autorise(p)
    BDD_player_read()
    allow_enter = false
    for k,v in pairs(player_list)do
        if(p == v)then allow_enter = true end
    end
    return allow_enter
end

-- lis la BDD et copie les nom dans player_list
function BDD_player_read()
    local i = false
    for k,v in pairs(player_list)do
        if(BDD.getStringValue(k) ~= "")then
            system.print("joueur en BDD : " .. BDD.getStringValue(k) )
            player_list[k] = BDD.getStringValue(k)
            i = true
        end
    end
    return i
end

-- mise à jour de la BDD 
function BDD_player_update()
    for k,v in pairs(player_list)do
        BDD.setStringValue(k,"")
    end
    for k,v in pairs(player_list)do
        if(v ~= "")then
            BDD.setStringValue(k,v)
        end
    end
end

-- vérifie si un tableau contient une valeur
function contains(tab, val)
    for k, v in ipairs(tab) do
        if tab[k] == val then
            return true
        end
    end
    return false
end

------------------
-- FONCTIONS BLOCKS CONTENT
------------------

-- out_etat.CONTENT (SCREEN XS)
-- si la salle est bloqué ou non
function etat_de_la_salle()
    local text = ""
    if(salle_bloque == false)then
        text = "Salle LIBRE"
    else
        text = "Salle BLOQUEE"
    end
    return text
end

-- out_time.CONTENT (SCREEN XS)
-- affiche le temps restant si la salle est bloqué
function temps_restant()
    local text =""
    return ""
end
-- out_user.CONTENT (SCREEN XS)
-- affiche les joueurs qui bloquent la salle
function utilisateurs()
    local text = ""
    if(salle_bloque == false)then
        text = "Utilisateur principale : " .. BDD.getStringValue(1)
    else
        text = "Personne n'a bloqué la salle"
    end
    return text
end

-- participants.CONTENT (SCREEN S)
function list_player_in()
	local text= ""
    
        for k,v in pairs(player_enter)do
            text = text .. [[<div style="border:2px solid black">]] .. v .. [[</div>]]
        end
	return text
end

-- titre.CONTENT (SCREEN S)
-- fait le text de bienvenue pour les joueurs dans le SAS
function player_title()
    local text= ""
        for k,v in pairs(player_enter)do
            text =[[Bienvenue ]] .. player_enter[1] ..[[!!]]
        end
    return text
end

-- titre.CONTENT (SCREEN M)
-- Titre du panneau admin
function admin_titre()
    return "Panneau de configuration<br />Salle : " .. nom_salle
end

-- participants_list.CONTENT (SCREEN M)
-- prend player_list pour le transformer en 'text' pour le block participants_list
function admin_text_player_list()
    local text = ""
    for k , v in pairs(player_list)do
        if(v ~= "")then
            text = text .. [[<div style="border:2px solid black;position:relative">]]..  v ..[[<div style="position:absolute;top:5px;right:50px" >]] .. croix .. [[</div></div>]]
        end
    end
    return [[  <div>]] .. text .. [[</div>]]
end

-- participants_add.CONTENT (SCREEN M)
function admin_btn_add()
    return [[<div style="position:relative">Ajouter <div style="position:absolute;top:-5px;right:150px" >]] .. plus_add .. [[</div></div>]]
end
-- block_heures.CONTENT = admin_time_setter("hour") (SCREEN M)
-- block_minutes.CONTENT = admin_time_setter("minute") (SCREEN M)
-- met en forme l'affichage heure / minutes
function admin_time_setter(time)
    if(heures_set < 0)then heures_set = 24 end
    if(minutes_set < 0)then minutes_set = 59; heures_set = heures_set -1  end
    if(heures_set > 23)then heures_set = 0 end
    if(minutes_set > 59)then minutes_set = 0; heures_set = heures_set +1 end
    if(time == "hour")then time = heures_set .. " H"end
    if(time == "minute")then time = minutes_set .. " Min"end
    local text = [[<div style="height:100%;width:70%;margin-left:15px; display:flex;flex-direction:column;justify-content:space-around;border:1px solid black">
                        <div style="font-size:50px">]].. time ..[[</div>
                    </div>
                    <div style="height:100%;width:30%; display:flex;flex-direction:column;">
                        <div style="height:50px;width:50px;border:1px solid black;position:relative"><div style="position:absolute;top:-8px;left:7px">]].. fleche_haut ..[[</div></div>
                        <div style="height:50px;width:50px;border:1px solid black;position:relative"><div style="position:absolute;top:-8px;left:7px">]].. fleche_bas ..[[</div></div>
                    </div>]]
    return text
end


------------------
-- CORE
------------------

BDD.clear()

-- salle occupé
    
    -- can enter
        -- start admin



-- salle libre 
    -- start SAS
    sas_start()
    ext_start()

    if(BDD_player_read() == true)then
        admin_start()
    else 
        BDD_player_read()
        admin_start()
        BDD.setStringValue(1,"joueur test")
    end

    BDD_player_read()
    -- BDD_player_update()