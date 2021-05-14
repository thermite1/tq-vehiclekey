ESX = nil

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)

RegisterNetEvent("tq-vehiclekey:client:arabayikilitlememlazim")
AddEventHandler("tq-vehiclekey:client:arabayikilitlememlazim", function(plaka)
	local animdict = "anim@heists@keycard@" -- anim "exit"
	RequestAnimDict(animdict)
	while not HasAnimDictLoaded(animdict) do
		Citizen.Wait(1)
	end
    local pPed = PlayerPedId()
	local pCoords = GetEntityCoords(pPed)
	vehicles = ESX.Game.GetVehiclesInArea(pCoords, 20)
		if #vehicles == 0 then
			TriggerEvent('mythic_notify:client:SendAlert', { type = 'error', text = 'Yakınlarda hiç araç yok!'})
		else
			found = false
			for i=1, #vehicles, 1 do
				if found then
					break
				end

			    local vCoords = GetEntityCoords(vehicles[i])
				local distance = GetDistanceBetweenCoords(pCoords, vCoords.x, vCoords.y, vCoords.z, true)
				if distance < 20.0 then
				local plate = ESX.Math.Trim(GetVehicleNumberPlateText(vehicles[i]))
					if plaka == plate then
						local prop = GetHashKey('p_car_keys_01')
                        while not HasModelLoaded(prop) do
                            RequestModel(prop)
                            Citizen.Wait(10)
                        end
                        local keyFob = CreateObject(prop, 1.0, 1.0, 1.0, 1, 1, 0)
						found = true
						local lock = GetVehicleDoorLockStatus(vehicles[i])
						AttachEntityToEntity(keyFob, pPed, GetPedBoneIndex(pPed, 57005), 0.09, 0.04, 0.0, 0.0, 0.0, 0.0, true, true, false, true, 1, true)
						if lock == 1 or lock == 0 then
							SetVehicleDoorShut(vehicles[i], 0, false)
							SetVehicleDoorShut(vehicles[i], 1, false)
							SetVehicleDoorShut(vehicles[i], 2, false)
							SetVehicleDoorShut(vehicles[i], 3, false)
							SetVehicleDoorsLocked(vehicles[i], 2)
							TriggerServerEvent("InteractSound_SV:PlayWithinDistance", 10, "lock", 1.0)
							TriggerEvent('mythic_notify:client:SendAlert', { type = 'error', text = 'Araç kilitlendi.'})
							if not IsPedInAnyVehicle(PlayerPedId(), true) then
								TaskPlayAnim(PlayerPedId(), animdict, "exit", 8.0, 8.0, -1, 48, 1, false, false, false)
							end
							SetVehicleLights(vehicles[i], 2)
							Citizen.Wait(150)
							SetVehicleLights(vehicles[i], 0)
							Citizen.Wait(150)
							SetVehicleLights(vehicles[i], 2)
							Citizen.Wait(150)
							SetVehicleLights(vehicles[i], 0)
						elseif lock == 2 then
							SetVehicleDoorsLocked(vehicles[i], 1)
							TriggerServerEvent("InteractSound_SV:PlayWithinDistance", 10, "unlock", 1.0)
							TriggerEvent('mythic_notify:client:SendAlert', { type = 'inform', text = 'Araç açıldı.'})
							if not IsPedInAnyVehicle(PlayerPedId(), true) then
								TaskPlayAnim(PlayerPedId(), animdict, "exit", 8.0, 8.0, -1, 48, 1, false, false, false)
							end
							SetVehicleLights(vehicles[i], 2)
							Citizen.Wait(150)
							SetVehicleLights(vehicles[i], 0)
							Citizen.Wait(150)
							SetVehicleLights(vehicles[i], 2)
							Citizen.Wait(150)
							SetVehicleLights(vehicles[i], 0)
						end
						Citizen.Wait(2000)
						DeleteObject(keyFob)
						SetModelAsNoLongerNeeded(prop)
						return
                    else
                        TriggerEvent('mythic_notify:client:SendAlert', { type = 'error', text = 'Geçersiz anahtar!'})
					end
				end
			end
		end
end)


local konum = vector3(398.609, 316.165, 103.020) -- buradan istediğiniz yere taşıyabilirsiniz.
Citizen.CreateThread(function()
	while true do
		sleepthread = 2000
				local pPed = PlayerPedId()
				local pCoords = GetEntityCoords(pPed)
				local distance = #(pCoords - konum)

				if distance <= 5.0 then
					sleepthread = 1
					DrawMarker(2, konum.x, konum.y, konum.z, 0, 0, 0, 0, 0, 0, 0.3, 0.3, 0.2, 0, 157, 0, 155, 0, 0, 2, 1, 0, 0, 0)
					if distance <= 1.5 then
						DrawText3D(konum.x, konum.y, konum.z + 0.3, '[E] - Anahtar Çıkart')
						if IsControlJustPressed(1, 38) then
							ESX.TriggerServerCallback("tq-vehiclekey:server:getPlayerVehicles", function(vehicles) --/ m3_garage *-*
								local menuElements = {}
								for k, v in ipairs(vehicles) do
									local vehicleProps = v.props
									if GetLabelText(GetDisplayNameFromVehicleModel(vehicleProps.model)) == "NULL" then
										table.insert(menuElements, {
											label = "Model: Bilinmiyor - Plaka: " .. v.plate, 
											vehicle = v
										})
									else
										table.insert(menuElements, {
											label = "Model: " .. GetLabelText(GetDisplayNameFromVehicleModel(vehicleProps.model)) .. " - Plaka: " .. v.plate,
											vehicle = v
										})
									end
								end

								ESX.UI.Menu.Open("default", GetCurrentResourceName(), "main_garage_menu", {
									title = "Anahtarcı James Hunt",
									elements = menuElements,
									align = "right"
								}, function(data, menu)
									local currentVehicle = data.current.vehicle

									if currentVehicle then
										TriggerServerEvent("tq-vehiclekey:server:needKey", currentVehicle.plate, GetLabelText(GetDisplayNameFromVehicleModel(currentVehicle.props.model)))
										ESX.UI.Menu.CloseAll()
									end

								end, function(data, menu)
									ESX.UI.Menu.CloseAll()
								end)

							end)
						end
					end
				end
		Citizen.Wait(sleepthread)
	end
end)

function DrawText3D(x, y, z, text)
	SetTextScale(0.30, 0.30)
    SetTextFont(0)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(true)
    AddTextComponentString(text)
    SetDrawOrigin(x,y,z, 0)
    DrawText(0.0, 0.0)
    local factor = (string.len(text)) / 250
    DrawRect(0.0, 0.0+0.0125, 0.017+ factor, 0.03, 0, 0, 0, 75)
    ClearDrawOrigin()
end
