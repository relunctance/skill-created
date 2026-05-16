# skill-created

> Skill 工厂 — 一键创建标准化 GitHub 公开仓库，零成本适配全平台

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![version](https://img.shields.io/badge/version-1.0.0-green.svg)](#)
[![platforms](https://img.shields.io/badge/platforms-claude%20%7C%20codex%20%7C%20openclaw%20%7C%20hermes%20%7C%20cursor%20%7C%20windsurf-blue.svg)](#)
[![category](https://img.shields.io/badge/category-devops-blue.svg)](#)

## 触发条件

- 创建一个 skill
- 创建 skill 仓库
- 新建 skill
- skill 创建器
- skill boilerplate

## 功能特性

- **全平台覆盖**：自动生成 `CLAUDE.md` / `CODEX.md` / `AGENTS.md` / `CURSOR.md` / `WINDSURF.md`
- **平台插件元数据**：`.claude-plugin/` / `.codex-plugin/` / `.cursor-plugin/` / `.opencode/`
- **零额外成本**：`platforms` 留空 = 生成全部平台，不强制指定
- **learns 踩坑沉淀**：每个 skill 自带 `learns/` 目录，持续归档

## 支持的平台

| 平台 | 入口文件 | 插件目录 |
|------|---------|---------|
| Claude Code | `CLAUDE.md` | `.claude-plugin/` |
| Codex | `CODEX.md` | `.codex-plugin/` |
| OpenClaw / Hermes | `AGENTS.md` | — |
| Cursor | `CURSOR.md` | `.cursor-plugin/` |
| Windsurf | `WINDSURF.md` | — |

## 安装

```bash
# Hermes / OpenClaw
hermes skills install https://github.com/relunctance/skill-created
```

## 文件结构

```
{skill-name}/
├── SKILL.md              # 所有平台共用（平台无关）
├── README.md             # 文档主页
├── AGENTS.md             # OpenClaw / Hermes 入口
├── CLAUDE.md             # Claude Code 入口
├── CODEX.md              # Codex 入口
├── CURSOR.md             # Cursor 入口
├── WINDSURF.md           # Windsurf 入口
├── learns/               # 踩坑沉淀（按标签归档）
│   └── README.md
├── .claude-plugin/       # Claude Code 插件元数据
├── .codex-plugin/        # Codex 插件元数据
└── .opencode/           # OpenCode 插件目录
```

## 踩坑沉淀

> 完整记录见 [learns/README.md](./learns/README.md)

## 命名规范

⚠️ 所有 skill 必须以 `-skill` 结尾
