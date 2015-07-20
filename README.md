# openresty Omnibus project

This project creates full-stack ubuntu platform-specific packages for
`openresty - http://openresty.org`!

## Installation

We'll assume you have Ruby 1.9+ and Bundler installed. First ensure all
required gems are installed and ready to use:

Grab Vagrant from http://vagrantup.com and follow the ubuntu instructions.


```shell
$ vagrant plugin install vagrant-omnibus vagrant-vbguest vagrant-berkshelf
```

```shell
gem install bundler && gem update bundler
```

```shell
$ bundle install --binstubs
```

## Usage

### Build

Kitchen-based Build Environment
-------------------------------


```shell
$ bundle exec kitchen converge openresty-ubuntu-1204 or openresty-ubuntu-1404
```

Then login to the instance and build the project as described in the Usage
section:

```shell
$ bundle exec kitchen login openresty-ubuntu-1204 or openresty-ubuntu-1404
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
