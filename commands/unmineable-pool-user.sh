#!/usr/bin/env bash

source /etc/miner.env

SYMBOL="$(echo "$1" | tr '[a-z]' '[A-Z]')"

WALLET="$(cat /etc/miner.env | grep "^WALLET_$SYMBOL=" | cut -f 2 -d '"')"
WORKER_NAME="$(cat /etc/miner.env | grep "^WORKER_NAME=" | cut -f 2 -d '"')"

test -n "$WALLET"
test -n "$WORKER_NAME"

echo $SYMBOL:$WALLET.$WORKER_NAME
