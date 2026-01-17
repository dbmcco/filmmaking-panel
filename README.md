ABOUTME: Filmmaking Scenario Panel overview and usage.

# Filmmaking Scenario Panel

Claude Code-powered, single-panel scenario planning for screenwriting and filmmaking decisions. The panel balances creative integrity and commercial viability, with focus routing set during intake.

## Overview

- One panel, multiple focus tracks: writing, production, fundraising (pre-buys, equity, grants), market.
- Real filmmaker personas grounded in public interviews and writings (see `docs/personas/`).
- Resources-first intake: materials in `resources/` are the primary evidence base.
- Worldview-first: capture the creator's creative worldview plus art/commercial weights.
- Model-mediated guardrails: calibration, not-knowing diagnostics, opposition pass.
- Outputs stored under `scenarios/active/SCENARIO-YYYY-NNN/`.

## Model Alignment

This panel follows the Lens-World-Lens workflow and phase gates established in the Shell Scenario Panel and used across the panel suite:

- Shell Scenario Panel: https://github.com/dbmcco/shell-scenario-panel
- VC Panel: https://github.com/dbmcco/vc-panel

Workflow phases mirror the existing model: worldview elicitation -> internal baseline -> context enrichment -> focal question -> predetermined elements -> critical uncertainties -> scenario development -> strategy synthesis -> worldview integration.

## Panelists

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
- Research Specialist
- Quality Analyst

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
3. Start a Claude Code session in this repo (see `CODEX.md`), then run:
   ```bash
   .claude/session-start.sh --new
   ```
4. Add materials to `resources/` (script, outline, deck, budget, comps, financing plan).
5. Tell the moderator your focus track, decision horizon, and art/commercial weights.

The moderator will automatically index any materials in `resources/` before interviewing.

## Materials

Place all reference documents here:

- `resources/`

Use markdown or text exports when possible. For decks, include a text summary alongside slides.

## Key Outputs

Typical artifacts include:

- `worldview_model.md`
- `phase_0_discovery/internal_baseline.md`
- `phase_0_discovery/context_packet.md`
- `focal_question.md`
- `predetermined_elements.md`
- `critical_uncertainties.md`
- `scenarios/*.md`
- `worldview_integration.md`

## Docs

- `docs/worldview-intake.md` - Phase 0 worldview capture + focus routing.
- `docs/persona-index.md` - persona list and dossier locations.
- `docs/personas/` - sourced persona dossiers.

## Directory Structure

```
filmmaking-panel/
|-- .claude/                # Session scripts, hooks, validators
|-- prompts/                # Moderator + specialist prompts
|-- templates/              # Scenario artifact templates
|-- resources/              # Drop materials for intake
|-- scenarios/              # Active and archived scenarios
`-- docs/                   # Design docs and persona dossiers
```

## External Research

Install `pp-cli` to enable context enrichment and trend scanning:

```bash
npm install -g @dbmcco/pp-cli
pp --version
```

## Exports (Optional)

The moderator may generate HTML or TypeScript exports when helpful.
Exports live at `scenarios/active/SCENARIO-YYYY-NNN/exports/`.
To preview locally:

```bash
.claude/lib/serve-exports.sh SCENARIO-YYYY-NNN
```
