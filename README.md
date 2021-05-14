`inventory:server:UseItemSlot`

```lua 
if itemData.name == "vehiclekey" then
	TriggerClientEvent('tq-vehiclekey:client:arabayikilitlememlazim', src, itemData.info.plaka)
end
```
![Screenshot_76](https://user-images.githubusercontent.com/71380426/117555160-7c634c80-b065-11eb-9fc9-8203acced2bd.png)


`inventory:server:UseItem`

```lua 
if item.name == "vehiclekey" then
	TriggerClientEvent('tq-vehiclekey:client:arabayikilitlememlazim', src, itemData.info.plaka)
end
```
![Screenshot_77](https://user-images.githubusercontent.com/71380426/117555197-baf90700-b065-11eb-8add-9ddfe212ffb8.png)

`qb-inventory | app.js`

```javascript 
} else if (itemData.name == "vehiclekey") {
	$(".item-info-title").html('<p>'+itemData.label+'</p>')
	$(".item-info-description").html('<p><strong></strong><span>Plaka : ' + itemData.info.plaka + '</span></p><p><strong></strong><span>Araç Modeli : ' + itemData.info.model + '</span></p>');
```
![image](https://user-images.githubusercontent.com/71380426/117556023-40cc8080-b06d-11eb-94e8-c75e5d575eb0.png)

`Kullandığınız galeri eklentisinin aracı satın alma kısmına ekleyin [esx_dealership örnek]`

```lua 
info = {
	plaka = vehicleProps.plate,
	model = vehicleModel
}    
xPlayer.addInventoryItem("vehiclekey", 1, false, info)  
```

![image](https://user-images.githubusercontent.com/71380426/117555304-c0a31c80-b066-11eb-9d7b-9f170ac957c4.png)


`Anahtar Kontrolü`
```lua
ESX.TriggerServerCallback("tq-vehiclekey:server:checkKey", function(result)
	for i=1, #result, 1 do
		if result[i].info.plaka == GetVehicleNumberPlateText(GetVehiclePedIsIn(PlayerPedId(), false)) then
```

`Örnek`
```lua 
RegisterNUICallback('toggleengine', function(data, cb)
    player = PlayerPedId()
    veh = GetVehiclePedIsIn(player, false)
    if veh ~= 0 then
        ESX.TriggerServerCallback("tq-vehiclekey:server:checkKey", function(result)
            for i=1, #result, 1 do
                if result[i].info.plaka == GetVehicleNumberPlateText(veh) then
                    local engine = not GetIsVehicleEngineRunning(veh)
                    if not IsPedInAnyHeli(player) then
                        SetVehicleEngineOn(veh, engine, false, true)
                        SetVehicleJetEngineOn(veh, engine)
                    else
                        if engine then
                            SetVehicleFuelLevel(veh, vehicle_fuel)
                        else
                            SetVehicleFuelLevel(veh, 0)
                        end
                    end
                end

            end
        end)
    end
    cb('ok')
end)
```
