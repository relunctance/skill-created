#!/bin/bash
# skill-created install.sh — 一键安装脚本
# 用法: bash -c "$(curl -fsSL https://raw.githubusercontent.com/relunctance/skill-created/main/install.sh)"

set -e

REPO="relunctance/skill-created"
SKILL_NAME="skill-created"
TARGET_DIR="${HOME}/.hermes/profiles/baijie/skills/${SKILL_NAME}"

echo "[skill-created] 开始安装..."

# 1. 备份已有版本
if [ -d "$TARGET_DIR" ]; then
    echo "[skill-created] 备份已有版本 → ${TARGET_DIR}.bak"
    rm -rf "${TARGET_DIR}.bak"
    cp -r "$TARGET_DIR" "${TARGET_DIR}.bak"
fi

# 2. 创建目标目录
mkdir -p "$(dirname "$TARGET_DIR")"

# 3. 下载并解压（使用 main 分支）
TEMP_DIR=$(mktemp -d)
curl -fsSL "https://github.com/${REPO}/archive/refs/heads/main.tar.gz" -o "${TEMP_DIR}/${SKILL_NAME}.tar.gz"
tar -xzf "${TEMP_DIR}/${SKILL_NAME}.tar.gz" -C "$TEMP_DIR"
rm -rf "$TARGET_DIR"
mv "${TEMP_DIR}/skill-created-main" "$TARGET_DIR"
rm -rf "$TEMP_DIR"

# 4. 验证安装
if [ -f "${TARGET_DIR}/SKILL.md" ]; then
    echo "[skill-created] ✅ 安装成功: $TARGET_DIR"
else
    echo "[skill-created] ❌ 安装失败: SKILL.md 未找到"
    exit 1
fi

# 5. 验证 hermes 可加载
if command -v hermes &>/dev/null; then
    echo "[skill-created] 验证 hermes skills list..."
    hermes skills list 2>/dev/null | grep -q "$SKILL_NAME" && \
        echo "[skill-created] ✅ hermes 已识别 $SKILL_NAME" || \
        echo "[skill-created] ⚠️ hermes 未识别（需重启 hermes 或手动添加）"
else
    echo "[skill-created] ⚠️ hermes CLI 未找到，跳过 hermes 验证"
fi

echo "[skill-created] 安装完成！"
echo "  路径: $TARGET_DIR"
echo "  用法: hermes skills run skill-created"
