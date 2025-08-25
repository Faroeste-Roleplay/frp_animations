fx_version 'bodacious'
games {'rdr3'}

rdr3_warning 'I acknowledge that this is a prerelease build of RedM, and I am aware my resources *will* become incompatible once RedM ships.'

client_scripts {
	'config.lua',
	'client/*.lua'
}

server_scripts {
	'server/main.lua',
}

lua54 'yes'

dependency 'frp_menu_base'