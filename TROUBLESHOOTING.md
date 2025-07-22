# トラブルシューティングガイド

このドキュメントでは、Anchor-Docker環境で発生する可能性のある問題と解決方法を記載しています。

## 目次

- [ビルド関連の問題](#ビルド関連の問題)
- [実行時の問題](#実行時の問題)
- [パフォーマンスの問題](#パフォーマンスの問題)
- [環境固有の問題](#環境固有の問題)

## ビルド関連の問題

### 問題: Solana CLIのインストールで404エラーが発生する

**症状:**
```
curl: (22) The requested URL returned error: 404
agave-install-init: command failed: downloader https://release.anza.xyz/stable/agave-install-init-aarch64-unknown-linux-gnu
```

**原因:**
ARM64アーキテクチャ用のバイナリが存在しない。

**解決方法:**
Dockerfileに`--platform=linux/amd64`を指定してx86_64プラットフォームを使用する：

```dockerfile
FROM --platform=linux/amd64 ubuntu:22.04
```

### 問題: Node.jsのバージョンが古い

**症状:**
```
error @coral-xyz/anchor@0.31.1: The engine "node" is incompatible with this module. Expected version ">=17". Got "12.22.9"
```

**原因:**
UbuntuのデフォルトリポジトリのNode.jsが古い。

**解決方法:**
DockerfileでNode.js 20.xをインストール：

```dockerfile
# Node.js 20をインストール
RUN curl -fsSL https://deb.nodesource.com/setup_20.x | bash - && \
    apt-get install -y nodejs && \
    rm -rf /var/lib/apt/lists/*
```

## 実行時の問題

### 問題: Solanaキーペアが存在しない

**症状:**
```
Error: Unable to read keypair file (/root/.config/solana/id.json)
```

**解決方法:**
```bash
# コンテナ内で実行
solana-keygen new --no-passphrase --force
```

### 問題: anchor testでtest-validatorが起動しない

**症状:**
```
Unable to get latest blockhash. Test validator does not look started.
```

**原因:**
Docker環境（特にx86_64エミュレーション）でtest-validatorが正常に動作しない場合がある。

**回避策:**
1. ビルドのみ実行する：
   ```bash
   anchor build
   ```

2. 外部のdevnetを使用する：
   ```bash
   solana config set --url https://api.devnet.solana.com
   anchor deploy
   ```

3. ホストマシンでtest-validatorを実行し、コンテナから接続する

## パフォーマンスの問題

### 問題: Apple SiliconでDockerビルドが遅い

**症状:**
- `docker-compose build`が10分以上かかる
- Rust/Cargoのビルドが異常に遅い

**原因:**
ARM64マシンでx86_64エミュレーションを使用しているため。

**緩和策:**
1. ビルドキャッシュを活用する
2. `.dockerignore`を適切に設定してコンテキストサイズを減らす
3. マルチステージビルドを使用する

**将来的な解決策:**
Solana/AnchorがARM64 Linuxバイナリを提供するのを待つ。

## 環境固有の問題

### 問題: docker-compose.ymlのversionフィールドの警告

**症状:**
```
level=warning msg="/path/to/docker-compose.yml: the attribute `version` is obsolete, it will be ignored, please remove it to avoid potential confusion"
```

**解決方法:**
`docker-compose.yml`から`version: '3.8'`行を削除する。この警告は無視しても問題ない。

### 問題: メモリ不足

**症状:**
- ビルド中にプロセスが強制終了される
- `Killed`メッセージが表示される

**解決方法:**
1. Docker Desktopのメモリ割り当てを増やす
   - Settings > Resources > Memory を最低8GBに設定

2. 不要なコンテナとイメージを削除：
   ```bash
   docker system prune -a
   ```

## デバッグ方法

### ログの確認

```bash
# Dockerコンテナのログ
docker-compose logs -f anchor-dev

# ビルドログの詳細表示
docker-compose build --no-cache --progress=plain

# コンテナ内のプロセス確認
docker-compose exec anchor-dev ps aux
```

### コンテナ内での調査

```bash
# インタラクティブシェルで調査
docker-compose exec anchor-dev bash

# インストール済みパッケージの確認
dpkg -l | grep solana
cargo --version
rustc --version
```

## 既知の制限事項

1. **test-validator**: Docker環境では完全に動作しない場合がある
2. **パフォーマンス**: Apple Siliconでのx86_64エミュレーションは遅い
3. **ディスク使用量**: フルビルドで約4.5GBのイメージサイズ

## サポート

問題が解決しない場合は、以下の情報を含めてIssueを作成してください：

1. ホストOSとアーキテクチャ（例：macOS 14.0, Apple M2）
2. Docker Desktopのバージョン
3. エラーメッセージの全文
4. 実行したコマンドの順序
5. `docker-compose logs`の出力

## 参考リンク

- [Solana Documentation](https://docs.solana.com/)
- [Anchor Documentation](https://www.anchor-lang.com/)
- [Docker Documentation](https://docs.docker.com/)
- [Anza Releases](https://github.com/anza-xyz/agave/releases)