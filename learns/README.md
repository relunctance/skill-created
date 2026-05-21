# skill-created 踩坑沉淀

> 开发/维护过程中遇到的所有坑，按标签归档。

## 🏷️ 按标签索引

- `#workflow` — 创建/更新 skill 时的 SOP 坑
- `#doc-standards` — 文档规范相关坑

---

## #workflow

### skill-created README 美化被遗忘

**问题**：多次创建 skill 后忘记用 readme-skill 美化 README，导致 README 缺少徽章、安装章节、分类

**原因**：没有固化到 skill-created 工作流中，靠人工记忆容易遗漏

**解决**：
1. skill-created SKILL.md 第十步强制要求 README 美化（徽章 + 章节）
2. SOUL.md skill 创建 SOP 第 3 步强制 readme-skill 检查
3. skill-created 创建后自动检查 README 完整性

**相关 commit**：`b92be0c` | **发现日期**：2026-05-17

---

### SKILL.md 过长未按 references 拆分

**问题**：SKILL.md 写到 3000 行，所有内容堆在一起，更新某章节时必须全文浏览，不同使用者无法只读某章节

**原因**：skill-created 模板没有强制约束主文件行数，开发者习惯性堆砌

**解决**：新增「文档拆分原则」章节，强制要求：
1. 主文件 ≤1000 行，只保留概要 + references 索引
2. 详细文档拆分到 `references/` 目录（原子化，一个文件一个主题）
3. references 文件必须含精确路径、行号、命令、JSON 结构

**相关 commit**：待提交 | **发现日期**：2026-05-21

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
