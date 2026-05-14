# skill-created

> Skill 工厂 — 一键创建标准化 GitHub 公开仓库 + SKILL.md，支持多平台适配（claude/codex/openclaw/hermes 等）

## 特性

- **多平台支持**：自动生成 CLAUDE.md / CODEX.md / AGENTS.md 等平台入口
- **标准化格式**：SKILL.md frontmatter + README.md 完整规范
- **gql-skills 联动**：创建后自动更新 gql-skills 索引

## 支持的平台

| 平台 | 入口文件 | 说明 |
|------|---------|------|
| Claude Code CLI | `CLAUDE.md` | 进入目录时自动读取 |
| Codex | `CODEX.md` | Codex 专用入口 |
| OpenClaw | `AGENTS.md` | OpenClaw 工作空间根目录 |
| Hermes | `AGENTS.md` | Hermes 工作空间根目录（与 OpenClaw 共用） |
| Cursor | `CURSOR.md` | Cursor AI 专用入口 |
| Windsurf | `WINDSURF.md` | Windsurf AI 专用入口 |

## 触发条件

- 创建一个 skill
- 创建 skill 仓库
- 新建 skill
- skill 创建器
- skill boilerplate
- 创建多平台 skill

## 命名规范

⚠️ 所有 skill 名称必须以 `-skill` 结尾

示例：`dir-skill`、`honesty-skill`、`ubuntu-chromium-setup-skill`
