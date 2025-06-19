# Anchor-Docker

## Docker Image Build

```bash
docker-compose build
```

## Docker Container Run

```bash
docker-compose up -d
```

## Enter Docker Container

```bash
docker-compose exec anchor-dev bash
```

## Version

```bash
# バージョン確認
solana --version
anchor --version
node --version
yarn --version

# 新しいAnchorプロジェクトを作成してテスト
anchor init test-project
cd test-project
anchor test
```

## Blue Shift 学習プログラム環境

https://learn.blueshift.gg/en

### Blue Shift Anchor Vault

https://learn.blueshift.gg/en/challenges/anchor-vault

```bash
anchor init blueshift_anchor_vault
```

### Blue Shift Anchor Escrow

https://learn.blueshift.gg/en/challenges/anchor-escrow

```bash
anchor init blueshift_anchor_escrow
cd blueshift_anchor_escrow
cargo add anchor-lang --features init-if-needed
cargo add anchor-spl
```

### Blue Shift Rust Pinocchio

https://learn.blueshift.gg/en/challenges/pinocchio-vault

```bash
cargo new --lib blueshift_pinocchio-vault
cd blueshift_pinocchio-vault
cargo add pinocchio
cargo add pinocchio-system
cargo add pinocchio-token
```
