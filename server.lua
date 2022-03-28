

ServerFramework = "redemrp" -- "redemrp" or "vorp"

local VorpCore

if ServerFramework == "vorp" then
    TriggerEvent("getCore",function(core)
        VorpCore = core
    end)
end

ServerRents = {
    [1] = {
        name = "Hearthlands Buffalo",
        price = 100,
    },
    [2] = {
        name = "New Austin Buffalos",
        price = 50,
    },
}

RegisterServerEvent("ricx_buffalo:check_rent")
AddEventHandler("ricx_buffalo:check_rent", function(id)
	local _source = source
    local _id = tonumber(id)
    local price = ServerRents[_id].price
    if ServerFramework == "redemrp" then
        TriggerEvent('redemrp:getPlayerFromId', _source, function(user)
            local money = user.getMoney()
            if money >= price then 
                user.removeMoney(price)
                TriggerClientEvent("ricx_buffalo:rented_buffalo", _source)
            else
                return
            end
        end)
    elseif ServerFramework == "vorp" then
        local Character = VorpCore.getUser(_source).getUsedCharacter
        local money = Character.money
        if money >= price then 
            Character.removeCurrency(0 , tonumber(price))
            TriggerClientEvent("ricx_buffalo:rented_buffalo", _source)
        else
            return
        end
    end
end)
