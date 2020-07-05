system.print("alt 1 pressed")
if(#pos_table == 0 )then
pos_table[1] = vec3( core.getConstructWorldPos())
    else pos_table[#pos_table +1] = vec3( core.getConstructWorldPos())
end
print_all_pos(pos_table)