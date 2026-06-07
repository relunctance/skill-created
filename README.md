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

*Skill Factory — One-click creation of standardized GitHub public repositories, zero-cost cross-platform adaptation*

</div>

## 🎯 Triggers

- Create a skill
- Create a skill repository
- New skill
- Skill creator
- Skill boilerplate
- **skill-created** ← Must trigger this skill
- Create a skill named skill-created

## ✨ Features

- **Full Platform Coverage**: Auto-generates `CLAUDE.md` / `CODEX.md` / `AGENTS.md` / `CURSOR.md` / `WINDSURF.md`
- **Platform Plugin Metadata**: `.claude-plugin/` / `.codex-plugin/` / `.cursor-plugin/` / `.opencode/`
- **Zero Extra Cost**: `platforms` empty = generate all platforms, no forced specification
- **learns Pitfall Archives**: Each skill comes with `learns/` directory for continuous pitfall documentation
- **Self-Evolution Ready**: Integrates with [evolve-skill](https://github.com/relunctance/evolve-skill) for automated skill improvement based on learns archives
- **8 Mandatory Constraints**: Quality guarantees via references/ / bilingual README / BDD+TDD / main branch etc.

## ⚙️ Supported Platforms

| Platform | Entry File | Plugin Directory |
|----------|------------|-----------------|
| Claude Code | `CLAUDE.md` | `.claude-plugin/` |
| Codex | `CODEX.md` | `.codex-plugin/` |
| OpenClaw / Hermes | `AGENTS.md` | — |
| Cursor | `CURSOR.md` | `.cursor-plugin/` |
| Windsurf | `WINDSURF.md` | — |

## 🚀 Quick Start

```bash
# 一键安装（推荐）
bash -c "$(curl -fsSL https://raw.githubusercontent.com/relunctance/skill-created/main/install.sh)"

# 创建新 skill（交互式）
hermes skills run skill-created

# 指定平台（留空=全部5平台）
# platforms: claude,codex
```

## 📦 Dependencies & Installation

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

## ✅ Post-Installation Verification

```
{skill-name}/
├── SKILL.md              # Shared across all platforms (platform-agnostic)
├── README.md             # English documentation home
├── README_zh.md          # Chinese documentation home
├── AGENTS.md             # OpenClaw / Hermes entry
├── CLAUDE.md             # Claude Code entry
├── CODEX.md             # Codex entry
├── CURSOR.md            # Cursor entry
├── WINDSURF.md          # Windsurf entry
├── learns/              # Pitfall archives + self-evolution via evolve-skill
│   └── README.md
├── .claude-plugin/      # Claude Code plugin metadata
├── .codex-plugin/       # Codex plugin metadata
└── .opencode/          # OpenCode plugin directory
```

## ✅ Post-Installation Verification

- [ ] `hermes skills list` shows skill-created
- [ ] Saying "create a skill" triggers this skill
- [ ] `bash install.sh` runs without errors
- [ ] `learns/` directory is created in new skill
- [ ] No `__pycache__` or `*.pyc` files

## ⚠️ Mandatory Constraints

> Full specification in [SKILL.md](SKILL.md#约束表)

| # | Constraint | Description |
|---|------------|-------------|
| 1 | `references/` directory | Detailed docs split into `references/`, SKILL.md ≤ 600 lines |
| 2 | Bilingual README | README.md (English) + README_zh.md (Chinese), top cross-reference |
| 3 | README beautification | Both call readme-skill for beautification |
| 4 | `learns/` must be created | Record pitfall archives |
| 5 | BDD + TDD development | Write comments first, then implement |
| 6 | Remote branch main | All new repositories use main |
| 7 | GitHub About info | Must fill description when creating repository |
| 8 | Triggers = repo name | Repo name must match trigger word |
| 9 | platforms empty = all 5 | Default to all platforms when not specified |
| 10 | Commit after each step | Small-step iteration, commit after each verification |
| 11 | install.sh required | README must include one-click `curl...\|bash` install |
| 12 | Contributing section | README must include contributing instructions |

## 🔗 Related Skills

- [readme-skill](https://github.com/relunctance/readme-skill) — README beautification tool (skill-created's companion)
- [dir-skill](https://github.com/relunctance/dir-skill) — Directory structure standardization
- [evolve-skill](https://github.com/relunctance/evolve-skill) — Skill self-evolution engine (uses learns/ archives)

## 🤝 Contributing

Contributions, issues and pull requests are welcome!

**Found a bug?**
1. Submit an [Issue](https://github.com/relunctance/skill-created/issues)
2. Describe reproduction steps
3. Attach error logs

**Want to contribute code?**
1. Fork this repository
2. Create a Feature branch (`git checkout -b feature/AmazingFeature`)
3. Write BDD comments + TDD tests
4. Commit changes (`git commit -m 'Add AmazingFeature'`)
5. Push to branch (`git push origin feature/AmazingFeature`)
6. Create a Pull Request

## 📜 License

MIT — see [LICENSE](LICENSE)
