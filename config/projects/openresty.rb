
name "openresty"
maintainer "Yola Operations <ops@yola.com>"

homepage "http://openresty.org"

install_dir    "/opt/openresty"
build_version   '1.7.10.2'
build_iteration 1

# ensures nginx-common isn't uninstalled when purging.
runtime_dependency "nginx-common"

# creates required build directories
dependency "preparation"

# openresty dependencies/components
dependency "openresty"

# version manifest file
dependency "version-manifest"

exclude "\.git*"
exclude "bundler\/git"
