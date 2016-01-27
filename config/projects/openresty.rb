
name "openresty"
maintainer "Yola Operations <ops@yola.com>"

homepage "http://openresty.org"

install_dir    "/opt/openresty"
build_version   '1.9.7.2'
build_iteration 1

# creates required build directories
dependency "preparation"

# openresty dependencies/components
dependency "openresty"

# version manifest file
dependency "version-manifest"

exclude "\.git*"
exclude "bundler\/git"
