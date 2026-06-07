# skill-created 完整创建流程

> 包含第四步~第九步的完整 bash 脚本和 README 模板。

---

## 第四步：生成平台入口文件

```bash
# 默认全平台，也可指定 PLATFORMS="claude codex openclaw"
PLATFORMS=${PLATFORMS:-"claude codex openclaw hermes cursor windsurf"}

for platform in $PLATFORMS; do
  case $platform in
    claude)
      cat > CLAUDE.md << 'EOF'
# {name}

{description}

## 触发条件

触发词1 / 触发词2 / 触发词3

## 快速开始

<!-- 用户补充 -->
EOF
      ;;
    codex)
      cat > CODEX.md << 'EOF'
# {name}

{description}

## 触发条件

触发词1 / 触发词2 / 触发词3

## 快速开始

<!-- 用户补充 -->
EOF
      ;;
    openclaw|hermes)
      cat > AGENTS.md << 'EOF'
# {name}

{description}

## 触发条件

触发词1 / 触发词2 / 触发词3

## 快速开始

<!-- 用户补充 -->

## 安装

hermes skills install https://github.com/{author}/{name}
EOF
      ;;
    cursor)
      cat > CURSOR.md << 'EOF'
# {name}

{description}

## 触发条件

触发词1 / 触发词2 / 触发词3

## 快速开始

<!-- 用户补充 -->
EOF
      ;;
    windsurf)
      cat > WINDSURF.md << 'EOF'
# {name}

{description}

## 触发条件

触发词1 / 触发词2 / 触发词3

## 快速开始

<!-- 用户补充 -->
EOF
      ;;
  esac
done
```

---

## 第四步半：生成 README.md 和 README_zh.md

> 🔴 **强制步骤**：每个 skill 必须同时有 README.md（英文）和 README_zh.md（中文），顶部互相引用

```bash
# README.md（英文）
cat > README.md << 'EOFREADME'
---
search: false
---

<div align="center">

# {emoji} {name}

**[English](README.md) · [中文](README_zh.md)**

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![version](https://img.shields.io/badge/version-1.0.0-green.svg)](#)
[![platforms](https://img.shields.io/badge/platforms-Hermes%20Agent-4B8FBA.svg)](#)
[![category](https://img.shields.io/badge/category-{category}-blue.svg)](#)
[![Python](https://img.shields.io/badge/Python-3.8+-3776AB.svg)](https://www.python.org/)

*{description}*

</div>

## What It Does

<!-- LLM 补充 -->

## Features

<!-- LLM 补充 -->

## Quick Start

```bash
# 安装
hermes skills install https://github.com/{author}/{name}

# 使用
hermes skills run {name}
```

## File Structure

```
{name}/
├── SKILL.md           # Main entry
├── README.md          # English
├── README_zh.md       # Chinese
├── scripts/           # (if applicable)
└── learns/           # Self-evolution
```

## Installation Verification

- [ ] Skill loaded successfully
- [ ] Trigger word works
- [ ] Basic function verified

## Contributing

Contributions welcome! Please submit Issues and PRs.

## License

MIT
EOFREADME

# README_zh.md（中文）
cat > README_zh.md << 'EOFZHSELF'
---
search: false
---

<div align="center">

# {emoji} {name}

**[English](README.md) · [中文](README_zh.md)**

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![version](https://img.shields.io/badge/version-1.0.0-green.svg)](#)
[![platforms](https://img.shields.io/badge/platforms-Hermes%20Agent-4B8FBA.svg)](#)
[![category](https://img.shields.io/badge/category-{category}-blue.svg)](#)
[![Python](https://img.shields.io/badge/Python-3.8+-3776AB.svg)](https://www.python.org/)

*{description}*

</div>

## 核心能力

<!-- LLM 补充 -->

## 快速开始

```bash
# 安装
hermes skills install https://github.com/{author}/{name}

# 使用
hermes skills run {name}
```

## 文件结构

```
{name}/
├── SKILL.md           # 主入口
├── README.md          # English
├── README_zh.md       # 中文
├── scripts/           # （如有代码）
└── learns/           # 自我进化
```

## 安装后验证

- [ ] Skill 加载成功
- [ ] 触发词生效
- [ ] 基础功能验证通过

## 欢迎贡献

欢迎提交 Issue 和 PR！

## 许可证

MIT
EOFZHSELF
```

> ⚠️ **中英文 README 强制规则**：
> - 顶部第一行必须互相引用：`**[English](README.md) · [中文](README_zh.md)**`
> - 两个文件都必须有 `---` frontmatter（`search: false`）
> - 生成后立即调用 readme-skill 美化，不要手动编辑

---

## 第五步：README 美化（中英文）

> 🔴 **强制步骤**：必须对 README.md 和 README_zh.md 都调用 readme-skill 美化

```bash
# 检查 readme-skill 是否安装，没有则自动安装
if ! hermes skills list 2>/dev/null | grep -q "readme-skill"; then
  echo "readme-skill not found, installing..."
  hermes skills install https://github.com/relunctance/readme-skill
fi

# 加载 readme-skill 并美化 README.md
hermes skills run readme-skill --path ./README.md

# 加载 readme-skill 并美化 README_zh.md
hermes skills run readme-skill --path ./README_zh.md
```

> ⚠️ **readme-skill 美化标准**：
> - 必须包含：License、Version、Platforms、Category 徽章
> - 必须包含：中英文互相引用（顶部第一行）
> - 必须包含：触发条件、安装、核心功能章节
> - 必须包含：安装后验证 checklist（`- [ ]` 格式）
> - 禁止在 README 中写"Known Pitfalls"（放 learns/ 或 CONTRIBUTING.md）

---

## 第六步：提交

```bash
git add .
git commit -m "feat: initial {name} skill"
```

> 🔴 **CHECKPOINT · 🛑 STOP**：创建 GitHub 仓库前**必须停止**，等待用户确认后再继续。

---

## 第七步：创建 GitHub 仓库

```bash
# About 信息 = description 字段
gh repo create {name} \
  --description "{description}" \
  --public \
  --source=. \
  --push
```

> ⚠️ **About 信息（description）必须填写**，否则 GitHub 显示"No description"影响可发现性。

---

## 第八步：推送

```bash
git branch -M main
git remote add origin https://github.com/{author}/{name}.git
git push -u origin main
```

---

## 第九步：联动更新 gql-skills

> 🔴 **CHECKPOINT · 🛑 STOP**：更新 gql-skills 前**必须停止**，等待用户确认后再继续。

```bash
GQL_SKILLS=~/repos/gql-skills
[ ! -d "$GQL_SKILLS" ] && git clone https://github.com/relunctance/gql-skills.git "$GQL_SKILLS"
cd "$GQL_SKILLS"

# 添加到对应分类表格
# ...
git add .
git commit -m "feat: 添加 {name} skill"
git push origin main
```
