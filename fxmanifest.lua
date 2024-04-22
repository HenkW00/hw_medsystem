fx_version 'cerulean'
game 'gta5'

author 'HenkW'
description 'Simple Med System for ESX rewritten by HW Development'
version '1.2.0'

client_scripts {
  'client/main.lua',
}

server_scripts {
  '@mysql-async/lib/MySQL.lua',
  'server/main.lua',
  'server/version.lua',
}

shared_scripts {
  '@es_extended/imports.lua',
  'config/config.lua',
}
