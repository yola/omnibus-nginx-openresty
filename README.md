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
$ gem install bundler && gem update bundler
```

```shell
$ bundle install --binstubs
```

## Usage

### Build

Kitchen-based Build Environment
-------------------------------

Decide which ubuntu release you want to build for.

`export RELEASE=ubuntu-1204` or `export RELEASE=ubuntu-1404`

```shell
$ bundle exec kitchen converge openresty-$RELEASE
```

Then login to the instance and build the project:

```shell
bundle exec kitchen login openresty-$RELEASE
...
cd omnibus-nginx-openresty
bundle install --without development # Don't install dev tools!
bundle exec omnibus build openresty

```

Then logout of the instance to upload the resultant deb in ./pkg to an s3 repo. run:
```shell
Install deb-s3 https://github.com/krobertson/deb-s3

sudo gem install deb-s3

export AWS_SECRET_ACCESS_KEY=THE_KEY
export AWS_ACCESS_KEY_ID=THE_KEY_ID

deb-s3 upload --bucket yola-nginx-openresty-repo --sign=YOUR_GPG_KEY_ID --visibility=public --codename=[precise or trusty] pkg/*.deb

```
