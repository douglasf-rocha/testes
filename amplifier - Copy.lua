print('Loading amplifier.lua')

function BackToCity(Player)
    print(""..GetChaDefaultName(Player).."")
print(""..GetChaMapName(Player).."")

    if  GetChaMapName(Player) =="garner2" then
        --print("yes yes")
        --ReAll(Player)
        return "Chaos Portal"
    end


    return "" -- this mean return to deafult spawn
end