# Anchor-Docker

Solana Anchor開発環境のDockerコンテナです。

## 前提条件

- Docker Desktop
- Docker Compose
- 8GB以上の空きディスク容量

## クイックスタート

### 1. Docker Image Build

```bash
docker-compose build
```

> **Note**: Apple Silicon (M1/M2)の場合、x86_64エミュレーションで動作するため、ビルドに時間がかかります（約10-15分）。

### 2. Docker Container Run

```bash
docker-compose up -d
```

### 3. Enter Docker Container

```bash
docker-compose exec anchor-dev bash
```

### 4. Solanaキーペアの生成（初回のみ）

```bash
# コンテナ内で実行
solana-keygen new --no-passphrase --force
```

## インストール済みツールのバージョン

| ツール | バージョン |
|--------|-----------|
| Solana CLI | 2.2.20 |
| Anchor CLI | 0.31.1 |
| Node.js | 20.x |
| Yarn | 1.22.22 |
| Rust | 1.88.0 |

## 動作確認

```bash
# コンテナ内で実行
# 新しいAnchorプロジェクトを作成
anchor init test-project
cd test-project

# ビルドのみ実行（推奨）
anchor build

# テストを実行（注意：Docker環境ではtest-validatorが正常に起動しない場合があります）
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

### Blue Shift Rust Pinocchio Vault

https://learn.blueshift.gg/en/challenges/pinocchio-vault

```bash
cargo new blueshift_pinocchio_vault --lib --edition 2021
cd blueshift_pinocchio_vault
cargo add pinocchio pinocchio-system
```

### Blue Shift Rust Pinocchio Escrow

https://learn.blueshift.gg/en/challenges/pinocchio-escrow

```bash
cargo new blueshift_pinocchio_escrow --lib --edition 2021
cd blueshift_pinocchio_escrow
cargo add pinocchio pinocchio-system pinocchio-token pinocchio-associated-token-account
```

## Docker管理コマンド

```bash
# コンテナの停止
docker-compose down

# コンテナとボリュームの削除（データもリセット）
docker-compose down -v

# ログの確認
docker-compose logs -f anchor-dev

# コンテナの再起動
docker-compose restart
```

## トラブルシューティング

詳細は[TROUBLESHOOTING.md](./TROUBLESHOOTING.md)を参照してください。
