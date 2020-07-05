--[[ BIBLIOTHEQUE DES AFFICHAGES ]]--

------------------------------------------------
------------------------------------------------
--          ECRAN ADMIN INTERIEUR
------------------------------------------------
------------------------------------------------

-----------------------------------
--[[	  	   TITRE		   ]]--
-----------------------------------

    admin_titre = BG_Block:_new({x = 0 , y = 0 ,type="header",class="header", 
        style={
            tal="center",
            w= 12 ,h=2,
            bgc="white",
            b="5px solid grey",
            c="black",
            br=10,
            fs=40,
            flex={"col","ard"}
        }, content=admin_titre()})
    -----------------------------------
    --[[	   GESTION TEMPS      ]]--
    -----------------------------------
    admin_temps_gestion = BG_Block:_new({x = 0 , y = 2 ,type="aside",class="aside", 
        style={
            tal="center",
            w= 6 ,h=10,
            bgc="white",
            b="5px solid grey",
            c="black",
            br=10,
            fs=35,
            flex={"col","btw"}
        }, content="Temps de réservation<br />Modifiez le compteur pour changer la durée"})
    
    -----------------------------------
    --[[	   Heures		    ]]--
    -----------------------------------

    admin_block_heures = BG_Block:_new({x = 0 , y = 5 ,type="aside",class="hour", 
        style={
            tal="center",
            w= 3 ,h=2,
            c="black",
            bgc="none",
            fs=25,
            flex={"row","ard"}
        }, content= admin_time_setter("hour")})

    admin_block_minutes = BG_Block:_new({x = 3 , y = 5 ,type="aside",class="minute", 
        style={
            tal="center",
            w= 3 ,h=2,
            c="black",
            bgc="none",
            fs=25,
            flex={"row","ard"}
        }, content= admin_time_setter("minute")})

    -----------------------------------
    --[[		 PARTICIPANTS    ]]--
    -----------------------------------
    admin_participants = BG_Block:_new({x = 6 , y = 2 ,type="aside",class="aside", 
        style={
            tal="center",
            w= 6 ,h=2,
            bgc="white",
            b="5px solid grey",
            c="black",
            br=10,
            fs=30,
            flex={"col","ard"}
        }, content=
        [[Joureurs autorisés <br />à rentrer dans la salle :]]    
        })


    admin_participants_list = BG_Block:_new({x = 6 , y = 4 ,type="aside",class="aside", 
        style={
            tal="center",
            w= 6 ,h=7,
            bgc="white",
            b="5px solid grey",
            c="black",
            br=10,
            fs=40,
            flex={"col","btw"}
        }, content =  admin_text_player_list()
        })
    admin_participants_add = BG_Block:_new({x = 6 , y = 11 ,type="aside",class="aside", 
        style={
            tal="center",
            w= 6 ,h=1,
            bgc="white",
            b="5px solid grey",
            c="black",
            br=10,
            fs=30,
            flex={"col","ard"}
        }, content=admin_btn_add()
        })
    -----------------------------------
    --[[		 LIBERATION      ]]--
    -----------------------------------
    admin_liberation = BG_Block:_new({x = 1 , y = 8 ,type="aside",class="aside", 
    style={
        tal="center",
        w= 4 ,h=2,
        bgc="#ffcccc",
        b="5px solid grey",
        c="black",
        br=10,
        fs=25,
        flex={"col","ard"}
    }, content="Libérer la salle"})

------------------------------------------------
------------------------------------------------
--          ECRAN SAS SCREEN XS
------------------------------------------------
------------------------------------------------

-----------------------------------
--[[		 TITRE		   ]]--
-----------------------------------
sas_titre = BG_Block:_new({x = 0 , y = 0 ,type="header",class="header", 
    style={
        tal="center",
        w= 12 ,h=2,
        bgc="white",
        b="5px solid grey",
        c="black",
        br=10,
        fs=40,
        flex={"col","ard"}
    }, content= player_title() })
