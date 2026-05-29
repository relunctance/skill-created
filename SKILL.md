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
updated: 2026-05-30
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

> 🔴 **CHECKPOINT · 🛑 STOP**：收集完信息后**必须停止**，等待用户确认后再继续。

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

> ⚠️ **创建强制规范**（每次创建 skill 必须遵守）：
> 1. **使用 `references/` 目录**：详细文档拆分到 `references/`，主文件 SKILL.md 尽可能小（≤600行）
> 2. **必须美化 README**：创建完成后调用 readme-skill 美化 README
> 3. **learns/ 必须创建**：记录踩坑沉淀

> **platforms 默认值**：留空则生成全部平台（claude / codex / openclaw / hermes / cursor / windsurf）

### 第二步：初始化仓库

```bash
mkdir -p ~/repos/{name}
cd ~/repos/{name}
git init
git config user.email "maomao@gql.ai"
git config user.name "maomao"
```

### 第三步：生成 SKILL.md

```markdown
---
name: {name}
description: {description}
triggers:
  - 触发词1
  - 触发词2
  - 触发词3
category: {category}
author: {author}
created: {YYYY-MM-DD}
updated: {YYYY-MM-DD}
platforms: all
tags:
  - {name}
---

# {name}

{description}

## 触发条件

当需要以下操作时使用：
- 触发词1
- 触发词2
- 触发词3

## 核心流程

<!-- 概要流程，详细信息拆分到 references/ -->

## references/ 索引

| 文件 | 内容 |
|------|------|
| references/README.md | 详细文档索引 |
```

### 第三步半：创建 learns/ 和 references/ 目录

```bash
mkdir -p learns references

cat > learns/README.md << 'EOF'
# {name} 踩坑沉淀

> 开发/维护过程中遇到的所有坑，按标签归档。

## 🏷️ 按标签索引

<!-- 初次创建时为空，后续按需追加 -->

---

## 记录规范

遇到新坑时，在对应标签下追加记录：

```markdown
### {一句话描述}

**问题**：{具体现象}

**原因**：{根本原因}

**解决**：{解决方案}

**相关 commit**：{commit hash} | **发现日期**：{YYYY-MM-DD}
```
EOF

cat > references/README.md << 'EOF'
# {name} 参考文档

> 详细文档按主题原子化拆分，主文件只保留概要。

## 目录

<!-- 按需创建具体 reference 文件 -->
EOF
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

### 第五步：README 美化

> 🔴 **强制步骤**：创建完 SKILL.md 后必须调用 readme-skill 美化 README

```bash
# 加载 readme-skill 并美化 README
# 参照 readme-skill 的规范检查并更新 README
# 必须包含：License、Version、Platforms、Category 徽章
# 必须包含：触发条件、安装、核心功能章节
```

### 第六步：提交

```bash
git add .
git commit -m "feat: initial {name} skill"
```

> 🔴 **CHECKPOINT · 🛑 STOP**：创建 GitHub 仓库前**必须停止**，等待用户确认后再继续。

### 第七步：创建 GitHub 仓库

```bash
curl -s -X POST https://api.github.com/user/repos \
  -H "Authorization: token $TOKEN" \
  -d "{\"name\":\"{name}\",\"description\":\"{description}\",\"private\":false}"
```

### 第八步：推送

```bash
git branch -M main
git remote add origin https://github.com/{author}/{name}.git
git push -u origin main
```

### 第九步：联动更新 gql-skills

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

---

## 文件结构

```
{name}/
├── SKILL.md              # 主文件 ≤600 行，核心流程 + references 索引
├── README.md             # 入口文档（必须美化）
├── AGENTS.md             # OpenClaw / Hermes 入口
├── CLAUDE.md             # Claude Code 入口
├── CODEX.md              # Codex 入口
├── CURSOR.md             # Cursor 入口
├── WINDSURF.md           # Windsurf 入口
├── learns/               # 踩坑沉淀（按标签归档）
│   └── README.md
└── references/           # 详细文档（原子化，一个文件一个主题）
    └── README.md
```

## 设计原则

| 该用代码 | 该用 SOP / LLM |
|---------|----------------|
| 精确计算（时间戳、diff 百分比） | 决策判断（歧义、优先级） |
| 文件 I/O（确定性读写） | 文本处理（格式化、提取） |
| 精确序列化（JSON 结构） | 工作流编排（SOP 章节） |

**操作顺序**：
1. 先问「能否用 SOP + LLM 解决？」
2. 再问「最小化代码方案是什么？」
3. 最后再动手写代码

## 约束

1. 单一改动 < 150 行新增代码
2. 流程/协议/格式定义 → 放 SKILL.md（SOP 章节）
3. 精确计算/文件 IO → 放 scripts/
4. **SKILL.md 尽可能小**，详细内容拆分到 references/

## GitHub Token

```bash
TOKEN=$(grep "oauth_token:" ~/.config/gh/hosts.yml | head -1 | awk '{print $2}')
curl -s -H "Authorization: token $TOKEN" https://api.github.com/user | jq .login
```

## 踩坑沉淀

> **历史踩坑记录已迁移到 `learns/` 目录**，按标签归档，持续更新。

### skill-created 禁止行为清单

| ❌ 禁止 | 原因 | 正确做法 |
|---------|------|----------|
| ❌ 跳过信息收集直接创建 | 会导致仓库名/描述不准确 | 必须先收集 name/description/category/author |
| ❌ 手动 git init 而不用 gql-skills 流程 | 会跳过 GitHub Actions 自动同步 | 用 gql-skills 流程创建 |
| ❌ 在 WSL 用 `~` 做路径 | `~` 会展开到 Hermes profile home | 用绝对路径 `/home/gql/` |
| ❌ 用 `git push -f` | 会丢失远程 commit | 禁止 force push |
| ❌ 先创建后补文档 | 文档应该在创建时生成，不是之后补 | 创建时就生成完整 SKILL.md + README.md |
| ❌ 创建 skill 不以 `-skill` 结尾 | 违反命名规范 | 强制以 `-skill` 结尾 |
| ❌ SKILL.md 写得太大 | 违反「尽可能小」原则 | 详细内容拆分到 references/ |
| ❌ 跳过 README 美化 | README 质量影响 skill 可用性 | 必须调用 readme-skill 美化 |
