# Solana Anchor開発環境のDockerfile
FROM ubuntu:22.04

# 非インタラクティブモードに設定
ENV DEBIAN_FRONTEND=noninteractive

# 必要なシステム依存関係をインストール
RUN apt-get update && apt-get install -y \
    curl \
    build-essential \
    pkg-config \
    libudev-dev \
    libssl-dev \
    git \
    nodejs \
    npm \
    && rm -rf /var/lib/apt/lists/*

# 作業ディレクトリを設定
WORKDIR /workspace

# Rustをインストール
RUN curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
ENV PATH="/root/.cargo/bin:${PATH}"

# Solana CLIをインストール
RUN sh -c "$(curl -sSfL https://release.solana.com/stable/install)"
ENV PATH="/root/.local/share/solana/install/active_release/bin:${PATH}"

# Yarnをインストール
RUN npm install -g yarn

# AVMとAnchor CLIをインストール
RUN cargo install --git https://github.com/coral-xyz/anchor avm --locked --force
RUN avm install latest
RUN avm use latest

# Solanaを devnet に設定
RUN solana config set --url https://api.devnet.solana.com

# 作業ディレクトリのファイルをコンテナにコピー
COPY . .

# ポート8899を公開（Solana test validator用）
EXPOSE 8899

# デフォルトコマンド
CMD ["/bin/bash"]