# unmineable-miner

Layer using other miners to mine via [unmineable](https://www.unmineable.com)

## Why?

To simplify the process of configuring 66+ wallets and switching between them.
Unmineable allows you to mine any coin using XMR (rx), ETH (ethash), ETC (etchash) or RVN (kawpow).

## Install

Tested on Ubuntu 20.04 server.

```bash
git clone git@github.com/pr0d1r2/unmineable-miner
cd unmineable-miner
bash install.sh
```

## Configuration

Fill in your wallets and unique WORKER_NAME in `/etc/miner.env`.

## Mining:

It will generate script and run it on systemd service.

### Natively

When you want to get mineable coins:

#### Monero

```bash
unmineable-mine xmr
```

#### Ethereum

```bash
unmineable-mine eth
```

#### Ethereum Clasic

```bash
unmineable-mine etc
```

#### Ravencoin (natively)

```bash
unmineable-mine rvn
```

### Cross-mining

When you want to get "unmineable" coins:

#### Bitcoin using Monero

```bash
unmineable-mine xmr btc
```

#### Bitcoin using Ethereum

```bash
unmineable-mine eth btc
```

#### Bitcoin using Ethereum Classic

```bash
unmineable-mine etc btc
```

#### Bitcoin using Ravencoin

```bash
unmineable-mine rvn btc
```

### NVIDIA support

By default teamredminer is used for best AMD support. To use NVIDIA do the following:

#### Bitcoin using Ethereum via lolMiner

```bash
unmineable-mine eth btc lol
```

#### Bitcoin using Ethereum Classic via lolMiner

```bash
unmineable-mine etc btc lol
```

#### Bitcoin using Ravencoin via lolMiner

```bash
unmineable-mine rvn btc lol
```

### Check mining status

We have handy shortcuts:

#### CPU

```bash
wcpu
```

#### GPU

```bash
wgpu
```

## Development

Requires ruby. For TDD-like experience while making changes use:

```bash
bundle install
bundle exec guard
```

It will run docker build each time changes are saved.

## Related

There is [unmineable-workers](https://github.com/pr0d1r2/unmineable-workers).

## Support

Consider using my [unmineable referral link](https://www.unmineable.com/?ref=3792-egij) (0.75% pool fee instead of 1% for you as well) or [donate](https://github.com/pr0d1r2/donate) or both.

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
