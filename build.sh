#!/bin/bash
set -eux

bundle install --without development
sudo chown -R vagrant:vagrant ~/.ccache
bundle exec omnibus build openresty --override append_timestamp:false
