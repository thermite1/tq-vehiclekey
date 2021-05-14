ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

ESX.RegisterUsableItem('vehiclekey', function() end)

ESX.RegisterServerCallback('tq-vehiclekey:server:checkKey', function(source, cb)
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    local anahtarhocam = ESX.GetSlotsByItem(xPlayer.inventory, "vehiclekey")
    cb(anahtarhocam)
end)

ESX.RegisterServerCallback("tq-vehiclekey:server:getPlayerVehicles", function(source, cb)
	local xPlayer = ESX.GetPlayerFromId(source)
	MySQL.Async.fetchAll('SELECT plate, vehicle FROM owned_vehicles WHERE owner = @identifier', {
		["@identifier"] = xPlayer.identifier,
	}, function(result)
		local vehicles = {}
		for k, v in ipairs(result) do
			table.insert(vehicles, {
				plate = v.plate,
				props = json.decode(v.vehicle)
			})
		end
		cb(vehicles)
	end)
end)

RegisterServerEvent("tq-vehiclekey:server:needKey")
AddEventHandler("tq-vehiclekey:server:needKey", function(plate, vehicleModel)
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    info = {
        plaka = plate,
        model = vehicleModel
    }    
    xPlayer.addInventoryItem("vehiclekey", 1, false, info)    
end)