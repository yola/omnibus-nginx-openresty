#!/bin/bash
set -eux

chown -R vagrant:vagrant /opt
bundle install --without development
bundle exec omnibus build openresty --override append_timestamp:false
