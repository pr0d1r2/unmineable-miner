#!/usr/bin/env bash

set -e -x

function endpoint() {
  echo "rx.unmineable.com:$1"
}

SYMBOL="$(echo "$1" | tr '[a-z]' '[A-Z]')"
POOL_USER="$(unmineable-pool-user "$SYMBOL")"

/usr/sbin/modprobe msr
/usr/local/sbin/enable_1gb_pages

/usr/local/bin/xmrig \
  -a rx/0 \
  -o "$(endpoint 3333)" -u "$POOL_USER" \
  -o "$(endpoint 13333)" -u "$POOL_USER" \
  --randomx-1gb-pages \
  --donate-level 1
