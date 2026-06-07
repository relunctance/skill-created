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
updated: 2026-06-11
license: MIT
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
> **零成本全平台适配** — platforms 留空时，自动生成所有平台入口文件（CLAUDE.md / CODEX.md / AGENTS.md / CURSOR.md / WINDSURF.md）
>
> **内置自我进化机制** — 每个新 skill 自带 learns/ + scripts/feedback.py，可接入 evolve-skill

---

## 设计原则

**能用 SOP + LLM 解决的，坚决不加代码。代码越多 bug 越多。**

| 该用 SOP/LLM | 该用代码 |
|--------------|---------|
| 工作流编排 | 精确计算（时间戳、diff 百分比） |
| 策略/评分规则 | 确定性文件 IO |
| LLM 调用（直接 httpx） | 幂等脚本（< 50 行） |
| 文本处理/格式化 | |

**操作顺序**：先问「能否用 SOP 解决？」→ 再问「最小化代码方案？」→ 最后动手写代码。

---

## 文件结构（create 模式产出）

```
{name}/
├── SKILL.md              # 主入口（≤600行，核心流程 + references 索引）
├── README.md             # 英文文档主页（顶部引用中文版）
├── README_zh.md          # 中文文档主页（顶部引用英文版）
├── LICENSE               # MIT License
├── AGENTS.md             # OpenClaw / Hermes 入口
├── CLAUDE.md             # Claude Code 入口
├── CODEX.md              # Codex 入口
├── CURSOR.md             # Cursor 入口
├── WINDSURF.md           # Windsurf 入口
├── learns/               # 踩坑沉淀 + 自我进化
│   ├── README.md
│   └── self-improvement.md
├── scripts/              #（如有代码）
│   └── feedback.py
└── references/           # 详细文档（原子化）
    └── README.md
```

---

## 约束表

|| # | 约束 | 说明 |
|---|------|------|------|
| 1 | `references/` 目录 | 详细文档拆分到 `references/`，SKILL.md ≤ 600 行 |
| 2 | 中英双语 README | README.md（英文）+ README_zh.md（中文），顶部互相引用 |
| 3 | 必须美化 README | 创建完成后调用 readme-skill 美化（中英文都要） |
| 4 | `learns/` 必须创建 | 记录踩坑沉淀，供 evolve-skill 扫描 |
| 5 | BDD + TDD 开发 | 写代码必须先写 BDD 注释，再 TDD 实现 |
| 6 | 远程分支 main | 所有新仓库 `git branch -M main` |
| 7 | GitHub About 必填 | 创建仓库时必须填写 description |
| 8 | 仓库名 = 触发词 | 新建 skill 仓库名必须是触发词 |
| 9 | platforms 留空 = 全平台 | 默认生成全部 5 个平台入口 |
| 10 | 每步 commit 后再继续 | 小步迭代，每步验证通过后立即 commit |
| 11 | 一键安装说明 | README 必须含 `curl ... | bash` 一键安装 + 依赖说明 |
| 12 | 欢迎贡献章节 | README 必须包含 CONTRIBUTING 说明 |

---

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

---

## create 模式：8 步流程

> 🔴 **CHECKPOINT · 🛑 STOP**：收集完信息后**必须停止**，等待用户确认后再继续。

### 第一步：收集信息

| 字段 | 说明 | 必填 | 示例 |
|------|------|------|------|
| `name` | skill 名称（kebab-case，**必须以 `-skill` 结尾**） | ✅ | `beautify-readme` |
| `description` | 一句话描述（中文） | ✅ | `自动美化 README 文档` |
| `triggers` | 触发关键词（中文） | ✅ | `美化 README`, `readme 美化` |
| `category` | 分类 | ✅ | `productivity` / `devops` 等 |
| `author` | GitHub 用户名 | ✅ | `relunctance` |
| `platforms` | 目标平台（留空=全部5平台） | ❌ | `claude codex` |

### 第二步：初始化仓库

```bash
mkdir -p /home/gql/repos/{name}
cd /home/gql/repos/{name}
git init
git config user.email "maomao@gql.ai"
git config user.name "maomao"
```

### 第三步：生成 SKILL.md + learns/ + references/

生成 `SKILL.md`（含 frontmatter + 核心流程 + references 索引）。

**SKILL.md 骨架**（直接复制使用）：

```markdown
---
name: {name}
description: {description}
triggers:
  - {trigger1}
  - {trigger2}
category: {category}
author: {author}
created: {YYYY-MM-DD}
updated: {YYYY-MM-DD}
platforms: all
tags:
  - {name}
---

# {name}

> {description}

## 触发条件

当需要以下操作时使用：
- {trigger1}
- {trigger2}

## 核心流程

<!-- 概要流程，详细内容拆分到 references/ -->

## references/ 索引

|| 文件 | 内容 |
|------|------|
|| [references/create-flow.md](references/create-flow.md) | 完整流程 + README 模板 |

---

## 约束

1. 单一改动 < 150 行新增代码
2. 流程/协议/格式定义 → 放 SKILL.md
3. 精确计算/文件 IO → 放 scripts/
```

