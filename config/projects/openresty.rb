
name "openresty"
maintainer "Bearnard Hibbins <bearnard@gmail.com>"
homepage "http://openresty.org"

install_dir    "/opt/nginx-openresty"
build_version   '1.7.10.1'
build_iteration 1

# creates required build directories
dependency "preparation"

# openresty dependencies/components
dependency "openresty"

# version manifest file
dependency "version-manifest"

exclude "\.git*"
exclude "bundler\/git"
