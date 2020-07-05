----------------------------------
-- BLOCK GEN
----------------------------------

function do_float(nbr, ifloat)
    return tonumber(string.format("%.".. ifloat .."f", nbr))
end
clickable = {}
function set_clickable(obj)
    print(obj.name .. " " .. obj.clickZone.x[1] .. " " .. obj.clickZone.x[2] .. " " .. obj.clickZone.y[1] .. " " .. obj.clickZone.y[2])

    if(clickable == nil )then
        clickable = { 
            name = obj.name,
            x = {obj.clickZone.x[1] , obj.clickZone.x[2]},
            y = {obj.clickZone.y[1] , obj.clickZone.y[2]}
            }
    else
        clickable[table.getn(clickable)+1] = { 
            name = obj.name,
            x = {obj.clickZone.x[1] , obj.clickZone.x[2]},
            y = {obj.clickZone.y[1] , obj.clickZone.y[2]}
            }
    end
end

BG_Block = {
    x = 0,
    y = 0,
    type="div",
    content = "",
    class="",
    id="",
    style_string="",
    style={},
    output = "",
    clickable = false
}

function BG_Block:_new(o) -- cré l'objet de base en transformant x et y pour l'affichage, lance ensuit _style et _output pour créer le string de la balise html
    o = o or {};
    -- on intègre la position du block x et y dans la grille
    -- grille de 12 x 12
    o.x = do_float((100/12) * o.x, 2)
    o.y = do_float((100/12) * o.y, 2)

    -- on initialize le style
    setmetatable(o, self);
    self.__index = self;
    
    return o;
end

function BG_Block:_render(screen) -- prend l'objet et lance l'affichage avec _style, _output et les infos x et y

    self:_style(self.style) -- va écrire le tableau des style sous forme de balises dans style_string
    self:_output() -- va écrire la baslise entière dans output
    self:_clickZone() -- va donner les point min et max en x et y du block en %
    if(self.clickable == true) then
        set_clickable(self)
    end
    -- si l'id n'a pas encore été généré, alors on appel addContent pour en créer un et générer l'affichage en meme temps
    -- ou on fait un resetContent pour mettre à jour

    if(self.id == "" or self.id == nil)then
        self.id = screen.addContent(self.x, self.y, self.output)
    --else
    --  screen.resetContent(self.id, self._output) 
    end
    return
end

function BG_Block:_inner_block()
    self:_style(self.style)
    self:_output()
    return self.output
end

function BG_Block:_clicked(screen)
    mouseX= screen.getMouseX()
    mouseY= screen.getMouseY()
    local p = false
    
    if(mouseX > self.clickZone.x[1] and mouseX < self.clickZone.x[2]
      and mouseY > self.clickZone.y[1] and mouseY < self.clickZone.y[2] and 
        screen.getMouseState() > 0)then
        p = true
    end
    return p
end

function BG_Block:_clickZone()
    
    xMax = self.x + do_float((100/12) * self.style.w, 2)
    yMax = self.y + do_float((100/12) * self.style.h, 2)
    self.clickZone = { x={self.x /100 , xMax /100}, 
        		   	y={self.y /100, yMax/100},
        			up = {}, down = {}	}
    self.clickZone.up = { x = {self.clickZone.x[1] + 0.18, self.clickZone.x[1] + 0.23 }, 
        			   y = {self.clickZone.y[1] , self.clickZone.y[1] + 0.08 }}
    self.clickZone.down = { x = {self.clickZone.x[1] + 0.18, self.clickZone.x[1] + 0.23}, 
        				y = {self.clickZone.y[1] + 0.08 , self.clickZone.y[1] + 0.16}}
end
function BG_Block:_update(screen)
    -- faire la function qui utilisera resetContent(id, html)
    -- voir si elle doit changer le style ou juste le html
    -- faire le render
    self:_output()
    screen.resetContent(self.id,self.output)

end

function BG_Block:_output() -- prend les info de l'objet et écrit le block complet dans object.output
    local blc = [[<%s class="%s" style="%s">%s</%s>]]
    -- on défini l'emplacement du contenu pour la création du block
    --if(type(self.content) == "string") then 
        self.output = string.format(blc, self.type, self.class, self.style_string, self.content, self.type)
   -- else -- si le "content" est un tableau d'objets, on lance leur _style et _render pour concatainer le contenu
       -- content = ""
        --for k,v in pairs(self.content)do
            
           -- v:_style(v.style)
          --  v:_output()
            --content = content .. v.output
        --end
        --self.output = string.format(blc, self.type, self.class, self.style_string, content, self.type)
    --end
