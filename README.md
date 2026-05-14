# skill-created

> Skill 工厂 — 一键创建标准化 GitHub 公开仓库，零成本适配全平台

## 特性

- **全平台覆盖**：自动生成 CLAUDE.md / CODEX.md / AGENTS.md / CURSOR.md / WINDSURF.md
- **平台插件元数据**：`.claude-plugin/` / `.codex-plugin/` / `.cursor-plugin/` / `.opencode/`
- **零额外成本**：platforms 留空 = 生成全部平台，不强制指定

## 支持的平台

| 平台 | 入口文件 | 插件目录 |
|------|---------|---------|
| Claude Code | `CLAUDE.md` | `.claude-plugin/` |
| Codex | `CODEX.md` | `.codex-plugin/` |
| OpenClaw / Hermes | `AGENTS.md` | - |
| Cursor | `CURSOR.md` | `.cursor-plugin/` |
| Windsurf | `WINDSURF.md` | - |

## 触发条件

- 创建一个 skill
- 创建 skill 仓库
- 新建 skill
- skill 创建器
- skill boilerplate

## 命名规范

⚠️ 所有 skill 必须以 `-skill` 结尾
