"""skill-created 反馈积累模块 — 自我进化数据收集模板"""
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
