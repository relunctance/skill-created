---
name: skill-created
description: Skill 工厂 — 一键创建标准化 GitHub 公开仓库 + SKILL.md，零成本适配全平台（claude/codex/openclaw/hermes/cursor/windsurf）
triggers:
  - skill-created
  - skill-created --upgrade
  - 创建一个 skill
  - 创建 skill 仓库
  - 新建 skill
  - skill 创建器
  - skill boilerplate
  - 创建多平台 skill
  - 为某个 skill 添加 learns/
  - 升级已有 skill 的进化机制
  - 创建名叫 skill-created 的 skill
category: devops
author: relunctance
created: 2026-05-08
updated: 2026-06-10
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
>
> **内置自我进化机制** — 每个新 skill 都包含 learns/ 问题积累 + scripts/feedback.py + evolution-skill 扫描闭环

## 触发条件

### create 模式

用户说：
- `创建一个 skill`
- `创建 skill 仓库`
- `新建 skill`
- `skill 创建器`
- `skill boilerplate`
- 或任何需要新建 skill 的场景

### upgrade 模式

用户说：
- `skill-created --upgrade <target-skill>`
- `为某个 skill 添加 learns/`
- `升级已有 skill 的进化机制`

**Step 1：检查缺失文件**
```
检查 target-skill 目录下：
├── learns/
│   ├── README.md
│   ├── self-improvement.md
│   └── *-problems.md（可选，初次为空）
├── scripts/
│   └── feedback.py
```

**Step 2：注入 scaffold（缺少什么补什么）**

生成并写入 `learns/README.md`：
```markdown
# {name} 踩坑沉淀

> 开发/维护过程中遇到的所有坑，按标签归档。

## 🏷️ 按标签索引

<!-- 初次创建时为空，后续按需追加 -->
```

生成并写入 `learns/self-improvement.md`：
```markdown
# 自我进化机制

> 本 skill 内置自我进化闭环，持续积累经验并自动优化。
...
```

生成并写入 `scripts/feedback.py`（纯 Python stdlib，零依赖）。

**Step 3：运行 readme-skill 美化**（必须）

**Step 4：commit + push**

```bash
git add .
git commit -m "feat: add evolution scaffold (learns/ + feedback.py)"
git push
```

**Step 5：更新 gql-skills**（关联 issue）

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
> 2. **必须美化 README**：创建完成后调用 readme-skill 美化 README（中英文都要）
> 3. **learns/ 必须创建**：记录踩坑沉淀
> 4. **代码优先 Python**：涉及代码的 skill 优先使用 Python
> 5. **BDD + TDD 开发**：写代码必须先写 BDD 注释，再 TDD 实现
> 6. **远程分支 main**：所有新仓库 `git branch -M main`
> 7. **GitHub About 信息**：创建仓库时必须填写 description
> 8. **skill-created 必须触发 + 仓库名必须是触发词**：用户说 "skill-created" 必须加载本 skill；新建 skill 仓库名也必须是触发词（如 skill-created / plan-skill / darwin-skill）

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
| [references/create-flow.md](references/create-flow.md) | create 模式完整流程（第四步~第九步 + README 模板） |
| [references/upgrade-mode.md](references/upgrade-mode.md) | upgrade 模式 SOP + feedback.py 模板 |

> 📌 **提示**：详细的 bash 脚本和 README 模板已拆分到 `references/` 目录，主文件只保留流程概要。

---

## 核心流程（create 模式）

> 详细信息拆分到 [references/create-flow.md](references/create-flow.md)。

| 步骤 | 说明 | 详情 |
|------|------|------|
| 第三步半 | 创建 learns/ + references/ 目录 | [create-flow.md](references/create-flow.md) |
| 第三步半续 | 创建 learns/self-improvement.md | [upgrade-mode.md](references/upgrade-mode.md) |
| 第三步半续续 | 创建 scripts/feedback.py | [upgrade-mode.md](references/upgrade-mode.md) |
| 第四步 | 生成平台入口文件 | [create-flow.md](references/create-flow.md) |
| 第四步半 | 生成 README.md + README_zh.md | [create-flow.md](references/create-flow.md) |
| 第五步 | readme-skill 美化 | [create-flow.md](references/create-flow.md) |
| 第六步 | git commit | [create-flow.md](references/create-flow.md) |
| 第七步 | 创建 GitHub 仓库 | [create-flow.md](references/create-flow.md) |
| 第八步 | git push | [create-flow.md](references/create-flow.md) |
| 第九步 | 联动更新 gql-skills | [create-flow.md](references/create-flow.md) |

---


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

### 第五步：README 美化（中英文）

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

### 第六步：提交

```bash
git add .
git commit -m "feat: initial {name} skill"
```

> 🔴 **CHECKPOINT · 🛑 STOP**：创建 GitHub 仓库前**必须停止**，等待用户确认后再继续。

