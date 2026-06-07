---
search: false
---

<div align="center">

# 🏭 skill-created

**[English](README.md) · [中文](README_zh.md)**

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE)
[![version](https://img.shields.io/badge/version-1.1.0-green.svg)](#)
[![platforms](https://img.shields.io/badge/platforms-Claude%20Code%20%7C%20Codex%20%7C%20OpenClaw%20%7C%20Hermes%20%7C%20Cursor%20%7C%20Windsurf-blue.svg)](#)
[![category](https://img.shields.io/badge/category-DevOps-blue.svg)](#)
[![stars](https://img.shields.io/github/stars/relunctance/skill-created?style=flat&label=Stars)](https://github.com/relunctance/skill-created/stargazers)

*Skill 工厂 — 一键创建标准化 GitHub 公开仓库，零成本适配全平台*

</div>

## 🎯 触发条件

- 创建一个 skill
- 创建 skill 仓库
- 新建 skill
- skill 创建器
- skill boilerplate
- **skill-created** ← 必须触发本 skill
- 创建名叫 skill-created 的 skill

## ✨ 功能特性

- **全平台覆盖**：自动生成 `CLAUDE.md` / `CODEX.md` / `AGENTS.md` / `CURSOR.md` / `WINDSURF.md`
- **平台插件元数据**：`.claude-plugin/` / `.codex-plugin/` / `.cursor-plugin/` / `.opencode/`
- **零额外成本**：`platforms` 留空 = 生成全部平台，不强制指定
- **learns 踩坑沉淀**：每个 skill 自带 `learns/` 目录，持续归档；可结合 [evolve-skill](https://github.com/relunctance/evolve-skill) 实现基于 learns 的自我进化
- **强制约束**：8 条创建规范保障质量（references/ / README 双语 / BDD+TDD / main 分支等）

## ⚙️ 支持的平台

| 平台 | 入口文件 | 插件目录 |
|------|---------|---------|
| Claude Code | `CLAUDE.md` | `.claude-plugin/` |
| Codex | `CODEX.md` | `.codex-plugin/` |
| OpenClaw / Hermes | `AGENTS.md` | — |
| Cursor | `CURSOR.md` | `.cursor-plugin/` |
| Windsurf | `WINDSURF.md` | — |

## 🚀 快速开始

```bash
# 一键安装（推荐）
bash -c "$(curl -fsSL https://raw.githubusercontent.com/relunctance/skill-created/main/install.sh)"

# 创建新 skill（交互式）
hermes skills run skill-created

# 指定平台（留空=全部5平台）
# platforms: claude,codex
```

## 📦 依赖 & 安装方式

### 依赖

| 依赖 | 说明 | 必选 |
|------|------|------|
| `hermes` CLI | Hermes Agent 命令行工具 | ✅ |
| `curl` | 下载安装脚本 | ✅ |
| `gh` CLI | GitHub 仓库创建（Step 8） | ❌ |
| `python3` | YAML frontmatter 验证 | ❌ |

### 安装方式

```bash
# 方式一：一键安装（推荐）
bash -c "$(curl -fsSL https://raw.githubusercontent.com/relunctance/skill-created/main/install.sh)"

# 方式二：Hermes CLI
hermes skills install https://github.com/relunctance/skill-created

# 方式三：手动安装
git clone https://github.com/relunctance/skill-created.git \
  ~/.hermes/profiles/baijie/skills/skill-created
```

## ✅ 安装后验证

- [ ] `hermes skills list` 能看到 skill-created
- [ ] 说"创建一个 skill"能触发本 skill
- [ ] `bash install.sh` 运行无报错
- [ ] 新 skill 中 `learns/` 目录已创建
- [ ] 无 `__pycache__` 或 `*.pyc` 文件

## ⚠️ 强制约束

> 完整规范见 [SKILL.md](SKILL.md#约束表)

| # | 约束 | 说明 |
|---|------|------|
| 1 | `references/` 目录 | 详细文档拆分到 `references/`，SKILL.md ≤ 600 行 |
| 2 | 中英双语 README | README.md（英文）+ README_zh.md（中文），顶部互相引用 |
| 3 | 必须美化 README | 中英文都要调用 readme-skill 美化 |
| 4 | `learns/` 必须创建 | 记录踩坑沉淀 |
| 5 | BDD + TDD 开发 | 先写注释再实现 |
| 6 | 远程分支 main | 所有新仓库统一 main |
| 7 | GitHub About 信息 | 创建仓库时必须填写 description |
| 8 | 触发词 = 仓库名 | 仓库名必须与触发词一致 |
| 9 | platforms 留空 = 全平台 | 默认生成全部 5 个平台入口 |
| 10 | 每步 commit 后再继续 | 小步迭代，每步验证通过后立即 commit |
| 11 | 必须有 install.sh | README 必须含 `curl ... | bash` 一键安装 |
| 12 | 欢迎贡献章节 | README 必须包含 CONTRIBUTING 说明 |

## 🔗 相关 Skills

- [readme-skill](https://github.com/relunctance/readme-skill) — README 美化工具（skill-created 的配套工具）
- [dir-skill](https://github.com/relunctance/dir-skill) — 目录结构标准化
- [evolve-skill](https://github.com/relunctance/evolve-skill) — Skill 自我进化引擎（基于 learns/ 驱动）

## 🤝 欢迎贡献

欢迎提交 Issue 和 Pull Request！

**发现 bug？**
1. 提交 [Issue](https://github.com/relunctance/skill-created/issues)
2. 描述复现步骤
3. 附上错误日志

**想贡献代码？**
1. Fork 本仓库
2. 创建 Feature 分支 (`git checkout -b feature/AmazingFeature`)
3. 编写 BDD 注释 + TDD 测试
4. 提交更改 (`git commit -m 'Add AmazingFeature'`)
5. 推送到分支 (`git push origin feature/AmazingFeature`)
6. 创建 Pull Request

## 📜 许可证

MIT — 详见 [LICENSE](LICENSE)
