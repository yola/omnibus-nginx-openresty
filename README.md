# openresty Omnibus project

This project creates full-stack ubuntu platform-specific packages for
`openresty - http://openresty.org`!

## Installation

We'll assume you have Ruby 1.9+ and Bundler installed. First ensure all
required gems are installed and ready to use:

```shell
apt-get install ruby-1.9.3
gem install bundler && gem update bundler
```

```shell
$ bundle install --binstubs
```

You'll also need some Ubuntu packages installed

```shell
apt-get install lxc
```

Grab Vagrant from http://vagrantup.com and follow the ubuntu instructions.


```shell
$ vagrant plugin install vagrant-lxc vagrant-omnibus vagrant-vbguest vagrant-berkshelf
```

## Usage

### Build

You create a platform-specific package using the `build project` command:

```shell
$ bundle exec omnibus build openresty
```

The platform/architecture type of the package created will match the platform
where the `build project` command is invoked. For example, running this command
on a MacBook Pro will generate a Mac OS X package. After the build completes
packages will be available in the `pkg/` folder.

### Clean

You can clean up all temporary files generated during the build process with
the `clean` command:

```shell
$ bundle exec omnibus clean openresty
```

Adding the `--purge` purge option removes __ALL__ files generated during the
build including the project install directory (`/opt/chef`) and
the package cache directory (`/var/cache/omnibus/pkg`):

```shell
$ bundle exec omnibus clean openresty --purge
```

Kitchen-based Build Environment
-------------------------------


```shell
$ bundle exec kitchen converge openresty-ubuntu-1204
```

Then login to the instance and build the project as described in the Usage
section:

```shell
$ bundle exec kitchen login openresty-ubuntu-1204
[vagrant@ubuntu...] $ cd omnibus-nginx-openresty
[vagrant@ubuntu...] $ bundle install --without development # Don't install dev tools!
[vagrant@ubuntu...] $ ...
[vagrant@ubuntu...] $ bundle exec omnibus build openresty

or:

[vagrant@ubuntu...] $ cd omnibus-nginx-openresty
[vagrant@ubuntu...] $ ./build.sh

```

Then logout of the instance to upload the resultant deb in ./pkg to an s3 repo. run:
```shell
Install deb-s3 https://github.com/krobertson/deb-s3

$ export AWS_SECRET_ACCESS_KEY=THE_KEY
$ export AWS_ACCESS_KEY_ID=THE_KEY_ID

deb-s3 upload --bucket yola-nginx-openresty-repo --sign=YOUR_GPG_KEY)ID --visibility=public --codename=(precise or trusty) pkg/*.deb

```
