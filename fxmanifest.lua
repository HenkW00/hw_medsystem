fx_version 'cerulean'
game 'gta5'

author 'HenkW'
description 'Simple Med System for ESX and QBCore rewritten by HW Development'
version '1.2.2'

client_scripts {
  'client/main.lua',
}

server_scripts {
  '@mysql-async/lib/MySQL.lua',
  'server/main.lua',
  'server/version.lua',
}

shared_scripts {
  'config/config.lua',
}

dependencies {
  'hw_utils',
  'es_extended',
  -- 'qb-core'
}