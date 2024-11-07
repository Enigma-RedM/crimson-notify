fx_version "adamant"
game "rdr3"
rdr3_warning 'I acknowledge that this is a prerelease build of RedM, and I am aware my resources *will* become incompatible once RedM ships.'

author 'Enigma'
version '1.0'

ui_page 'index.html'

client_scripts {
    'config.lua',
    'notification.lua'
}

server_scripts {
    'config.lua',
    'server.lua'
}

files {
    'Redemption.ttf',
    'index.html',
    'notification.css',
    'img/*.png',
    'img/background/*.png'
}