-----------------------------------
--[[		DESCRIPTION	    ]]--
-----------------------------------
sas_description = BG_Block:_new({x = 0 , y = 2 ,type="aside",class="aside", 
    style={
        tal="center",
        w= 12 ,h=2,
        bgc="white",
        b="5px solid grey",
        c="black",
        br=10,
        fs=40,
        flex={"col","ard"}
    }, content="Vous allez rentrer dans la salle XXX"})
-----------------------------------
--[[		 BLOQUAGE        ]]--
-----------------------------------
sas_blocquage = BG_Block:_new({x = 0 , y = 4 ,type="aside",class="aside", 
    style={
        tal="center",
        w= 6 ,h=8,
        bgc="white",
        b="5px solid grey",
        c="black",
        br=10,
        fs=35,
        flex={"col","btw"}
    }, content="Bloquer la salle ?"})
sas_blocquage_details = BG_Block:_new({x = 0 , y = 8 ,type="aside",class="aside", 
    style={
        tal="center",
        w= 6 ,h=4,
        c="black",
        bgc="white",
        fs=25,
        flex={"col","ard"}
    }, content="<em>(La durée du bloquage de la salle est de 10 minutes.<br />Si vous souhaitez la modifier, utilisez la panneau de configuration à l'intérieur de la salle.)</em>"})
sas_blocquage_oui = BG_Block:_new({x = 1 , y = 6 ,type="aside",class="aside", 
    style={
        tal="center",
        w= 2 ,h=2,
        bgc="#66ff99",
        b="3px solid black",
        c="black",
        br=5,
        fs=40,
        flex={"col","ard"}
    }, content="OUI"})
sas_blocquage_non = BG_Block:_new({x = 3 , y = 6 ,type="aside",class="aside", 
    style={
        tal="center",
        w= 2 ,h=2,
        bgc="#ffcccc",
        b="3px solid black",
        c="black",
        br=5,
        fs=40,
        flex={"col","ard"}
    }, content="NON"})
-----------------------------------
--[[		 PARTICIPANTS    ]]--
-----------------------------------
sas_participants = BG_Block:_new({x = 8 , y = 4 ,type="aside",class="aside", 
    style={
        tal="center",
        w= 4 ,h=8,
        bgc="white",
        b="5px solid grey",
        c="black",
        br=10,
        fs=40,
        flex={"col","ard"}
    }, content= list_player_in()
})
-----------------------------------
--[[		 Boutons	    ]]--
-----------------------------------
sas_btn_sortir = BG_Block:_new({x = 6 , y = 8 ,type="aside",class="aside", 
    style={
        tal="center",
        w= 2 ,h=2,
        bgc="#ffcccc",
        b="5px solid grey",
        c="black",
        br=10,
        fs=25,
        flex={"col","ard"}
    }, content="Sortir"})

------------------------------------------------
------------------------------------------------
--          ECRAN EXTERIEUR SCREEN XS
------------------------------------------------
------------------------------------------------

out_etat = BG_Block:_new({x = 0 , y = 0 ,type="header",class="header", 
    style={
        tal="center",
        w= 12 ,h=2,
        bgc="whitte",
        b="5px solid grey",
        c="black",
        br=10,
        fs=40,
        flex={"col","ard"}
    }, content=etat_de_la_salle()})
out_time = BG_Block:_new({x = 0 , y = 4 ,type="header",class="header", 
    style={
        tal="center",
        w= 12 ,h=6,
        bgc="whitte",
        b="5px solid grey",
        c="black",
        br=10,
        fs=40,
        flex={"col","ard"}
    }, content=temps_restant()})
out_user = BG_Block:_new({x = 0 , y = 8 ,type="header",class="header", 
    style={
        tal="center",
        w= 12 ,h=4,
        bgc="whitte",
        b="5px solid grey",
        c="black",
        br=10,
        fs=40,
        flex={"col","ard"}
    }, content=utilisateurs()})

