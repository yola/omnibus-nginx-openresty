
name "nginx-openresty"
maintainer "Bearnard Hibbins <bearnard@gmail.com>"
homepage "http://openresty.org"

replaces        "nginx-openresty"
install_path    "/opt/nginx-openresty"
build_version   '1.5.11.1'
build_iteration 1

# creates required build directories
dependency "preparation"

# openresty dependencies/components
dependency "nginx-openresty"
dependency "luarocks"
dependency "lua-resty-riak"
dependency "luafilesystem"
dependency "luasec"
dependency "luasocket"

dependency "mmap_lowmem"

# version manifest file
dependency "version-manifest"

exclude "\.git*"
exclude "bundler\/git"
