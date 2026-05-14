---
name: skill-created
description: Skill 工厂 — 一键创建标准化 GitHub 公开仓库 + SKILL.md，零成本适配全平台（claude/codex/openclaw/hermes/cursor/windsurf）
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

> 一键创建标准化 skill GitHub 仓库
>
> **零成本全平台适配** — 不填 platforms 时，自动生成所有平台入口文件（CLAUDE.md / CODEX.md / AGENTS.md / CURSOR.md / WINDSURF.md）和平台插件元数据（`.claude-plugin/` / `.codex-plugin/` / `.cursor-plugin/` / `.opencode/`）

## 触发条件

用户说：
- `创建一个 skill`
- `创建 skill 仓库`
- `新建 skill`
- `skill 创建器`
- `skill boilerplate`
- 或任何需要新建 skill 的场景

## 使用方法

### 第一步：收集信息

| 字段 | 说明 | 必填 | 示例 |
|------|------|------|------|
| `name` | skill 名称（kebab-case，**必须以 `-skill` 结尾**） | ✅ | `dir-skill` |
| `description` | 一句话描述（中文） | ✅ | `为项目添加标准目录结构` |
| `triggers` | 触发关键词（中文） | ✅ | `项目目录结构`, `初始化项目` |
| `category` | 分类 | ✅ | `devops` / `data-science` 等 |
| `author` | GitHub 用户名 | ✅ | `relunctance` |
| `platforms` | 目标平台（留空=全部） | ❌ | `claude codex openclaw` |

> ⚠️ **命名规范**：所有 skill 必须以 `-skill` 结尾
>
> **platforms 默认值**：留空则生成全部平台（claude / codex / openclaw / hermes / cursor / windsurf）

### 第二步：初始化仓库

```bash
mkdir -p ~/repos/{name}
cd ~/repos/{name}
git init
git config user.email "maomao@gql.ai"
git config user.name "maomao"
```

### 第三步：生成 SKILL.md（所有平台共用）

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
platforms: all
tags:
{tag_lines}
---

# {name}

{description}

{content}
```

### 第四步：生成平台入口文件

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
{trigger_lines_plain}

## 快速开始

{content}
EOF
      ;;
    codex)
      cat > CODEX.md << 'EOF'
# {name}

{description}

## 触发条件
{trigger_lines_plain}

## 快速开始

{content}
EOF
      ;;
    openclaw|hermes)
      cat > AGENTS.md << 'EOF'
# {name}

{description}

## 触发条件
{trigger_lines_plain}

## 快速开始

{content}

## 安装

hermes skills install https://github.com/{author}/{name}
EOF
      ;;
    cursor)
      cat > CURSOR.md << 'EOF'
# {name}

{description}

## 触发条件
{trigger_lines_plain}

## 快速开始

{content}
EOF
      ;;
    windsurf)
      cat > WINDSURF.md << 'EOF'
# {name}

{description}

## 触发条件
{trigger_lines_plain}

## 快速开始

{content}
EOF
      ;;
  esac
done
```

### 第五步：生成平台插件目录（可选）

```bash
# .claude-plugin/plugin.json
mkdir -p .claude-plugin
cat > .claude-plugin/plugin.json << 'EOF'
{
  "name": "{name}",
  "version": "1.0.0",
  "description": "{description}",
  "author": "{author}",
  "homepage": "https://github.com/{author}/{name}",
  "repository": "https://github.com/{author}/{name}",
  "license": "MIT",
  "skills": "./"
}
EOF

# .codex-plugin/plugin.json
mkdir -p .codex-plugin
cat > .codex-plugin/plugin.json << 'EOF'
{
  "name": "{name}",
  "version": "1.0.0",
  "description": "{description}",
  "author": "{author}",
  "homepage": "https://github.com/{author}/{name}",
  "repository": "https://github.com/{author}/{name}",
  "license": "MIT",
  "skills": "./"
}
EOF

# .opencode/plugins/{name}.json
mkdir -p .opencode/plugins
cat > .opencode/plugins/{name}.json << 'EOF'
{
  "name": "{name}",
  "version": "1.0.0",
  "description": "{description}",
  "author": "{author}",
  "homepage": "https://github.com/{author}/{name}",
  "repository": "https://github.com/{author}/{name}",
  "license": "MIT",
  "skills": "./"
}
EOF
```

