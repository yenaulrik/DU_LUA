----------------
-- CLAVIER
----------------

-- Ajout player avec clavier

function player_add()
    
    clavier_actif = true

    screenM.clear()

    local mouse_click = false
    local lettreColor = "black"
    local bgcLettre = "grey"
    local wLettre = 1
    local hLettre = 1
    local bLettre = "3px solid white"
    local brLettre = 10
    type_case = "lowercase"
    local lettre_list = {"0","1","2","3","4","5","6","7","8","9","_","a","z","e","r","t","y","u","i","o","p","q","s","d","f","g","h","j","k","l","m","w","x","c","v","b","n"}
    lettre_table = {}
    

    function do_lettre_table(i,pos_x, pos_y, name_i)
        lettre_table[i] = BG_Block:_new({x = pos_x , y = pos_y ,type="div",class="div",
            name = name_i,
            style = {
                w = wLettre,
                h = hLettre,
                tal = "center",
                c = lettreColor,
                bgc = bgcLettre,
                fs = 40,
                br = brLettre,
                b = bLettre
            }, content=name_i})
        end

        -- position des lettre au fur et a mesure qu'elle sont créées
        for k,v in pairs(lettre_list) do
            if(k <= 11)then
                    do_lettre_table(k, k - 1, 7,v)
            elseif(k > 11 and k <= 21)then
                    do_lettre_table(k, k - 12, 8,v)
            elseif(k > 21 and k <= 31)then
                    do_lettre_table(k, k - 22, 9,v)
            else
                    do_lettre_table(k, k - 30, 10,v)
            end
        end

        lettre_table[#lettre_table +1] = BG_Block:_new({x = 0 , y = 11 ,type="div",class="div",name="upper_btn", 
                style={
                    w=4,
                    h=1,
                    tal="center",
                    c=lettreColor,
                    bgc=bgcLettre,
                    fs=40,
                    br=brLettre,
                    b=bLettre
                }, content="minuscules"})

        lettre_table[#lettre_table +1] = BG_Block:_new({x = 4 , y = 11 ,type="div",class="div",name="back", 
                style={
                    w=4,
                    h=1,
                    tal="center",
                    c=lettreColor,
                    bgc=bgcLettre,
                    fs=40,
                    br=brLettre,
                    b=bLettre
                }, content="BACK"})

    dir_print = BG_Block:_new({x = 0 , y = 0 ,type="div",class="div", 
    style={
        w=12,
        h=6,
        tal="center",
        c=lettreColor,
        bgc="white",
        fs=80,
        br=brLettre,
        flex={"col","ard"},
        b=bLettre
    }, content="Entrez le pseudo du nouveau joueur"})
    inscrire = BG_Block:_new({x = 2 , y = 6 ,type="div",class="div", 
    style={
        w=4,
        h=1,
        tal="center",
        c=lettreColor,
        bgc="#66ff99",
        fs=40,
        br=brLettre,
        b=bLettre
    }, content="Inscrire"})
    cancel = BG_Block:_new({x = 6 , y = 6 ,type="div",class="div", 
    style={
        w=4,
        h=1,
        tal="center",
        c=lettreColor,
        bgc="#ffcccc",
        fs=40,
        br=brLettre,
        b=bLettre
    }, content="Annuler"})

    for k,v in pairs(lettre_table)do
        v:_render(screenM)
    end
    cancel:_render(screenM)
    inscrire:_render(screenM)
    dir_print:_render(screenM)

end -- fin de function player_add()