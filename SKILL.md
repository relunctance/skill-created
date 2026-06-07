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
>
> **内置自我进化机制** — 每个新 skill 都包含 learns/ 问题积累 + scripts/feedback.py + evolution-skill 扫描闭环

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
mkdir -p learns/references scripts

cat > learns/README.md << 'EOFLEARN'
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
EOFLEARN

cat > references/README.md << 'EOF'
# {name} 参考文档

> 详细文档按主题原子化拆分，主文件只保留概要。

## 目录

<!-- 按需创建具体 reference 文件 -->
EOF
```

### 第三步半续：创建 learns/self-improvement.md

> **自我进化机制说明** — 供 evolution-skill 扫描

```bash
cat > learns/self-improvement.md << 'EOFSELF'
# 自我进化机制

> 本 skill 内置自我进化闭环，持续积累经验并自动优化。

## 机制说明

```
脚本运行 → 问题积累 → learns/{category}-problems.md
                                          ↓
                              evolution-skill 扫描（≥3条触发）
                                          ↓
                                    darwin-skill 进化
                                          ↓
                                  skill 代码自动升级
```

## 问题池文件

| 文件 | 类别 | 触发阈值 |
|------|------|----------|
| `learns/layout-problems.md` | 布局/空间/位置问题 | ≥3条 |
| `learns/visual-problems.md` | 视觉/颜色/字体问题 | ≥3条 |
| `learns/functional-problems.md` | 功能/逻辑错误 | ≥3条 |
| `learns/ux-problems.md` | 用户体验问题 | ≥3条 |

## 如何积累问题

在脚本中调用 `scripts/feedback.py`：

```python
import sys
from pathlib import Path
sys.path.insert(0, str(Path(__file__).parent))
from feedback import save_problem, ProblemCategory

save_problem(
    category=ProblemCategory.LAYOUT,
    description="节点重叠问题",
    dqs_scores={"d1": 40, "d2": 50, "total": 55.0},
    source_md="input.md",
    learns_dir=Path("learns"),
)
```

## 触发进化

运行 `evolution-skill` 扫描所有 skills 的 learns/：

```
hermes skills run evolution-skill --scan-all
```

## 问题池格式

```markdown
<!-- 问题 #N -->
## YYYY-MM-DD 问题 #N

**DQS**: XX.X (D1=X D2=X D3=X D4=X D5=X D6=X)
**来源**: filename.md

> 问题描述

---
```
EOFSELF
```

### 第三步半续续：创建 scripts/feedback.py

```bash
cat > scripts/feedback.py << 'EOFFB'
"""{name} 反馈积累模块 — 自我进化数据收集"""""
from datetime import datetime
from enum import Enum
from pathlib import Path
import json
import re

class ProblemCategory(Enum):
    LAYOUT = "layout"
    VISUAL = "visual"
    FUNCTIONAL = "functional"
    UX = "ux"
    PERFORMANCE = "performance"
    OTHER = "other"

def save_problem(
    category: ProblemCategory,
    description: str,
    dqs_scores: dict | None = None,
    source_md: str = "",
    learns_dir: Path = Path("learns"),
    metadata: dict | None = None,
) -> int:
    """保存问题到 learns/{category}-problems.md，返回问题编号"""
    pool_file = learns_dir / f"{category.value}-problems.md"
    learns_dir.mkdir(parents=True, exist_ok=True)

    last_num = 0
    if pool_file.exists():
        for m in re.finditer(r"<!-- 问题 #(\d+) -->", pool_file.read_text()):
            last_num = max(last_num, int(m.group(1)))

    new_num = last_num + 1
    now = datetime.now().strftime("%Y-%m-%d")

    dqs_str = ""
    if dqs_scores:
        parts = [f"D{k}={v}" for k, v in dqs_scores.items() if k != "total"]
        if "total" in dqs_scores:
            parts.insert(0, f"DQS={dqs_scores['total']}")
        dqs_str = " ".join(parts)

    meta_str = json.dumps(metadata) if metadata else ""

    entry = f"""
<!-- 问题 #{new_num} -->
## {now} 问题 #{new_num}

**DQS**: {dqs_scores.get("total", "N/A") if dqs_scores else "N/A"} ({dqs_str})
**来源**: {source_md}

> {description}

{"**元数据**: " + meta_str if meta_str else ""}

---
"""
    with open(pool_file, "a", encoding="utf-8") as f:
        f.write(entry)
    return new_num

def check_threshold(
    category: str,
    learns_dir: Path = Path("learns"),
    threshold: int = 3,
) -> bool:
    """检查问题池是否达到升级阈值"""
    pool_file = learns_dir / f"{category}-problems.md"
    if not pool_file.exists():
        return False
    count = len(re.findall(r"<!-- 问题 #\d+ -->", pool_file.read_text()))
    return count >= threshold
EOFFB
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
| ❌ 跳过 README 美化 | README 质量影响 skill 可用性 | 必须调用 readme-skill 美化 |