### 第六步：生成 README.md

```markdown
# {name}

{description}

## 支持平台

![Claude](https://img.shields.io/badge/Claude-Code-blue)
![Codex](https://img.shields.io/badge/Codex-OpenAI-green)
![OpenClaw](https://img.shields.io/badge/OpenClaw-Hermes-orange)
![Cursor](https://img.shields.io/badge/Cursor-AI-purple)
![Windsurf](https://img.shields.io/badge/Windsurf-AI-red)

## 触发条件

{trigger_lines_plain}

## 快速开始

{content}

## 安装

hermes skills install https://github.com/{author}/{name}
```

### 第七步：创建 GitHub 仓库

```bash
curl -s -X POST https://api.github.com/user/repos \
  -H "Authorization: token $TOKEN" \
  -d "{\"name\":\"{name}\",\"description\":\"{description}\",\"private\":false}"
```

### 第八步：推送

```bash
git add .
git commit -m "feat: initial {name} skill"
git branch -M main
git remote add origin https://github.com/{author}/{name}.git
git push -u origin main
```

### 第九步：联动更新 gql-skills

```bash
GQL_SKILLS=~/repos/gql-skills
[ ! -d "$GQL_SKILLS" ] && git clone https://github.com/relunctance/gql-skills.git "$GQL_SKILLS"
cd "$GQL_SKILLS"

NEW_NAME={name}
NEW_DESC={description}
NEW_CATEGORY={category}
AUTHOR={author}

ROW="| $NEW_NAME | 🏠内部 | $NEW_DESC | [repo](https://github.com/$AUTHOR/$NEW_NAME) · [SKILL.md](https://github.com/$AUTHOR/$NEW_NAME/blob/main/SKILL.md) |"

case "$NEW_CATEGORY" in
  Infrastructure)  TARGET="## 基础设施 Infrastructure" ;;
  DevOps|Devops)   TARGET="## 开发工具 DevOps" ;;
  AI/ML|AI|ML)    TARGET="## AI 与机器学习 AI/ML" ;;
  Productivity)    TARGET="## 效率工具 Productivity" ;;
  *)               TARGET="## 实验性 Experimental" ;;
esac

awk -v target="$TARGET" -v row="$ROW" '
  BEGIN { in_section=0 }
  $0 == target { in_section=1; print; next }
  in_section && /^## / { in_section=0 }
  in_section && /^\| Skill/ { print; next }
  in_section && /^\|---/ { capturing=1; print; next }
  in_section && capturing && /^\|/ { print row; capturing=0 }
  { print }
' README.md > README.md.tmp && mv README.md.tmp README.md

awk -v target="$TARGET" -v row="$ROW" '
  BEGIN { in_section=0 }
  $0 == target { in_section=1; print; next }
  in_section && /^## / { in_section=0 }
  in_section && /^\| Skill/ { print; next }
  in_section && /^\|---/ { capturing=1; print; next }
  in_section && capturing && /^\|/ { print row; capturing=0 }
  { print }
' SKILL.md > SKILL.md.tmp && mv SKILL.md.tmp SKILL.md

TODAY=$(date +%Y-%m-%d)
CHANGELOG_ROW="| $TODAY | 添加 | $NEW_NAME 🏠内部 | 新建 skill |"
sed -i "2a\\$CHANGELOG_ROW" README.md
sed -i "2a\\$CHANGELOG_ROW" SKILL.md

git add .
git commit -m "feat: 添加 $NEW_NAME skill"
git push origin main
```

## 完整执行示例

