name "luarocks"
version "2.1.1"

dependency "nginx-openresty"

source url: "http://luarocks.org/releases/luarocks-#{version}.tar.gz", md5: "911da64d6426340674ba478b40b26b4e"

relative_path "luarocks-#{version}"

build do
  command ["./configure",
           "--prefix=#{install_dir}/embedded/luajit",
           "--lua-suffix=jit",
           "--with-lua=#{install_dir}/embedded/luajit",
           "--with-lua-include=#{install_dir}/embedded/luajit/include/luajit-2.1",
           "--with-lua-lib=#{install_dir}/embedded/luajit/lib"
          ].join(" ")

  command "make"
  command "make install"
end
