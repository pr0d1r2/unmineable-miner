#!/usr/bin/env bash

case "$1" in
  "")
    echo "Usage:"
    echo
    echo "Native mining:"
    echo "  unmineable-mine xmr"
    echo "  unmineable-mine rvn"
    echo "  unmineable-mine eth"
    echo
    echo "Swap mining:"
    echo "  unmineable-mine xmr btc"
    echo "  unmineable-mine rvn btc"
    echo "  unmineable-mine eth btc"
    exit 100
    ;;
esac

set -e -x

SOURCE_SYMBOL="$(echo "$1" | tr '[a-z]' '[A-Z]')"
case "$SOURCE_SYMBOL" in
  XMR)
    MINER="/usr/local/bin/xmrig-unmineable"
    DEVICE="cpu"
    ;;
  *)
    case "$3" in
      "" | red)
        MINER="/usr/local/bin/teamredminer-unmineable"
        ;;
      lol)
        MINER="/usr/local/bin/lolMiner-unmineable"
        ;;
      *)
        echo "Unsupported explicit miner '$3' ('red' or 'lol' supported)"
        exit 102
        ;;
    esac
    DEVICE="gpu"
    ;;
esac

TARGET_SYMBOL="$(echo "$2" | tr '[a-z]' '[A-Z]')"
case "$TARGET_SYMBOL" in
  "")
    TARGET_SYMBOL="$SOURCE_SYMBOL"
    ;;
esac

TARGET_WALLET="$(cat /etc/miner.env | grep "^WALLET_$TARGET_SYMBOL=" | cut -f 2 -d '"')"

test -n "$TARGET_WALLET" || (echo "Wallet for $TARGET_SYMBOL does not exist. Add WALLET_$TARGET_SYMBOL in /etc/miner.env" ; exit 101)

OUTPUT="/usr/local/bin/unmineable-miner-$DEVICE"

echo "#!/usr/bin/env bash

set -e -x

$MINER $SOURCE_SYMBOL $TARGET_SYMBOL" > "$OUTPUT"

chmod 755 "$OUTPUT"

systemctl enable "unmineable-miner-$DEVICE"
systemctl restart "unmineable-miner-$DEVICE"
