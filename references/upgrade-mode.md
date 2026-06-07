# skill-created 升级模式

> 当用户说「升级已有 skill 的进化机制」或「为某个 skill 添加 learns/」时使用本模式。

---

## upgrade 模式触发词

- `skill-created --upgrade`
- 为某个 skill 添加 learns/
- 升级已有 skill 的进化机制

---

## upgrade 模式 SOP

### Step 1：定位 skill 目录

```bash
# 优先查找本地 repos 目录
for dir in ~/repos/{name} ~/repos/{name}-skill ~/.hermes/skills/{name} ~/.hermes/skills/{name}-skill; do
  if [ -d "$dir" ]; then
    echo "FOUND: $dir"
    break
  fi
done

# 如果找不到，询问用户
if [ -z "$FOUND" ]; then
  echo "请提供 skill 目录路径："
  read SKILL_DIR
else
  SKILL_DIR="$FOUND"
fi
```

### Step 2：检查现有结构

```bash
echo "=== 检查现有结构 ==="
ls -la "$SKILL_DIR"

# 检查是否有 learns/
if [ ! -d "$SKILL_DIR/learns" ]; then
  echo "⚠️ 缺少 learns/ 目录，将创建"
fi

# 检查是否有 references/
if [ ! -d "$SKILL_DIR/references" ]; then
  echo "⚠️ 缺少 references/ 目录，将创建"
fi

# 检查是否有 scripts/feedback.py
if [ ! -f "$SKILL_DIR/scripts/feedback.py" ]; then
  echo "⚠️ 缺少 scripts/feedback.py，将创建"
fi
```

### Step 3：生成 learns/ 目录

```bash
mkdir -p "$SKILL_DIR/learns/references" "$SKILL_DIR/scripts"

# 创建 learns/README.md
cat > "$SKILL_DIR/learns/README.md" << 'EOFLEARN'
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
```

### Step 4：生成 self-improvement.md

```bash
cat > "$SKILL_DIR/learns/self-improvement.md" << 'EOFSELF'
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

### Step 5：生成 scripts/feedback.py

```bash
cat > "$SKILL_DIR/scripts/feedback.py" << 'EOFFB'
"""{name} 反馈积累模块 — 自我进化数据收集"""
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

### Step 6：提交

```bash
cd "$SKILL_DIR"
git add .
git commit -m "feat: 添加进化机制（learns/ + feedback.py）"
git push origin main
```
