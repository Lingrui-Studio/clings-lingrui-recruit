#!/bin/sh
# Clings 一键环境安装脚本（候选人使用）
set -eu

command -v uv >/dev/null 2>&1 || {
    echo "未找到 uv，正在安装。.."
    UV_INSTALL_DIR="${UV_INSTALL_DIR:-$HOME/.local/bin}"
    export UV_INSTALL_DIR

    if command -v curl >/dev/null 2>&1; then
        curl -LsSf https://astral.sh/uv/install.sh | sh
    elif command -v wget >/dev/null 2>&1; then
        wget -qO- https://astral.sh/uv/install.sh | sh
    else
        echo "安装 uv 需要 curl 或 wget" >&2
        exit 1
    fi

    PATH="$UV_INSTALL_DIR:$PATH"
    export PATH
}

command -v uv >/dev/null 2>&1 || {
    echo "uv 安装失败，请检查网络连接后重试" >&2
    exit 1
}

# 题库默认安装官方 clings；如有私有镜像，修改这里的 URL 即可
uv tool install --force \
    "git+https://github.com/Lingrui-Studio/clings.git"

clings doctor
