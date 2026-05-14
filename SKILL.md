---
name: skill-created
description: Skill 工厂 — 一键创建标准化 GitHub 公开仓库 + SKILL.md，支持多平台适配（claude/codex/openclaw/hermes 等）
triggers:
  - 创建一个 skill
  - 创建 skill 仓库
  - 新建 skill
  - skill 创建器
  - skill boilerplate
  - 创建多平台 skill
category: devops
author: relunctance
created: 2026-05-08
updated: 2026-05-15
tags:
  - skill
  - skill-created
  - boilerplate
  - github
  - multi-platform
---

# skill-created

> 一键创建标准化 skill GitHub 仓库，包含 SKILL.md + 多平台入口文件
>
> **多平台支持**：自动生成 CLAUDE.md / CODEX.md / AGENTS.md / WORKSPACE.md 等平台入口

## 触发条件

用户说：
- `创建一个 skill`
- `创建 skill 仓库`
- `skill 创建器`
- `创建多平台 skill`
- 或任何需要新建 skill 的场景

## 使用方法

### 第一步：收集信息

向用户收集以下信息（缺一不可）：

| 字段 | 说明 | 示例 |
|------|------|------|
| `name` | skill 名称（英文，kebab-case，**必须以 `-skill` 结尾**） | `ubuntu-chromium-setup-skill` |
| `description` | 一句话描述（中文） | `Ubuntu/WSL Chromium 安装 + 中文字体配置` |
| `triggers` | 触发关键词列表（中文） | `ubuntu 安装 chrome`, `中文乱码` |
| `category` | 分类 | `devops` / `data-science` / `productivity` 等 |
| `author` | 作者 | `relunctance` |
| `platforms` | 支持的平台列表 | `claude` `codex` `openclaw` `hermes` |
| `content` | skill 正文内容 | 用户提供的正文 |

> ⚠️ **命名规范**：所有 skill 名称必须以 `-skill` 结尾，如 `dir-skill`、`honesty-skill`
>
> ⚠️ **平台列表**：必填，至少填一个。有效值：`claude` `codex` `openclaw` `hermes` `cursor` `windsurf`

### 第二步：初始化仓库

```bash
# 创建目录（假设 repos 在 ~/repos/）
mkdir -p ~/repos/{name}
cd ~/repos/{name}
git init
git config user.email "maomao@gql.ai"
git config user.name "maomao"
```

### 第三步：生成 SKILL.md

SKILL.md 格式：

```markdown
---
name: {name}
description: {description}
triggers:
{trigger_lines}
category: {category}
author: {author}
created: {YYYY-MM-DD}
updated: {YYYY-MM-DD}
platforms:
{platform_lines}
tags:
{tag_lines}
---

# {name}

{description}

{content}
```

其中：
- `trigger_lines`：每行一个触发词，前置 4 空格
- `platform_lines`：每行一个平台名，前置 4 空格
- `tag_lines`：每行一个 tag，前置 4 空格

### 第四步：生成平台入口文件

根据 `platforms` 字段，为每个平台生成对应的入口文件：

#### Claude Code → CLAUDE.md

```bash
if [[ " $PLATFORMS " =~ " claude " ]]; then
cat > CLAUDE.md << 'EOF'
# {name}

{description}

## 触发条件

{trigger_lines_plain}

## 快速开始

{content}
EOF
fi
```

#### Codex → CODEX.md

```bash
if [[ " $PLATFORMS " =~ " codex " ]]; then
cat > CODEX.md << 'EOF'
# {name}

{description}

## 触发条件

{trigger_lines_plain}

## 快速开始

{content}
EOF
fi
```

#### OpenClaw/Hermes → AGENTS.md

```bash
if [[ " $PLATFORMS " =~ " openclaw " || " $PLATFORMS " =~ " hermes " ]]; then
cat > AGENTS.md << 'EOF'
# {name}

{description}

## 触发条件

{trigger_lines_plain}

## 快速开始

{content}

## 安装方式

```bash
hermes skills install https://github.com/{author}/{name}
```
EOF
fi
```

#### Cursor → CURSOR.md

```bash
if [[ " $PLATFORMS " =~ " cursor " ]]; then
cat > CURSOR.md << 'EOF'
# {name}

{description}

## 触发条件

{trigger_lines_plain}

## 快速开始

{content}
EOF
fi
```

#### Windsurf → WINDSURF.md

```bash
if [[ " $PLATFORMS " =~ " windsruf " ]]; then
cat > WINDSURF.md << 'EOF'
# {name}

{description}

## 触发条件

{trigger_lines_plain}

## 快速开始

{content}
EOF
fi
```

### 第五步：生成 README.md

