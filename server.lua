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
AddEventHandler("tq-vehiclekey:server:needKey", function(plate, model)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    
                if xPlayer.getInventoryItem('vehiclekey').count < 1 then
                metadata = {
	                plaka = plate,
	                model = model
                }
                    xPlayer.addInventoryItem("vehiclekey", 2, metadata) 
                    TriggerClientEvent('esx:showNotification', source, '2 Adet Anahtar Aldiniz')
                    elseif xPlayer.getInventoryItem('vehiclekey').count > 1 then
                    TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = 'Uzerinde zaten bir anahtar var' })
                end
            end)