### 第七步：创建 GitHub 仓库

```bash
# About 信息 = description 字段
gh repo create {name} \
  --description "{description}" \
  --public \
  --source=. \
  --push
```

> ⚠️ **About 信息（description）必须填写**，否则 GitHub 显示"No description"影响可发现性。

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
├── README_ZH.md         # 中文版入口文档（与 README.md 顶部互相引用）
├── AGENTS.md             # OpenClaw / Hermes 入口
├── CLAUDE.md             # Claude Code 入口
├── CODEX.md              # Codex 入口
├── CURSOR.md             # Cursor 入口
├── WINDSURF.md           # Windsurf 入口
├── learns/               # 踩坑沉淀 + 自我进化问题池
│   ├── README.md         # 踩坑记录索引
│   ├── self-improvement.md  # 进化机制说明（供 evolution-skill 扫描）
│   ├── layout-problems.md   # 布局问题积累
│   └── visual-problems.md   # 视觉问题积累
├── scripts/
│   └── feedback.py       # 通用问题积累模块
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

> 踩坑记录按主题拆分到 `references/` 目录，持续更新。

### references/ 索引
## references/ 索引

| 文件 | 内容 |
|------|------|
| [references/create-flow.md](references/create-flow.md) | create 模式完整流程（第四步半~第九步 + README 模板） |
| [references/upgrade-mode.md](references/upgrade-mode.md) | upgrade 模式 SOP + feedback.py 模板 |
| [references/README.md](references/README.md) | 详细文档索引（learns/ 和 references/ 自动生成说明） |

---

## 踩坑沉淀

> 踩坑记录按主题拆分到 `references/` 目录，持续更新。

| 文件 | 内容 |
|------|------|
| [references/create-flow.md](references/create-flow.md) | 完整创建流程 + README 模板 |
| [references/upgrade-mode.md](references/upgrade-mode.md) | 升级模式 SOP |

---

## 核心流程

> 详细信息拆分到 [references/create-flow.md](references/create-flow.md)。

| 步骤 | 内容 |
|------|------|
| 第三步半 | 创建 learns/ + references/ + self-improvement.md |
| 第三步半续 | 创建 scripts/feedback.py |
| 第四步 | 生成平台入口文件（AGENTS.md / CLAUDE.md 等） |
| 第四步半 | 生成 README.md + README_zh.md（含模板） |
| 第五步 | 调用 readme-skill 美化 README（中英文） |
| 第六步 | git commit |
| 第七步 | 创建 GitHub 仓库 |
| 第八步 | git push |
| 第九步 | 联动更新 gql-skills |

---


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

### 第五步：README 美化（中英文）

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

### 第六步：提交

```bash
git add .
git commit -m "feat: initial {name} skill"
```

> 🔴 **CHECKPOINT · 🛑 STOP**：创建 GitHub 仓库前**必须停止**，等待用户确认后再继续。

### 第七步：创建 GitHub 仓库

```bash
# About 信息 = description 字段
gh repo create {name} \
  --description "{description}" \
  --public \
  --source=. \
  --push
```

> ⚠️ **About 信息（description）必须填写**，否则 GitHub 显示"No description"影响可发现性。

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
├── README_ZH.md         # 中文版入口文档（与 README.md 顶部互相引用）
├── AGENTS.md             # OpenClaw / Hermes 入口
├── CLAUDE.md             # Claude Code 入口
├── CODEX.md              # Codex 入口
├── CURSOR.md             # Cursor 入口
├── WINDSURF.md           # Windsurf 入口
├── learns/               # 踩坑沉淀 + 自我进化问题池
│   ├── README.md         # 踩坑记录索引
│   ├── self-improvement.md  # 进化机制说明（供 evolution-skill 扫描）
│   ├── layout-problems.md   # 布局问题积累
│   └── visual-problems.md   # 视觉问题积累
├── scripts/
│   └── feedback.py       # 通用问题积累模块
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

> 踩坑记录按主题拆分到 `references/` 目录，持续更新。

### references/ 索引

| 文件 | 内容 |
|------|------|
| references/uv-tool-install-wsl-path.md | uv tool install 在 WSL 下的 HOME 陷阱（2026-06-05） |

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
| ❌ 跳过 README 美化 | README 质量影响 skill 可用性 | 必须调用 readme-skill 美化（中英文都要） |
| ❌ 跳过 README_zh.md | 影响中文用户 | 必须同时生成中英文 |
| ❌ 不写 BDD 注释直接写代码 | 违反 BDD+TDD 开发规范 | 先写 BDD 注释，再 TDD 实现 |
| ❌ 远程分支用 master | 分支命名不规范 | 统一用 main |
| ❌ GitHub 仓库不填 description | 影响可发现性 | 必须填写 About 信息 |
