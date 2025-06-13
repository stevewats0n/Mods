





function Table_length(table)
    local length = 0
    for k, v in pairs(table) do
        length = length + 1
    end
    return(length)
end

function View(table)
    for k, v in pairs(table) do
    print (k, v)
    end
end

function PrintProxyInfo(obj)
    print('type=' .. obj.proxyType .. ' readOnly=' .. tostring(obj.readonly) .. ' readableKeys=' .. table.concat(obj.readableKeys, ',') .. ' writableKeys=' .. table.concat(obj.writableKeys, ','));
end

function Round(number)
        return(math.floor(number + 0.5))
end

function Sum(table)
    local total = 0
    for k, v in pairs(table) do
        total = total + v
    end
    return(total)
end

function In(value, table)
    local result = false
    for k, v in pairs(table) do
        if value == v then
            result = true break
        end
    end
    return(result)
end

function Random_array(len, to)
    local rand = {}
    local rand_size = 0
    while rand_size < len do
        local x = math.random(1, to)
        if not In(x, rand) then
            table.insert(rand, x)
            rand_size = rand_size + 1
        end
    end
    return(rand)
end

function Add_structure (terr_id, structure, amount)
    local struc = {}
    struc[structure] = amount

    local output = WL.TerritoryModification.Create(terr_id)
    output.AddStructuresOpt = struc
    return(output)
end

function Add_armies (terr_id, amount)
    local output = WL.TerritoryModification.Create(terr_id)
    output.AddArmies = amount
    return(output)
end

-- if negative then make 0
function Unnegative (amount)
    if amount == nil then return(nil)
    elseif amount < 0 then return(0)
    else return(amount)
    end
end