end


function BG_Block:_style() -- array object.style => distribut les style dans object.style_string sous forme d'un seul string

    self.style_string = "box-sizing:border-box;" --de base pour que les boites restent aux bonnes dimensions
    local base              =   [[%s:%s;]]
    local height            =   [[height:%spx;]]
    local width             =   [[width:%spx;]]
    local heightPers        =   [[height:%s ;]]
    local widthPers         =   [[width:%s;]]
    local textAlign         =   [[text-align:%s;]]
    local color             =   [[color:%s;]]
    local fontSize          =   [[font-size:%spx;]]
    local fontWeight        =   [[font-weight:%s;]]
    local backgroundColor   =   [[background-color:%s;]]
    local border            =   [[border-%s:%s;]]
    local borderRadius      =   [[border-radius:%spx;]]
    local boxShadow         =   [[box-Shadow:%s;]]
    local padding           =   [[padding-%s:%s;]]
    local margin            =   [[margin-%s:%s;]]
    local lineHeight        =   [[line-height:%s;]]
        -- classic formatline-height : 1.5;
        if(self.style.h)     then self.style_string  = self.style_string .. string.format(height,self.style.h *(612/12)) end
        if(self.style.w)     then self.style_string  = self.style_string .. string.format(width,self.style.w *(1024/12)) end
        if(self.style._w)    then self.style_string  = self.style_string .. string.format(widthPers,self.style._w) end
        if(self.style._h)    then self.style_string  = self.style_string .. string.format(heightPers,self.style._h) end
        if(self.style.tal)   then self.style_string  = self.style_string .. string.format(textAlign,self.style.tal) end
        if(self.style.c)     then self.style_string  = self.style_string .. string.format(color,self.style.c) end
        if(self.style.fs)    then self.style_string  = self.style_string .. string.format(fontSize,self.style.fs) end
        if(self.style.fw)    then self.style_string  = self.style_string .. string.format(fontWeight,self.style.fw) end
        if(self.style.bgc)   then self.style_string  = self.style_string .. string.format(backgroundColor,self.style.bgc) end
        if(self.style.br)    then self.style_string  = self.style_string .. string.format(borderRadius,self.style.br) end
        if(self.style.bs)    then self.style_string  = self.style_string .. string.format(boxShadow,self.style.bs) end
        if(self.style.lh)    then self.style_string  = self.style_string .. string.format(lineHeight,self.style.lh) end

        -- multiple format
        -- BORDER --
        if(self.style.b)then
            if(self.style.b and type(self.style.b) == "string")then
                self.style_string = self.style_string .. string.format(base, "border", self.style.b)
            else
                for k,v in pairs(self.style.b)do
                    if(type(k) ~= "string") then self.style_string = self.style_string .. string.format(base, "border", v)
                    else self.style_string = self.style_string .. string.format(border,k, v) 
                    end
                end
            end
        end -- border
        -- PADDING --
        if(self.style.pad)then
            if(type(self.style.pad) == "string")then
                self.style_string = self.style_string .. string.format(base, "padding", self.style.pad)
            else
                for k,v in pairs(self.style.pad)do
                    if(type(k) ~= "string") then self.style_string = self.style_string .. string.format(base, "padding", v)
                    else
                        self.style_string = self.style_string .. string.format(padding,k, v) 
                    end
                end
            end
        end -- padding
        -- MARGIN --
        if(self.style.mar)then
            if(self.style.mar and type(self.style.mar) == "string")then
                self.style_string = self.style_string .. string.format(base, "margin", self..style.mar)
            else
                for k,v in pairs(self.style.mar)do
                    if(type(k) ~= "string") then self.style_string = self.style_string .. string.format(base, "margin", v)
                    else
                        self.style_string = self.style_string .. string.format(margin,k, v) 
                    end
                end
            end
        end-- margin
        -- FLEX --
        if(self.style.flex)then
            self.style_string = self.style_string .. string.format(base, "display", "flex")
            
                if(self.style.flex[1] == "col")then
                    self.style_string = self.style_string .. string.format(base, "flex-direction", "column")
                else
                    self.style_string = self.style_string .. string.format(base, "flex-direction", "row")
                end
                if(self.style.flex[2] == "ard")then
                    self.style_string = self.style_string .. string.format(base, "justify-content", "space-around")
                else 
                    self.style_string = self.style_string .. string.format(base, "justify-content", "space-between")
                end
        end -- flex
end -- function Block:_style(style)

