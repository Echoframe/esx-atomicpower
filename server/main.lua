local playersProcessingUranium = {}

RegisterServerEvent('esx_atomicpower:pickedUraniumBox')
AddEventHandler('esx_atomicpower:pickedUraniumBox', function()
	local xPlayer = ESX.GetPlayerFromId(source)
	local xItem = xPlayer.getInventoryItem('radbox')

	if not xPlayer.canCarryItem('radbox', xItem.count + 1) then
		TriggerClientEvent('esx:showNotification', _source, _U('uran_fullprompt'))
	else
		xPlayer.addInventoryItem(xItem.name, 1)
	end
end)

RegisterServerEvent('esx_atomicpower:processBoxedUranium')
AddEventHandler('esx_atomicpower:processBoxedUranium', function()
	if not playersProcessingUranium[source] then
		local _source = source


			local xPlayer = ESX.GetPlayerFromId(_source)
			local xSBox, xDirtyUranium = xPlayer.getInventoryItem('radbox'), xPlayer.getInventoryItem('dirty_uranium')


				if not xPlayer.canCarryItem('dirty_uranium', xDirtyUranium.count + 1) then
					TriggerClientEvent('esx:showNotification', _source, _U('uran_fullprompt'))
				elseif xSBox.count < 1 then
					TriggerClientEvent('esx:showNotification', _source, _U('uran_processingtoofar'))
				else
					xPlayer.removeInventoryItem('radbox', 1)
					xPlayer.addInventoryItem('dirty_uranium', 1)

					TriggerClientEvent('esx:showNotification', _source, _U('uran_processed'))
				end


			playersProcessingUranium[_source] = nil
	else
		print(('esx_atomicpower: %s attempted to exploit uranium processing!'):format(GetPlayerIdentifiers(source)[1]))
	end
end)

RegisterServerEvent('esx_atomicpower:processDirtyUranium')
AddEventHandler('esx_atomicpower:processDirtyUranium', function()
	if not playersProcessingUranium[source] then
		local _source = source
		
		local xPlayer = ESX.GetPlayerFromId(_source)
		local xDU, xCU = xPlayer.getInventoryItem('dirty_uranium'), xPlayer.getInventoryItem('cleaned_uranium')

			if not xPlayer.canCarryItem('cleaned_uranium', xCU.count + 1) then
				TriggerClientEvent('esx:showNotification', _source, _U('uran_fullprompt'))
			elseif xDU.count < 1 then
				TriggerClientEvent('esx:showNotification', _source, _U('uran_processed_2'))
			else
				xPlayer.removeInventoryItem('dirty_uranium', 1)
				xPlayer.addInventoryItem('cleaned_uranium', 1)
				TriggerClientEvent('esx:showNotification', _source, _U('uran_cleaned'))
			end

		playersProcessingUranium[_source] = nil
	else
		print(('esx_atomicpower: %s attempted to exploit uranium processing!'):format(GetPlayerIdentifiers(source)[1]))
	end
end)

RegisterServerEvent('esx_atomicpower:pressUranium')
AddEventHandler('esx_atomicpower:pressUranium', function()
	if not playersProcessingUranium[source] then
		local _source = source


			local xPlayer = ESX.GetPlayerFromId(_source)
			local xDUr, xUraniumRod = xPlayer.getInventoryItem('cleaned_uranium'), xPlayer.getInventoryItem('uranium_rod')

				if not xPlayer.canCarryItem('uranium_rod', xUraniumRod.count + 1) then
					TriggerClientEvent('esx:showNotification', _source, _U('uran_fullprompt'))
				elseif xDUr.count < 1 then
					TriggerClientEvent('esx:showNotification', _source, _U('uran_processed_2'))
				else
					xPlayer.removeInventoryItem('cleaned_uranium', 1)
					xPlayer.addInventoryItem('uranium_rod', 1)

					TriggerClientEvent('esx:showNotification', _source, _U('uran_processed'))
				end

			playersProcessingUranium[_source] = nil
	else
		print(('esx_atomicpower: %s attempted to exploit uranium processing!'):format(GetPlayerIdentifiers(source)[1]))
	end
end)

RegisterServerEvent('esx_atomicpower:sellUranium')
AddEventHandler('esx_atomicpower:sellUranium', function()
	if not playersProcessingUranium[source] then
		local _source = source


			local xPlayer = ESX.GetPlayerFromId(_source)
			local xDUr = xPlayer.getInventoryItem('uranium_rod')


				if xDUr.count < 1 then
					TriggerClientEvent('esx:showNotification', _source, _U('uran_processed_2'))
				else
					xPlayer.removeInventoryItem('uranium_rod', 1)
					xPlayer.addAccountMoney('bank', Config.Pay) --500 by default

					TriggerClientEvent('esx:showNotification', _source, _U('uran_sold'))
				end

			playersProcessingUranium[_source] = nil
	else
		print(('esx_atomicpower: %s attempted to exploit uranium processing!'):format(GetPlayerIdentifiers(source)[1]))
	end
end)

function CancelProcessing(playerID)
	if playersProcessingUranium[playerID] then
		ESX.ClearTimeout(playersProcessingUranium[playerID])
		playersProcessingUranium[playerID] = nil
	end
end

RegisterServerEvent('esx_atomicpower:cancelProcessing')
AddEventHandler('esx_atomicpower:cancelProcessing', function()
	CancelProcessing(source)
end)

AddEventHandler('esx:playerDropped', function(playerID, reason)
	CancelProcessing(playerID)
end)

RegisterServerEvent('esx:onPlayerDeath')
AddEventHandler('esx:onPlayerDeath', function(data)
	CancelProcessing(source)
end)

ESX.RegisterServerCallback('esx_atomicpower:canPickUp', function(source, cb, item)
	local xPlayer = ESX.GetPlayerFromId(source)
	cb(xPlayer.canCarryItem(item, 1))
end)