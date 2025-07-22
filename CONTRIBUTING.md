# Contributing to Anchor-Docker

このプロジェクトへの貢献を歓迎します！以下のガイドラインに従ってください。

## 行動規範

このプロジェクトに参加するすべての人は、お互いを尊重し、建設的な環境を維持することが期待されます。

## 貢献の方法

### バグ報告

バグを見つけた場合は、以下の情報を含めてIssueを作成してください：

1. **環境情報**
   - ホストOS（例：macOS 14.0, Ubuntu 22.04）
   - アーキテクチャ（例：Apple M2, Intel x86_64）
   - Docker Desktopのバージョン
   - Docker Composeのバージョン

2. **再現手順**
   - 実行したコマンドの順序
   - 期待した結果
   - 実際の結果

3. **エラーログ**
   ```bash
   docker-compose logs > error.log
   ```

### 機能リクエスト

新機能の提案は大歓迎です。Issueを作成して以下を記載してください：

- 提案する機能の説明
- なぜその機能が必要か
- 可能であれば実装のアイデア

### プルリクエスト

1. **フォークとブランチ作成**
   ```bash
   git clone https://github.com/yourusername/Anchor-Docker.git
   cd Anchor-Docker
   git checkout -b feature/your-feature-name
   ```

2. **変更のガイドライン**
   - Dockerfileの変更は最小限に
   - 新しい依存関係を追加する場合は理由を明記
   - READMEを更新する

3. **テスト**
   ```bash
   # クリーンビルドでテスト
   docker-compose down -v
   docker-compose build --no-cache
   docker-compose up -d
   docker-compose exec anchor-dev bash -c "anchor --version"
   ```

4. **コミットメッセージ**
   ```
   <type>: <subject>

   <body>

   <footer>
   ```

   Type:
   - `feat`: 新機能
   - `fix`: バグ修正
   - `docs`: ドキュメントのみの変更
   - `chore`: ビルドプロセスやツールの変更
   - `perf`: パフォーマンス改善

   例：
   ```
   feat: Add support for Anchor 0.32.0

   - Update Anchor CLI installation to v0.32.0
   - Update README with new version info
   - Test compatibility with latest Solana SDK
   ```

## 開発環境のセットアップ

```bash
# リポジトリのクローン
git clone https://github.com/shoya-sue/Anchor-Docker.git
cd Anchor-Docker

# ビルドとテスト
docker-compose build
docker-compose up -d
```

## コードスタイル

### Dockerfile
- 各RUNコマンドは論理的にグループ化
- キャッシュを最大限活用するため、変更頻度の低いものを上に配置
- 不要なファイルは削除してイメージサイズを削減

### ドキュメント
- Markdown形式
- 日本語と英語の両方を考慮
- コードブロックには言語を指定

## リリースプロセス

1. バージョンタグの作成
   ```bash
   git tag -a v1.0.0 -m "Release version 1.0.0"
   git push origin v1.0.0
   ```

2. リリースノートに含める内容
   - 新機能
   - バグ修正
   - 破壊的変更
   - アップグレード手順

## 質問とサポート

- **一般的な質問**: Discussionsを使用
- **バグ報告**: Issuesを使用
- **セキュリティ問題**: メンテナーに直接連絡

## ライセンス

貢献されたコードは、プロジェクトと同じライセンス（MIT）の下でリリースされます。

## 謝辞

すべての貢献者に感謝します！