fx_version 'adamant'

game 'gta5'

description 'ESX Atomic Power Job'

version 'legacy'

shared_script '@es_extended/imports.lua'

server_scripts {
	'@async/async.lua',
	'@mysql-async/lib/MySQL.lua',
	'@es_extended/locale.lua',
	'config.lua',
	'locales/de.lua',
	'server/main.lua'
}

client_scripts {
	'@es_extended/locale.lua',
	'config.lua',
	'locales/de.lua',
	'client/main.lua'
}

dependency 'es_extended'
