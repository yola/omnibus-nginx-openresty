name "lua-pb"
default_version "master"

dependency "nginx-openresty"
dependency "luarocks"

source git: "https://github.com/Neopallium/lua-pb.git"

build do
  command "#{install_dir}/embedded/luajit/bin/luarocks make"
end
