package = 'ipv4'
version = 'scm-1'
source = {
    url    = 'git+https://github.com/moon-dragon-dev/lua-ipv4.git',
    branch = 'master',
}
description = {
    summary  = 'Some ipv4 functions',
    homepage = 'https://github.com/moon-dragon-dev/lua-ipv4.git',
    license  = 'MIT',
}
dependencies = {
    'lua ~> 5.1',
}
build = {
    type = 'builtin',
    modules = {
        ipv4 = 'ipv4.lua'
    },
}
