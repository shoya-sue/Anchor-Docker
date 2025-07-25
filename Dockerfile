# Solana Anchor開発環境のDockerfile
FROM --platform=linux/amd64 ubuntu:22.04

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
    && rm -rf /var/lib/apt/lists/*

# Node.js 20をインストール
RUN curl -fsSL https://deb.nodesource.com/setup_20.x | bash - && \
    apt-get install -y nodejs && \
    rm -rf /var/lib/apt/lists/*

# 作業ディレクトリを設定
WORKDIR /workspace

# Rustをインストール
RUN curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
ENV PATH="/root/.cargo/bin:${PATH}"

# Solana CLIをインストール
RUN sh -c "$(curl -sSfL https://release.anza.xyz/stable/install)"
ENV PATH="/root/.local/share/solana/install/active_release/bin:${PATH}"

# Yarnをインストール
RUN npm install -g yarn

# AVM , Anchor CLIをインストール
# RUN cargo install --git https://github.com/coral-xyz/anchor avm --locked --force
# RUN avm install latest
# RUN avm use latest

# Anchor install without AVM
RUN cargo install --git https://github.com/coral-xyz/anchor --tag v0.31.1 anchor-cli

# Version Check
RUN cargo --version
RUN solana --version
RUN anchor --version
RUN node --version
RUN yarn --version

# Solanaを devnet に設定
RUN solana config set --url https://api.devnet.solana.com

# 作業ディレクトリのファイルをコンテナにコピー
COPY . .

# ポート8899を公開（Solana test validator用）
EXPOSE 8899

# デフォルトコマンド
CMD ["/bin/bash"]