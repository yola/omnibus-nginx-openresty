#!/bin/bash
set -eux

bundle install --without development
chown -R vagrant:vagrant ~/.ccache
bundle exec omnibus build openresty --override append_timestamp:false
