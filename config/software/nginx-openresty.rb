require "fileutils"

name "nginx-openresty"
version "1.5.11.1"

dependency "geoip"
dependency "openssl"
dependency "libxml2"
dependency "libxslt"
dependency "pcre"
dependency "gd"
dependency "ngx_cache_purge"
dependency "nginx-statsd"

source url: "http://openresty.org/download/ngx_openresty-#{version}.tar.gz", md5: "4d7a7f3fa745d7257ac2d0edc039fd62"

relative_path "ngx_openresty-#{version}"

build do

  env = {
    "LDFLAGS" => " -pie -L#{install_dir}/embedded/lib -I#{install_dir}/embedded/include",
    "CFLAGS" => " -fPIC -L#{install_dir}/embedded/lib -I#{install_dir}/embedded/include",
    "LD_RUN_PATH" => "#{install_dir}/embedded/lib"
  }


  command ["./configure",
           "--prefix=#{install_dir}/embedded",
           "--with-luajit",
           "--conf-path=#{install_dir}/etc/nginx.conf",
           "--error-log-path=#{install_dir}/log/error.log",
           "--http-log-path=#{install_dir}/log/access.log",
           "--sbin-path=#{install_dir}/sbin/nginx",
           "--http-client-body-temp-path=#{install_dir}/lib/nginx/body",
           "--http-fastcgi-temp-path=#{install_dir}/lib/nginx/fastcgi",
           "--http-proxy-temp-path=#{install_dir}/lib/nginx/proxy",
           "--http-scgi-temp-path=#{install_dir}/lib/nginx/scgi",
           "--http-uwsgi-temp-path=#{install_dir}/lib/nginx/uwsgi",
           "--lock-path=#{install_dir}/lock/nginx.lock",
           "--pid-path=#{install_dir}/run/nginx.pid",
           "--with-http_dav_module",
           "--with-http_flv_module",
           "--with-http_geoip_module",
           "--with-http_gzip_static_module",
           "--with-http_image_filter_module",
           "--with-http_realip_module",
           "--with-http_stub_status_module",
           "--with-http_ssl_module",
           "--with-http_sub_module",
           "--with-http_xslt_module",
           "--with-ipv6",
           "--with-sha1=#{install_dir}/embedded/include/openssl",
           "--with-md5=#{install_dir}/embedded/include/openssl",
           "--with-mail",
           "--with-mail_ssl_module",
           "--with-http_stub_status_module",
           "--with-http_secure_link_module",
           "--with-http_sub_module",
           "--with-luajit-xcflags=' -fPIC '",
           "--with-pcre",
           "--with-pcre-jit",
           "--with-ld-opt=\"-pie -L#{install_dir}/embedded/lib -Wl,-rpath,#{install_dir}/embedded/lib -lssl -lcrypto -ldl -lz\"",
           "--with-cc-opt=\"-fPIC -L#{install_dir}/embedded/lib -I#{install_dir}/embedded/include\"",
           "--add-module=#{source_dir}/ngx_cache_purge",
           "--add-module=#{source_dir}/nginx-statsd"
          ].join(" "), :env => env

  command "make", :env => env
  command "make install", :env => env
  command "rm #{install_dir}/sbin/nginx.old || true"
  command "mkdir -p #{install_dir}/lib/nginx-openresty"
  command "ln -s #{install_dir}/embedded/luajit/bin/luajit-2.1.0-alpha #{install_dir}/embedded/luajit/bin/luajit"

  block do
    dir = File.join(install_dir, "etc", "init")
    FileUtils.mkdir_p(dir)
    FileUtils.cp(File.join(Omnibus.project_root, "etc", "nginx.init"), File.join(dir, "nginx.init"))
  end

end
