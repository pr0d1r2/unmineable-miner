#!/usr/bin/env bash

set -e -x

cd "$(dirname "$0")"

PROJECT="$(pwd -P)"

source .config.sh
TMP="$(mktemp -d)"

command -v parallel || apt-get -y -q install parallel

find "$PROJECT/commands" -type f -name "*.sh" | parallel "cp {} /usr/local/bin/{/.} && chmod 755 /usr/local/bin/{/.}"
find "$PROJECT/systemd" -type f -name "*.service" | parallel "cp {} /etc/systemd/system/{/}"

#
# CPU mining
#
apt-get -y -q install git build-essential cmake libuv1-dev libssl-dev libhwloc-dev
test -d "$TARGET_SRC/xmrig" || git clone https://github.com/xmrig/xmrig.git "$TARGET_SRC/xmrig"
cd "$TARGET_SRC/xmrig"
git pull
test -d "$TARGET_SRC/xmrig/build" || mkdir "$TARGET_SRC/xmrig/build"
cd "$TARGET_SRC/xmrig/scripts"
bash build_deps.sh
cd "$TARGET_SRC/xmrig/build"
cmake .. -DXMRIG_DEPS=scripts/deps
make -j "$(nproc)"
cp "$TARGET_SRC/xmrig/scripts/enable_1gb_pages.sh" "$PREFIX/sbin/enable_1gb_pages"
chmod 700 "$PREFIX/sbin/enable_1gb_pages"
mv "$TARGET_SRC/xmrig/build/xmrig" "$PREFIX/bin/xmrig"

#
# GPU mining
#
## teamredminer
if [ ! -d "$TARGET_MINERS/teamredminer-v$VERSION_TEAMREDMINER-linux" ]; then
  test -d "$TARGET_MINERS" || mkdir -p "$TARGET_MINERS"
  wget "https://github.com/todxx/teamredminer/releases/download/v$VERSION_TEAMREDMINER/teamredminer-v$VERSION_TEAMREDMINER-linux.tgz" -O "$TMP/teamredminer-v$VERSION_TEAMREDMINER-linux.tgz"
  cd "$TARGET_MINERS"
  tar xvfz "$TMP/teamredminer-v$VERSION_TEAMREDMINER-linux.tgz"
fi
ln -sf "$TARGET_MINERS/teamredminer-v$VERSION_TEAMREDMINER-linux/teamredminer" "$PREFIX/bin/teamredminer"
## lolMiner
if [ ! -d "$TARGET_MINERS/lolMiner/$VERSION_LOLMINER" ]; then
  wget "https://github.com/Lolliedieb/lolMiner-releases/releases/download/$VERSION_LOLMINER/lolMiner_v${VERSION_LOLMINER}_Lin64.tar.gz" -O "$TMP/lolMiner_v${VERSION_LOLMINER}_Lin64.tar.gz"
  test -d "$TARGET_MINERS/lolMiner" || mkdir -p "$TARGET_MINERS/lolMiner"
  cd "$TARGET_MINERS/lolMiner"
  tar xvfz "$TMP/lolMiner_v${VERSION_LOLMINER}_Lin64.tar.gz"
fi
ln -sf "$TARGET_MINERS/lolMiner/$VERSION_LOLMINER/lolMiner" "$PREFIX/bin/lolMiner"

test -f /etc/miner.env || cp "$PROJECT/config/miner.env" /etc/miner.env

# cache cleanup
rm -rf "$TMP"

echo "Setup your WORKER_NAME and add your wallets in /etc/miner.env now..."
