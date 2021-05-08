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

`Kullandığınız galeri eklentisinin aracı satın alma kısmına ekleyin [esx_dealership örnek]`

```lua 
info = {
	plaka = vehicleProps.plate,
	model = vehicleModel
}    
xPlayer.addInventoryItem("vehiclekey", 1, false, info)  
```

![image](https://user-images.githubusercontent.com/71380426/117555304-c0a31c80-b066-11eb-9d7b-9f170ac957c4.png)