生成 `learns/README.md`：

```markdown
# {name} 踩坑沉淀

> 开发/维护过程中遇到的所有坑，按标签归档。

## 🏷️ 按标签索引
```

生成 `references/README.md`：

```markdown
# references/

## 📚 文档索引
```

**✅ 验证**：语法检查 + 文件存在 → commit → 再继续

### 第四步：生成 README.md + README_zh.md

> ⚠️ **中英文 README 强制规则**：
> - 顶部第一行互相引用：`**[English](README.md) · [中文](README_zh.md)**`
> - 两个文件都必须有 `---` frontmatter（`search: false`）

### 第五步：调用 readme-skill 美化（中英文）

```bash
# 检查 readme-skill
if ! hermes skills list 2>/dev/null | grep -q "readme-skill"; then
  hermes skills install https://github.com/relunctance/readme-skill
fi

# 美化英文版
hermes skills run readme-skill --path ./README.md

# 美化中文版
hermes skills run readme-skill --path ./README_zh.md
```

> ⚠️ readme-skill 美化标准：
> - 必须包含：License、Version、Platforms、Category 徽章
> - 必须包含：中英文互相引用（顶部第一行）
> - 必须包含：触发条件、安装、核心功能章节
> - 必须包含：安装后验证 checklist（`- [ ]` 格式）
> - 禁止在 README 中写"Known Pitfalls"（放 learns/ 或 CONTRIBUTING.md）

> 🔴 **每步验证后 commit**：完成 README 美化后立即验证并 commit，不等到最后。

### 第六步：验证

```bash
# 语法检查
bash -n install.sh
python3 -m py_compile scripts/*.py

# 实际运行 install.sh（如有）
bash install.sh

# 验证文件结构
ls -la /home/gql/repos/{name}/
```

### 第七步：git commit

```bash
git add .
git commit -m "feat: initial {name} skill"
```

> 🔴 **CHECKPOINT · 🛑 STOP**：创建 GitHub 仓库前**必须停止**，等待用户确认后再继续。

### 第八步：创建 GitHub 仓库 + 推送

```bash
# About 信息 = description 字段
gh repo create {name} \
  --description "{description}" \
  --public \
  --source=. \
  --push

git branch -M main
git remote add origin https://github.com/{author}/{name}.git
git push -u origin main
```

---

## upgrade 模式：5 步流程

### 第一步：诊断缺失

```bash
# 检查目标 skill 目录
ls {target-skill}/
# 缺失：learns/ / scripts/feedback.py / README.md / README_zh.md
```

### 第二步：注入 scaffold

| 缺失文件 | 生成内容 |
|---------|---------|
| `learns/README.md` | 踩坑沉淀索引（模板见上方第三步） |
| `learns/self-improvement.md` | 进化机制说明 |
| `scripts/feedback.py` | 问题积累模块（Python stdlib，零依赖） |

### 第三步：调用 readme-skill 美化 README（中英文）

### 第四步：git commit

```bash
git add .
git commit -m "feat: add evolution scaffold (learns/ + feedback.py)"
git push
```

### 第五步：联动更新 gql-skills

```bash
GQL_SKILLS=/home/gql/repos/gql-skills
cd "$GQL_SKILLS"
# 添加到对应分类表格
git add .
git commit -m "feat: add {name} skill"
git push origin main
```

---

## 危险信号表

出现以下症状说明正在犯错误：

| 症状 | 根因 | 正确做法 |
|------|------|----------|
| `ln: 无法创建符号链接 ... 没有那个文件或目录` | `mkdir -p "$SKILLS_DIR"` 只创建了父目录，没创建 skill 子目录 | 直接创建完整路径 `mkdir -p "$TARGET_DIR"` |
| `hermes install` 超时后脚本直接退出 | `set -e` 遇上超时直接 exit，fallback 从未执行 | 用 HERMES_OK 标志控制 fallback，不依赖 set -e |
| `curl 404` 一键安装失败 | curl/pip 命令指向 `main` 分支，实际是 `master` | 发布前验证 `git branch -a` 确认分支名 |
| install.sh 语法检查通过但实际运行失败 | 只做了 `bash -n`，未实际执行 | 必须 `bash install.sh` 实际运行验证 |
| SKILL.md 行数 > 600 行 | 详细内容没拆分到 references/ | 重构 SKILL.md，将详情拆分到 references/ |

---

## 禁忌操作表

| 禁忌 | 后果 | 正确做法 |
|------|------|----------|
| 在 WSL 用 `~` 做路径 | `~` 展开为 Hermes profile home，导致仓库创建在错误位置 | 用绝对路径 `/home/gql/repos/` |
| `set -e` + 超时命令 | 超时直接退出，fallback 从未执行 | 用 HERMES_OK 标志控制 fallback |
| curl 指向 `main` 分支 | 实际分支是 `master` → 404 | 发布前确认 `git branch -a` |
| `bash -n` 替代实际运行 | 语法检查通过但运行失败 | 必须 `bash install.sh` 实际执行 |
| 先创建后补文档 | 文档半成品，质量无保障 | 创建时就生成完整文件，每步验证 commit |
| SKILL.md 写太大（>600行） | 可读性差，违反原子化原则 | 详细内容拆分到 references/ |

