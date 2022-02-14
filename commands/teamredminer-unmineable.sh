#!/usr/bin/env bash

set -e -x

SYMBOL="$(echo "$1" | tr '[a-z]' '[A-Z]')"

case $2 in
  "")
    TARGET_SYMBOL="$SYMBOL"
    ;;
  *)
    TARGET_SYMBOL="$(echo "$2" | tr '[a-z]' '[A-Z]')"
    ;;
esac

case "$SYMBOL" in
  ETH)
    ALGO="ethash"
    SUBDOMAIN="ethash"
    ;;
  ETC)
    ALGO="etchash"
    SUBDOMAIN="etchash"
    ;;
  RVN)
    ALGO="kawpow"
    SUBDOMAIN="kp"
    ;;
  *)
    echo "Unsupported SYMBOL: $SYMBOL"
    exit 100
    ;;
esac

function endpoint() {
  echo "stratum+tcp://$SUBDOMAIN.unmineable.com:$1"
}

POOL_USER="$(unmineable-pool-user "$TARGET_SYMBOL")"

/usr/local/bin/teamredminer \
  -a "$ALGO" \
  -o "$(endpoint 3333)" -u "$POOL_USER" \
  -o "$(endpoint 13333)" -u "$POOL_USER"
