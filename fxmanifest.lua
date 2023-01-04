fx_version 'cerulean'
game 'gta5'

description 'QB-Saler'
version '1.1.0'
author 'Kierwin1987'

shared_scripts {
    '@qb-core/shared/locale.lua',
    'locales/en.lua',
    'config.lua'
}

server_script 'server.lua'
client_scripts {
    '@PolyZone/client.lua',
    '@PolyZone/BoxZone.lua',
    '@PolyZone/EntityZone.lua',
    '@PolyZone/CircleZone.lua',
    '@PolyZone/ComboZone.lua',
    'client.lua'
}

dependencies {
    'qb-core',
    'PolyZone'
}

lua54 'yes'