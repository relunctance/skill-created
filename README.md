---
name: skill-created
description: Skill 工厂 — 一键创建标准化 GitHub 公开仓库 + SKILL.md，适合需要快速沉淀大量 skill 的场景
triggers:
  - 创建一个 skill
  - 创建 skill 仓库
  - 新建 skill
  - skill 创建器
  - skill boilerplate
category: devops
author: relunctance
created: 2026-05-08
updated: 2026-05-08
tags:
  - skill
  - skill-created
  - boilerplate
  - github
---

# skill-created

> 一键创建标准化 skill GitHub 仓库，包含 SKILL.md + README.md

## 触发条件

用户说：
- `创建一个 skill`
- `创建 skill 仓库`
- `skill 创建器`
- 或任何需要新建 skill 的场景

## 使用方法

### 第一步：收集信息

向用户收集以下信息（缺一不可）：

| 字段 | 说明 | 示例 |
|------|------|------|
| `name` | skill 名称（英文，kebab-case） | `ubuntu-chromium-setup` |
| `description` | 一句话描述（中文） | `Ubuntu/WSL Chromium 安装 + 中文字体配置` |
| `triggers` | 触发关键词列表（中文） | `ubuntu 安装 chrome`, `中文乱码` |
| `category` | 分类 | `devops` / `data-science` / `productivity` 等 |
| `author` | 作者 | `relunctance` |
| `content` | skill 正文内容 | 用户提供的正文 |

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
tags:
{tag_lines}
---

# {name}

{content}
```

其中：
- `trigger_lines`：每行一个触发词，前置 4 空格
- `tag_lines`：每行一个 tag，前置 4 空格

### 第四步：生成 README.md

```markdown
# {name}

{description}

## 触发条件

{trigger_lines_plain}

## 快速开始

{content}
```

### 第五步：创建 GitHub 仓库

```bash
# 通过 GitHub API 创建（需要 GH_TOKEN）
curl -s -X POST https://api.github.com/user/repos \
  -H "Authorization: token $TOKEN" \
  -d "{\"name\":\"{name}\",\"description\":\"{description}\",\"private\":false}"
```

### 第六步：推送

```bash
git add .
git commit -m "feat: initial {name} skill"
git branch -M main
git remote add origin https://github.com/{author}/{name}.git
git push -u origin main
```

### 第七步：联动更新 gql-skills

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

case "$NEW_CATEGORY" in
  Infrastructure)  TARGET="## Infrastructure" ;;
  DevOps|Devops)   TARGET="## 基础设施" ;;
  AI/ML|AI|ML)    TARGET="## AI 与机器学习" ;;
  Productivity)    TARGET="## 效率工具 Productivity" ;;
  *)               TARGET="## 实验性" ;;
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

> **注意**：如果新 skill 属于 `Expert Teams` 分类，手动在 README.md 和 SKILL.md 中对应表格追加，awk 脚本默认不处理该分类。

## 完整执行示例

```bash
# 用户提供：name=ubuntu-chromium-setup, description=Ubuntu Chromium安装+字体配置
# triggers=[ubuntu chrome安装, 中文乱码, fontconfig]
# category=devops, author=relunctance

NAME=ubuntu-chromium-setup
DESC="Ubuntu/WSL Chromium 安装 + 中文字体配置"
TRIGGERS="ubuntu chrome安装|中文乱码|fontconfig|小红书乱码"
CATEGORY=devops
AUTHOR=relunctance

mkdir -p ~/repos/$NAME
cd ~/repos/$NAME

# 生成 SKILL.md
cat > SKILL.md << 'EOF'
---
name: {NAME}
description: {DESC}
triggers:
{TRIGGERS_split}
category: {CATEGORY}
author: {AUTHOR}
created: 2026-05-08
updated: 2026-05-08
tags:
  - ubuntu
  - chromium
  - fontconfig
  - chinese
---

# {NAME}

{DESC}
EOF

cp SKILL.md README.md
git init
git add . && git commit -m "feat: initial {NAME} skill"

# 创建 GitHub 仓库
curl -s -X POST https://api.github.com/user/repos \
  -H "Authorization: token $TOKEN" \
  -d "{\"name\":\"$NAME\",\"description\":\"$DESC\",\"private\":false}"

git remote add origin https://github.com/$AUTHOR/$NAME.git
git push -u origin main
```

## 踩坑记录

| 坑 | 说明 | 解决方案 |
|---|---|---|
| GitHub API 创建仓库需要 token | 无 token 报 401 | 使用 `~/.config/gh/hosts.yml` 里的 oauth_token |
| `~/.config/gh/hosts.yml` 有多个 token | 取第一个 oauth_token 字段 | `grep "oauth_token:" file \| head -1 \| awk '{print $2}'` |
| git push 超时（WSL/国内网络） | 网络不通 GitHub | 配置代理 `git config --global http.proxy http://192.168.1.109:10808` |
| SKILL.md frontmatter 格式错误 | YAML 解析失败 | 确保 `---` 独立一行，tags 缩进 4 空格 |
| `date` 字段要用 YYYY-MM-DD | 其他格式不标准 | `date +%Y-%m-%d` |

## GitHub Token 获取

```bash
# 方式 1：从 gh hosts 配置读取
TOKEN=$(grep "oauth_token:" ~/.config/gh/hosts.yml | head -1 | awk '{print $2}')

# 方式 2：从 GH_TOKEN 环境变量
TOKEN=$GH_TOKEN

# 验证 token
curl -s -H "Authorization: token $TOKEN" https://api.github.com/user | jq .login
```
