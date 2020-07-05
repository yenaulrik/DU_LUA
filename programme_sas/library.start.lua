-- Standard Library
maths={}
function maths.dot(a,b) return a.x*b.x+a.y*b.y+a.z*b.z end
function maths.getLocal(v) return vec3(maths.dot(v,osys.RGT),maths.dot(v,osys.FWD),maths.dot(v,osys.UP)) end
function maths.getGlobal(v) return v.x*osys.RGT + v.y*osys.FWD + v.z*osys.UP end
function maths.norm(v) return v/v:len() end
function maths.sign(a) if a==0 then return 1 else return a/math.abs(a) end end
function maths.round(num,n) local mult=10^(n or 0); return math.floor(num * mult + 0.5)/mult end
function maths.lerp(a,l,h) return a*(h-l)+l end
function maths.clamp(v,min,max) return math.max(math.min(v,max),min) end

utils={}
function utils.b2num(v) return v and 1 or 0 end
function utils.v2str(v) return "[ "..maths.round(v.x or 0,1)..", "..maths.round(v.y or 0,1)..", "..maths.round(v.z or 0,1).."]" end
function utils.find(t,v)
    if t == nil then
        return false
    end
    for k=1,#t do 
        if t[k] == v then 
            return k 
        end 
    end 
    return false 
end 

debug={}
function debug.alert(s) system.print([[<span style="color:#FFF; background-color:#F00" >]]..s..[[</span>]]) end
function debug.info(s) system.print([[<span style="color:#AFDAFF" >]]..s..[[</span>]]) end

format={}
function format.dist(n)
    if n<1000 then
        return maths.round(n,2)..' m'
    elseif n<100000 then
        return format.num(maths.round(n/1000,2))..' km'
    else
        return format.num(maths.round(n/200000,2))..' SU'
    end
end

--[[ format de l'heure
form : 
	0 => dd:hh:mm:ss:ms
	1 => dd hh:mm:ss:ms
	2 => dd hh:mm:ss
	3 => hh:mm:ss
TZ : timezone (temps à ajouter) défaut : TZ = 0 => UTC
--]]
function format.time(n, form, TZ)
    
    local form=form or false;
    local j=math.floor(n/86400)
    local h=math.floor((n%86400)/3600)
    local min=math.floor(((n%86400)%3600)/60) or 0
    local sec=math.floor(((n%86400)%3600)%60) or 0
    local ms=math.floor((((n%86400)%3600)%60)*1000) - sec*1000 or 0

    local str=""
    if form == 0 then
        str=string.format("%dj:%02d:%02d:%02d:%02d",math.floor(j),h,min,sec,ms)
    elseif form == 1 then
        str=string.format("%dj %02d:%02d:%02d:%02d",math.floor(j),h,min,sec,ms)
    elseif form == 2 then
        str=string.format("%dj %02d:%02d:%02d",math.floor(j),h,min,sec)
    elseif form == 3 then
        str=string.format("%02d:%02d:%02d",h,min,sec)
    end
    return str
end

function format.num(n)
    local f=n
    while true do  
        f, k=string.gsub(f, "^(-?%d+)(%d%d%d)", '%1 %2')
        if (k==0) then
            break
        end
    end
    return f
end