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
    ALGO="ETHASH"
    SUBDOMAIN="ethash"
    ;;
  ETC)
    ALGO="ETCHASH"
    SUBDOMAIN="etchash"
    ;;
  RVN)
    ALGO="KAWPOW"
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

/usr/local/bin/lolMiner \
  --algo "$ALGO" \
  --pool "$(endpoint 3333)" -u "$POOL_USER" \
  --pool "$(endpoint 13333)" -u "$POOL_USER"
