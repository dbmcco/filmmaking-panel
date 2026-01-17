ABOUTME: Filmmaking Scenario Panel overview and usage.

# Filmmaking Scenario Panel

Claude Code-powered, single-panel scenario planning for screenwriting and filmmaking decisions. The panel balances creative integrity and commercial viability, with focus routing set during intake.

## What This Is

- One panel, multiple focus tracks: writing, production, fundraising, market.
- Worldview-first: capture the creator's creative worldview before external scenarios.
- Scenario-driven: stress-test decisions across plausible futures.

## Quick Start

1. Install `pp-cli`:
   ```bash
   npm install -g @dbmcco/pp-cli
   pp --version
   ```
2. Install the worldview-elicitor skill:
   ```bash
   mkdir -p ~/.claude/skills
   ln -s "$(pwd)/skills/worldview-elicitor" ~/.claude/skills/worldview-elicitor
   ```
3. Start a Claude Code session in this repo and run:
   ```bash
   .claude/session-start.sh --new
   ```

## Panel Roster

- Tony Gilroy
- Kathryn Bigelow
- Steven Soderbergh
- Michael Mann
- Denis Villeneuve
- Oliver Stone
- Adam McKay
- Costa-Gavras
- Tomas Alfredson
- Chloe Zhao

## Docs

- `docs/worldview-intake.md` - Phase 0 worldview capture + focus routing.
- `docs/persona-index.md` - persona list and dossier locations.
- `docs/personas/` - sourced persona dossiers.

## Repo Structure

```
filmmaking-panel/
├── .claude/                # Session scripts, hooks, validators
├── prompts/                # Moderator + specialist prompts
├── templates/              # Scenario artifact templates
├── resources/              # Drop materials for intake
├── scenarios/              # Active and archived scenarios
└── docs/                   # Design docs and persona dossiers
```