---

## 禁止行为清单

| ❌ 禁止 | 原因 | 正确做法 |
|---------|------|----------|
| 跳过信息收集直接创建 | 仓库名/描述不准确 | 必须先收集 name/description/category/author |
| 手动 git init 而不用 gql-skills 流程 | 跳过 GitHub Actions 自动同步 | 用 gql-skills 流程创建 |
| 在 WSL 用 `~` 做路径 | `~` 展开到 Hermes profile home | 用绝对路径 `/home/gql/` |
| 用 `git push -f` | 丢失远程 commit | 禁止 force push |
| 先创建后补文档 | 文档应该在创建时生成，不是之后补 | 创建时就生成完整 SKILL.md + README.md |
| 创建 skill 不以 `-skill` 结尾 | 违反命名规范 | 强制以 `-skill` 结尾 |
| 跳过 README 美化 | README 质量影响 skill 可用性 | 必须调用 readme-skill 美化（中英文都要） |
| 不写 BDD 注释直接写代码 | 违反 BDD+TDD 开发规范 | 先写 BDD 注释，再 TDD 实现 |
| 远程分支用 master | 分支命名不规范 | 统一用 main |

---

## BDD + TDD 开发流程（必须遵守）

### 判断标准

| 该用代码 | 该用 SOP/LLM |
|----------|-------------|
| 精确计算（时间戳、diff 百分比） | 决策判断（歧义、优先级） |
| 确定性文件 IO | 文本处理/格式化 |
| 幂等脚本（< 50 行） | 工作流编排 |

### 执行顺序

1. **先问**：能否用 SOP + LLM 解决？
2. **再问**：最小化代码方案是什么？
3. **最后动手**：写 BDD 注释 → 写测试 → 让测试失败 → 写实现让测试通过

### 步骤级验证清单（小步迭代）

每个子步骤完成后必须验证：

```
✅ 语法检查（bash -n / python3 -m py_compile）
✅ 实际运行（bash install.sh / python3 -m pytest）
✅ 文件结构正确（ls -la）
✅ 无垃圾文件（__pycache__、*.pyc）
✅ commit 并推送后，再进入下一步
```

### commit 时机规则

| 场景 | commit 时机 |
|------|------------|
| install.sh 编写完成 | `bash install.sh` 实际运行成功后再 commit |
| README 美化完成 | readme-skill 美化 + 验证通过后 commit |
| SKILL.md 重构完成 | 语法检查 + 触发词测试通过后 commit |
| 新增代码模块 | BDD 测试通过后再 commit |

**禁止**：未验证就 commit；未实际运行就声称"测试通过"。

---

## 步骤级验证 SOP（分步验证）

### create 模式步骤验证

```
Step 1 收集信息 → CHECKPOINT 停止 → 等待用户确认
Step 2 初始化仓库 → git init 成功后 commit
Step 3 生成 SKILL.md → 语法检查通过后 commit
Step 4 生成 README×2 → 顶部互相引用验证后 commit
Step 5 readme-skill 美化 → 实际运行美化命令后 commit
Step 6 安装验证 → bash install.sh 实际运行成功后 commit
[CHECKPOINT]
Step 7 GitHub 创建 → gh repo create 成功后 push
Step 8 gql-skills 联动 → commit + push 后完成
```

### 验证命令参考

```bash
# SKILL.md 语法检查
python3 -c "import yaml; yaml.safe_load(open('SKILL.md'))"

# README 顶部互相引用检查
grep -c '\[English\](README.md)' README_zh.md && \
grep -c '\[中文\](README_zh.md)' README.md

# install.sh 实际运行
bash install.sh 2>&1

# learns/ 目录检查
ls learns/ && [ -f learns/README.md ]
```

---

## 安装后验证清单

- [ ] `hermes skills list` 能看到 skill-created
- [ ] 说"创建一个 skill"能触发本 skill
- [ ] README.md + README_zh.md 都存在且顶部互相引用
- [ ] `learns/` 目录已创建
- [ ] 无 `__pycache__` 等垃圾文件

---

## GitHub Token（备用）

```bash
TOKEN=$(grep "oauth_token:" ~/.config/gh/hosts.yml | head -1 | awk '{print $2}')
curl -s -H "Authorization: token $TOKEN" https://api.github.com/user | jq .login
```

---

## 参考资料

- [references/create-flow.md](references/create-flow.md) — create 模式完整流程（含 README 模板）
- [references/upgrade-mode.md](references/upgrade-mode.md) — upgrade 模式 SOP + feedback.py 模板
- [references/README.md](references/README.md) — references/ 详细索引
