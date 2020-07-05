pos_table = {}

function print_pos(pos)
    return "x : " .. pos.x .. " y : " .. pos.y .. " z : " .. pos.z
end

function print_all_pos(table)
    
    for k,v in pairs(table)do
       system.print("position " .. k .. " : " .. print_pos(v))
    end
end