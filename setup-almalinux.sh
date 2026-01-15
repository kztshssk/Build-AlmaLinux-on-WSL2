#!/bin/bash
set -e

echo "AlmaLinux初期設定を開始します..."

# システムをアップデート
dnf update -y


# 基本パッケージをインストール
dnf install -y \
    curl \
    wget \
    git \
    vim \
    nano \
    sudo \
    systemd

echo "初期設定が完了しました！"
