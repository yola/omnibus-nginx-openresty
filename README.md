# openresty Omnibus project

This project creates full-stack ubuntu platform-specific packages for
`openresty - http://openresty.org`!

## Installation

We'll assume you have Ruby 1.9+ and Bundler installed.

Grab Vagrant from http://vagrantup.com and follow the instructions.


```shell
vagrant plugin install vagrant-omnibus vagrant-vbguest vagrant-berkshelf
bundle install --binstubs
```

## Usage

### Build

Kitchen-based Build Environment
-------------------------------

Decide which ubuntu release you want to build for.

`export RELEASE=ubuntu-1204` or `export RELEASE=ubuntu-1404`

```shell
bundle exec kitchen converge openresty-$RELEASE
```

Then login to the instance and build the project:

```shell
bundle exec kitchen login openresty-$RELEASE
...
cd omnibus-nginx-openresty
./build.sh
```

Then logout of the instance to upload the resultant deb in ./pkg to an s3 repo. run:
```shell
sudo gem install deb-s3

export AWS_SECRET_ACCESS_KEY=THE_KEY
export AWS_ACCESS_KEY_ID=THE_KEY_ID

deb-s3 upload --bucket yola-nginx-openresty-repo \
       --sign=YOUR_GPG_KEY_ID --preserve-versions \
       --visibility=public --codename=[precise or trusty] pkg/*.deb

```
