---
search: false
---

<div align="center">

# 🏭 skill-created

**[English](README.md) · [中文](README_zh.md)**

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE)
[![version](https://img.shields.io/badge/version-1.0.0-green.svg)](#)
[![platforms](https://img.shields.io/badge/platforms-Claude%20Code%20%7C%20Codex%20%7C%20OpenClaw%20%7C%20Hermes%20%7C%20Cursor%20%7C%20Windsurf-blue.svg)](#)
[![category](https://img.shields.io/badge/category-DevOps-blue.svg)](#)

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
# Install
hermes skills install https://github.com/relunctance/skill-created

# Create a new skill (interactive)
hermes skills run skill-created

# Specify platforms during creation
# platforms: claude,codex (empty=all platforms)
```

## 📦 Installation

```bash
# Hermes / OpenClaw
hermes skills install https://github.com/relunctance/skill-created
```

## 📁 File Structure

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

## ⚠️ Mandatory Constraints

> Full specification in [SKILL.md](SKILL.md#创建强制规范)

| # | Constraint | Description |
|---|------------|-------------|
| 1 | `references/` directory | Detailed docs split into `references/`, SKILL.md ≤ 600 lines |
| 2 | README beautification | Both English and Chinese call readme-skill for beautification |
| 3 | `learns/` must be created | Record pitfall archives |
| 4 | Python-first | Skills involving code prefer Python |
| 5 | BDD + TDD development | Write comments first, then implement |
| 6 | Remote branch main | All new repositories use main |
| 7 | GitHub About info | Must fill description when creating repository |
| 8 | Triggers + repo name | User saying `skill-created` must trigger; repo name must also be the trigger |

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