```markdown
# {name}

{description}

## 支持平台

{platform_badges}

## 触发条件

{trigger_lines_plain}

## 快速开始

{content}
```

其中 `platform_badges` 根据 platforms 列表生成，例如：
- claude → `![Claude](https://img.shields.io/badge/Claude-Code-blue)`
- codex → `![Codex](https://img.shields.io/badge/Codex-OpenAI-green)`

### 第六步：创建 GitHub 仓库

```bash
# 通过 GitHub API 创建（需要 GH_TOKEN）
curl -s -X POST https://api.github.com/user/repos \
  -H "Authorization: token $TOKEN" \
  -d "{\"name\":\"{name}\",\"description\":\"{description}\",\"private\":false}"
```

### 第七步：推送

```bash
git add .
git commit -m "feat: initial {name} skill"
git branch -M main
git remote add origin https://github.com/{author}/{name}.git
git push -u origin main
```

### 第八步：联动更新 gql-skills

```bash
# 克隆 gql-skills（如已有可跳过）
GQL_SKILLS=~/repos/gql-skills
[ ! -d "$GQL_SKILLS" ] && git clone https://github.com/relunctance/gql-skills.git "$GQL_SKILLS"
cd "$GQL_SKILLS"

# 读取新 skill 信息
NEW_NAME={name}
NEW_DESC={description}
NEW_CATEGORY={category}
AUTHOR={author}

# 构造表格行（按分类追加到对应表格）
ROW="| $NEW_NAME | 🏠内部 | $NEW_DESC | [repo](https://github.com/$AUTHOR/$NEW_NAME) · [SKILL.md](https://github.com/$AUTHOR/$NEW_NAME/blob/main/SKILL.md) |"

# 找到分类位置，在该分类最后一个 | 后插入新行
case "$NEW_CATEGORY" in
  Infrastructure)  TARGET="## 基础设施 Infrastructure" ;;
  DevOps|Devops)   TARGET="## 开发工具 DevOps" ;;
  AI/ML|AI|ML)    TARGET="## AI 与机器学习 AI/ML" ;;
  Productivity)    TARGET="## 效率工具 Productivity" ;;
  *)               TARGET="## 实验性 Experimental" ;;
esac

# 用 awk 在目标 section 下找到表格末尾（下一个 ### 或文件末尾）插入
awk -v target="$TARGET" -v row="$ROW" '
  BEGIN { in_section=0 }
  $0 == target { in_section=1; print; next }
  in_section && /^## / { in_section=0 }
  in_section && /^\| Skill/ { print; next }
  in_section && /^\|---/ { capturing=1; print; next }
  in_section && capturing && /^\|/ { print row; capturing=0 }
  { print }
' README.md > README.md.tmp && mv README.md.tmp README.md

# SKILL.md 同理
awk -v target="$TARGET" -v row="$ROW" '
  BEGIN { in_section=0 }
  $0 == target { in_section=1; print; next }
  in_section && /^## / { in_section=0 }
  in_section && /^\| Skill/ { print; next }
  in_section && /^\|---/ { capturing=1; print; next }
  in_section && capturing && /^\|/ { print row; capturing=0 }
  { print }
' SKILL.md > SKILL.md.tmp && mv SKILL.md.tmp SKILL.md

# 更新 changelog（追加到更新日志表格第一行之后）
TODAY=$(date +%Y-%m-%d)
CHANGELOG_ROW="| $TODAY | 添加 | $NEW_NAME 🏠内部 | 新建 skill |"
sed -i "2a\\$CHANGELOG_ROW" README.md
sed -i "2a\\$CHANGELOG_ROW" SKILL.md

# 提交并推送
git add .
git commit -m "feat: 添加 $NEW_NAME skill"
git push origin main
```

> **注意**：如果新 skill 属于 `Expert Teams` 分类，手动在 README.md 和 SKILL.md 中对应表格追加，awk 脚本默认不处理该分类。

## 完整执行示例

