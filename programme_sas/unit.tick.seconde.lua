-- system.print(system.getTime())


if(timer_fermeture ~= nil and timer_fermeture > 0)then
    timer_fermeture = timer_fermeture - 1
    system.print("fermeture de la session dans : " .. timer_fermeture .. "secondes.")
end
if(timer_fermeture ~= nil and timer_fermeture == 0)then
    fermeture_time("end")
end
    