```bash
# name/description/triggers/category/author 必填
# platforms 留空 = 生成全部平台

NAME=my-awesome-skill
DESC="一个超棒的 skill"
TRIGGERS="触发词1|触发词2|触发词3"
CATEGORY=devops
AUTHOR=relunctance
PLATFORMS=""  # 留空生成全部，或 "claude codex openclaw"

TODAY=$(date +%Y-%m-%d)

mkdir -p ~/repos/$NAME
cd ~/repos/$NAME

# 生成 SKILL.md
cat > SKILL.md << 'SKILLEOF'
---
name: {NAME}
description: {DESC}
triggers:
  - 触发词1
  - 触发词2
  - 触发词3
category: devops
author: {AUTHOR}
created: {TODAY}
updated: {TODAY}
platforms: all
tags:
  - example
---

# {NAME}

{DESC}

## 快速开始

<!-- 用户补充 -->
SKILLEOF

# 生成全部平台入口
for platform in claude codex openclaw hermes cursor windsurf; do
  case $platform in
    claude)
      cat > CLAUDE.md << 'EOF'
# {NAME}

{DESC}

## 触发条件

触发词1 / 触发词2 / 触发词3

## 快速开始

<!-- 用户补充 -->
EOF
      ;;
    codex)
      cat > CODEX.md << 'EOF'
# {NAME}

{DESC}

## 触发条件

触发词1 / 触发词2 / 触发词3

## 快速开始

<!-- 用户补充 -->
EOF
      ;;
    openclaw|hermes)
      cat > AGENTS.md << 'EOF'
# {NAME}

{DESC}

## 触发条件

触发词1 / 触发词2 / 触发词3

## 快速开始

<!-- 用户补充 -->

## 安装

hermes skills install https://github.com/{AUTHOR}/{NAME}
EOF
      ;;
    cursor)
      cat > CURSOR.md << 'EOF'
# {NAME}

{DESC}

## 触发条件

触发词1 / 触发词2 / 触发词3

## 快速开始

<!-- 用户补充 -->
EOF
      ;;
    windsurf)
      cat > WINDSURF.md << 'EOF'
# {NAME}

{DESC}

## 触发条件

触发词1 / 触发词2 / 触发词3

## 快速开始

<!-- 用户补充 -->
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
![OpenClaw](https://img.shields.io/badge/OpenClaw-Hermes-orange)
![Cursor](https://img.shields.io/badge/Cursor-AI-purple)
![Windsurf](https://img.shields.io/badge/Windsurf-AI-red)

## 触发条件

触发词1 / 触发词2 / 触发词3

## 快速开始

<!-- 用户补充 -->

## 安装

hermes skills install https://github.com/{AUTHOR}/{NAME}
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

## 文件结构

```
{name}/
├── SKILL.md              # 所有平台共用（平台无关）
├── README.md             # 文档主页
├── AGENTS.md             # OpenClaw / Hermes 入口
├── CLAUDE.md             # Claude Code 入口
├── CODEX.md              # Codex 入口
├── CURSOR.md             # Cursor 入口
├── WINDSURF.md           # Windsurf 入口
├── .claude-plugin/       # Claude Code 插件元数据
│   └── plugin.json
├── .codex-plugin/        # Codex 插件元数据
│   └── plugin.json
└── .opencode/           # OpenCode 插件目录
    └── plugins/
```

## 踩坑记录

| 坑 | 说明 | 解决方案 |
|---|---|---|
| GitHub API 创建仓库需要 token | 无 token 报 401 | `TOKEN=$(grep "oauth_token:" ~/.config/gh/hosts.yml | head -1 | awk '{print $2}')` |
| git push 超时 | WSL/国内网络 | `git config --global http.proxy http://192.168.1.109:10808` |
| SKILL.md frontmatter 格式错误 | YAML 解析失败 | 确保 `---` 独立一行，fields 缩进 4 空格 |
| `date` 字段要用 YYYY-MM-DD | 其他格式不标准 | `date +%Y-%m-%d` |
| skill 名称不以 `-skill` 结尾 | 规范不符 | 必须以 `-skill` 结尾 |

## GitHub Token

```bash
TOKEN=$(grep "oauth_token:" ~/.config/gh/hosts.yml | head -1 | awk '{print $2}')
curl -s -H "Authorization: token $TOKEN" https://api.github.com/user | jq .login
```