```bash
# 用户提供：
# name=ubuntu-chromium-setup-skill
# description=Ubuntu/WSL Chromium安装+字体配置
# triggers=[ubuntu 安装 chrome, 中文乱码, fontconfig]
# category=devops
# author=relunctance
# platforms=[claude, codex, openclaw, hermes]

NAME=ubuntu-chromium-setup-skill
DESC="Ubuntu/WSL Chromium 安装 + 中文字体配置"
TRIGGERS="ubuntu chrome安装|中文乱码|fontconfig|小红书乱码"
CATEGORY=devops
AUTHOR=relunctance
PLATFORMS="claude codex openclaw hermes"

mkdir -p ~/repos/$NAME
cd ~/repos/$NAME

# 生成 SKILL.md
cat > SKILL.md << 'SKILLEOF'
---
name: {NAME}
description: {DESC}
triggers:
  - ubuntu chrome安装
  - 中文乱码
  - fontconfig
  - 小红书乱码
category: devops
author: {AUTHOR}
created: 2026-05-08
updated: 2026-05-08
platforms:
  - claude
  - codex
  - openclaw
  - hermes
tags:
  - ubuntu
  - chromium
  - fontconfig
  - chinese
---

# {NAME}

{DESC}

## 快速开始

<!-- 用户补充具体使用步骤 -->

## 适用场景

- Ubuntu/WSL 环境安装 Chromium
- 解决中文网页乱码问题
- 配置中文字体支持
SKILLEOF

# 生成各平台入口
for platform in $PLATFORMS; do
  case $platform in
    claude)
      cat > CLAUDE.md << 'EOF'
# {NAME}

{DESC}

## 触发条件

ubuntu chrome安装 | 中文乱码 | fontconfig | 小红书乱码

## 快速开始

<!-- 用户补充 -->
EOF
      ;;
    codex)
      cat > CODEX.md << 'EOF'
# {NAME}

{DESC}

## 触发条件

ubuntu chrome安装 | 中文乱码 | fontconfig | 小红书乱码

## 快速开始

<!-- 用户补充 -->
EOF
      ;;
    openclaw|hermes)
      cat > AGENTS.md << 'EOF'
# {NAME}

{DESC}

## 触发条件

ubuntu chrome安装 | 中文乱码 | fontconfig | 小红书乱码

## 快速开始

<!-- 用户补充 -->

## 安装

```bash
hermes skills install https://github.com/{AUTHOR}/{NAME}
```
EOF
      ;;
  esac
done

# 生成 README.md
cat > README.md << 'EOF'
# {NAME}

{DESC}

## 支持平台

![Claude](https://img.shields.io/badge/Claude-Code-blue)
![Codex](https://img.shields.io/badge/Codex-OpenAI-green)
![OpenClaw](https://img.shields.io/badge/OpenClaw-hermes-orange)

## 触发条件

ubuntu chrome安装 | 中文乱码 | fontconfig | 小红书乱码

## 快速开始

<!-- 用户补充 -->
EOF

git init
git add . && git commit -m "feat: initial {NAME} skill"

# 创建 GitHub 仓库
curl -s -X POST https://api.github.com/user/repos \
  -H "Authorization: token $TOKEN" \
  -d "{\"name\":\"$NAME\",\"description\":\"$DESC\",\"private\":false}"

git remote add origin https://github.com/$AUTHOR/$NAME.git
git push -u origin main
```

## 平台说明

| 平台 | 入口文件 | 说明 |
|------|---------|------|
| Claude Code CLI | `CLAUDE.md` | 进入目录时自动读取 |
| Codex | `CODEX.md` | Codex 专用入口 |
| OpenClaw | `AGENTS.md` | OpenClaw 工作空间根目录 |
| Hermes | `AGENTS.md` | Hermes 工作空间根目录（与 OpenClaw 共用） |
| Cursor | `CURSOR.md` | Cursor AI 专用入口 |
| Windsurf | `WINDSURF.md` | Windsurf AI 专用入口 |

> **注意**：OpenClaw 和 Hermes 共用 `AGENTS.md`，因为两者都支持相同的 Hook API 和工作空间结构。

## 踩坑记录

| 坑 | 说明 | 解决方案 |
|---|---|---|
| GitHub API 创建仓库需要 token | 无 token 报 401 | 使用 `~/.config/gh/hosts.yml` 里的 oauth_token |
| `~/.config/gh/hosts.yml` 有多个 token | 取第一个 oauth_token 字段 | `grep "oauth_token:" file | head -1 | awk '{print $2}'` |
| git push 超时（WSL/国内网络） | 网络不通 GitHub | 配置代理 `git config --global http.proxy http://192.168.1.109:10808` |
| SKILL.md frontmatter 格式错误 | YAML 解析失败 | 确保 `---` 独立一行，platforms 缩进 4 空格 |
| `date` 字段要用 YYYY-MM-DD | 其他格式不标准 | `date +%Y-%m-%d` |
| platform 名称拼写错误 | 有效值之外的值被忽略 | 只能填：claude, codex, openclaw, hermes, cursor, windsurf |

## GitHub Token 获取

```bash
# 方式 1：从 gh hosts 配置读取
TOKEN=$(grep "oauth_token:" ~/.config/gh/hosts.yml | head -1 | awk '{print $2}')

# 方式 2：从 GH_TOKEN 环境变量
TOKEN=$GH_TOKEN

# 验证 token
curl -s -H "Authorization: token $TOKEN" https://api.github.com/user | jq .login
```
