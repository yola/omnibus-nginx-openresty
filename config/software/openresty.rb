#
# Copyright 2012-2014 Chef Software, Inc.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

name "openresty"
default_version "1.9.7.2"

dependency "pcre"
dependency "openssl"
dependency "zlib"

version("1.9.7.2") { source md5: "78a263de11ff43c95e847f208cce0899" }

source url: "http://openresty.org/download/ngx_openresty-#{version}.tar.gz"

relative_path "ngx_openresty-#{version}"

build do
  env = with_standard_compiler_flags(with_embedded_path)
  env['PATH'] += "#{env['PATH']}:/usr/sbin:/sbin"

  configure = [
    "./configure",
    "--prefix=#{install_dir}/embedded",
    "--sbin-path=#{install_dir}/embedded/sbin/nginx",
    "--conf-path=#{install_dir}/embedded/conf/nginx.conf",
    "--with-http_ssl_module",
    "--with-debug",
    "--with-http_stub_status_module",
    # Building Nginx with non-system OpenSSL
    # http://www.ruby-forum.com/topic/207287#902308
    "--with-ld-opt=\"-L#{install_dir}/embedded/lib -Wl,-rpath,#{install_dir}/embedded/lib -lssl -lcrypto -ldl -lz\"",
    "--with-cc-opt=\"-L#{install_dir}/embedded/lib -I#{install_dir}/embedded/include\"",
    # Options inspired by the OpenResty Cookbook
    '--with-md5-asm',
    '--with-sha1-asm',
    '--with-pcre-jit',
    '--with-luajit',
    '--with-http_realip_module',
    '--without-http_ssi_module',
    '--without-mail_smtp_module',
    '--without-mail_imap_module',
    '--without-mail_pop3_module',
    '--with-ipv6',
  ]

  command configure.join(" "), env: env

  make "-j #{workers}", env: env
  make "install", env: env

end
