# Claude Cowork Film Prep Plugin

Date: 2026-03-10
Status: draft
Audience: builder/operator

## Goal

Give a non-technical filmmaker a practical `Claude Desktop + Cowork` setup that can act like a lightweight assistant producer without requiring custom infrastructure, terminal use, or direct API operations.

The product shape is:

- `Claude Cowork` for planning, research, drafting, and orchestration
- one custom `Film Prep` desktop extension for local file and production-data work
- optional `remote connectors` for cloud tools
- one storyboard platform as the visual front end

## Decision Summary

- Build a `local Claude Desktop extension` first.
- Use `Boords` as the preferred storyboard integration target.
- Keep `StudioBinder` as a manual/native workflow option, not the first automation target.
- Use `Google Docs/Sheets/Drive` connectors for the paperwork side.
- Use `Zapier MCP` only for coarse Boords actions, not for high-volume frame-by-frame sync.

## Why This Shape

The user constraint is not technical complexity in the build phase. It is operational simplicity for the filmmaker.

That means:

- local project files should remain the source of truth
- Claude should work from a dedicated film folder without asking the user to upload everything repeatedly
- external automations should be narrow, reversible, and easy to debug
- the extension should expose tools, not a hardcoded workflow engine

This is a model-mediated system:

- `Claude` should decide how to interpret scenes, which locations may combine, what materials are missing, and what packet to draft next
- `code` should parse files, normalize data, write outputs, and call external tools exactly as requested

## User Experience

The filmmaker should be able to do things like:

- "Read the latest script and build a first-pass scene breakdown."
- "Draft a shot list and storyboard prompts for scenes 12-18."
- "Find candidate location consolidations so we can reduce company moves."
- "Compare likely net cost in Pennsylvania vs New York vs Georgia."
- "Prepare a Pennsylvania tax-credit packet checklist and draft the missing docs."
- "Push this approved shot list into Boords."

She should not need to know what MCP is, manage JSON config, or think about tool routing.

## Recommended Folder Structure

Use one dedicated workspace folder per project:

```text
FilmName_Prepro/
  inputs/
    script/
    budget/
    schedule/
    references/
  working/
    normalized/
    research/
    drafts/
  outputs/
    shotlists/
    storyboards/
    locations/
    incentives/
  submissions/
    pa-tax-credit/
```

Recommended canonical files:

- `working/normalized/script_scenes.json`
- `working/normalized/scene_elements.json`
- `outputs/shotlists/master_shotlist.csv`
- `outputs/locations/location_matrix.csv`
- `outputs/incentives/incentive_comparison.xlsx`
- `submissions/pa-tax-credit/checklist.md`

## Product Architecture

### 1. Local desktop extension

The extension should own local-only operations:

- read screenplay files
- parse screenplay structure
- normalize scene metadata
- generate production planning files
- write approved drafts back into the project folder
- assemble export bundles for storyboard tools

This is the most important surface because the screenplay, boards, notes, and packet drafts are likely to start as local files.

### 2. Remote connectors

Use remote connectors only where cloud tools clearly help:

- `Google Drive` for document storage
- `Google Docs` for editable packet drafts
- `Google Sheets` for incentive comparison and location matrices
- optional `Zapier MCP` for Boords actions

### 3. Plugin packaging

If you want one installable experience, package the workflow as a `Cowork plugin` that bundles:

- the `Film Prep` desktop extension
- a few slash commands
- a small set of skills/instructions
- the recommended remote connectors

The plugin should reduce setup, not introduce a second control plane.

## Extension Tool Surface

The MVP should expose a narrow toolbelt.

### Script tools

- `parse_script`
  - Input: screenplay file path
  - Output: normalized scene JSON
- `diff_script_revision`
  - Input: previous and current screenplay
  - Output: added, removed, modified scenes
- `extract_production_elements`
  - Output: cast, props, vehicles, VFX, SFX, animals, stunts, wardrobe, special equipment

### Shot-planning tools

- `build_scene_shotlist`
  - Input: scene ids plus optional style notes
  - Output: structured shot list rows
- `build_storyboard_prompts`
  - Input: scene ids or shot ids
  - Output: frame prompts and captions
- `export_boords_bundle`
  - Output: CSV/images/metadata ready for manual or assisted Boords ingest
- `export_studiobinder_bundle`
  - Output: script-plus-images bundle for manual StudioBinder use

### Location tools

- `build_location_matrix`
  - Output: scene-to-location requirements matrix
- `suggest_location_consolidations`
  - Output: candidate merges ranked by creative fit and move reduction
- `cluster_company_moves`
  - Output: grouped day plans or geographic clusters

### Incentive tools

- `build_incentive_comparison`
  - Input: budget top sheet, state assumptions
  - Output: comparable net-cost workbook
- `check_pa_eligibility`
  - Output: gaps against current Pennsylvania criteria
- `build_pa_packet_checklist`
  - Output: filing checklist and missing-materials tracker
- `draft_pa_packet_docs`
  - Output: first-pass narratives and support docs

### Research and admin tools

- `save_research_brief`
- `update_decision_log`
- `generate_status_report`

## Suggested Slash Commands

If you package this as a Cowork plugin, keep commands task-shaped:

- `/film-intake`
- `/breakdown-script`
- `/build-shotlist`
- `/location-pass`
- `/compare-incentives`
- `/prep-pa-packet`
- `/sync-boords`

Each command should trigger Claude to gather just enough context, then call tools as needed.

## Workflow Design

### Intake

Claude should:

- inspect the project folder
- confirm the current script version
- identify missing materials
- generate an initial working checklist

### Breakdown

Claude should:

- parse the script
- extract scene metadata
- flag production-heavy scenes
- build a location matrix

### Visual planning

Claude should:

- produce a draft shot list per scene
- generate storyboard prompt text
- export a Boords-ready bundle

The user should still approve visual tone and coverage.

### Location pass

Claude should:

- normalize fictional locations into physical requirements
- cluster scenes that could share one practical location
- propose a reduced-move schedule candidate

### Incentive pass

Claude should:

- compare likely qualification and net spend across NY, PA, and GA
- identify which assumptions drive the answer
- prepare a submission checklist for the chosen state

### Filing support

Claude should:

- draft packet narratives
- assemble evidence requirements
- track what is still missing

Final review should remain human.

## Data Model

The normalized scene schema should stay simple and editable.

```json
{
  "scene_id": "12",
  "slugline": "INT. DINER - NIGHT",
  "page_start": 24,
  "page_end": 26,
  "characters": ["MARA", "JOEL"],
  "location_label": "Diner",
  "time_of_day": "NIGHT",
  "requirements": {
    "stunts": false,
    "vehicles": true,
    "special_fx": false,
    "music": false
  },
  "location_needs": {
    "interior": true,
    "parking": true,
    "night_control": true,
    "permits_likely": true
  }
}
```

The shot list schema should stay equally plain:

```json
{
  "scene_id": "12",
  "shot_id": "12A",
  "shot_type": "Medium",
  "camera_move": "Static",
  "description": "Mara clocks Joel before sitting down.",
  "story_purpose": "Establish tension before the reveal.",
  "board_prompt": "1970s diner interior, fluorescent light, medium shot, tense silence"
}
```

## What Not To Automate

Do not automate:

- final location commitments
- legal or accounting sign-off
- direct unattended filing of tax-credit applications
- broad file access outside the project folder
- full storyboard generation through per-frame Zapier actions

## Why Boords First

Boords currently has the cleanest supported path for Claude-adjacent automation:

- official AI script import
- official export formats that work well with downstream production files
- official Zapier integration
- official Zapier MCP surface for `Create Project`, `Create Storyboard`, and `Create Frame`

That makes it viable for:

- creating project shells
- creating storyboards
- pushing a curated subset of approved frames
- syncing comments or render events back into the working folder

It does not make it smart to push hundreds of frames one at a time through MCP.

## Why StudioBinder Second

StudioBinder looks strong as a native production system, but not as an external automation target.

The supported flow appears to be:

- import screenplay
- let StudioBinder generate schedule, shot list, breakdown, and storyboard
- upload images manually

Important constraint: StudioBinder's support docs say it does `not` support importing a shot list from Excel or CSV. That blocks the cleanest "Claude generates structured data, app ingests it" path.

## MVP Phases

### Phase 1: file-native planning

Build:

- script parsing
- scene normalization
- shot list generation
- location matrix generation
- incentive comparison workbook
- Pennsylvania packet checklist and draft docs

Skip:

- direct storyboard sync
- multi-user deployment

### Phase 2: Boords assist

Add:

- Boords export bundle
- optional Zapier MCP actions for project/storyboard/frame creation
- comment/status sync back into local files

### Phase 3: packaging

Add:

- plugin bundle
- installer docs
- minimal settings UI

## Open Questions

- Will she commit to one storyboard platform for a full project?
- Does she want Google Docs/Sheets as the editable surface, or local Markdown/CSV first?
- How much of the incentive comparison needs CPA-grade rigor versus early scenario analysis?
- Does she want Claude to propose coverage style, or only structure coverage from director notes?

## Sources

- Anthropic Cowork: https://support.claude.com/en/articles/13345190-get-started-with-cowork
- Anthropic Cowork plugins: https://support.claude.com/en/articles/13837440-use-plugins-in-cowork
- Anthropic local desktop extensions: https://support.claude.com/en/articles/10949351-getting-started-with-local-mcp-servers-on-claude-desktop
- Anthropic `.mcpb` packaging: https://support.claude.com/en/articles/12922929-building-desktop-extensions-with-mcpb
- Anthropic remote MCP connectors: https://support.claude.com/en/articles/11175166-get-started-with-custom-connectors-using-remote-mcp
- Anthropic connector guidance: https://support.claude.com/en/articles/11725091-when-to-use-desktop-and-web-connectors
- Boords AI script import: https://help.boords.com/en/articles/10894763-importing-scripts-with-ai
- Boords exports: https://boords.com/docs/export-formats
- Boords storyboard views: https://boords.com/docs/storyboard-views
- Boords Zapier integration announcement: https://boords.com/changes/integrations
- Zapier Boords integration: https://zapier.com/apps/boords/integrations
- Zapier Boords MCP: https://zapier.com/mcp/boords
- Zapier MCP overview: https://docs.zapier.com/mcp/home
- StudioBinder screenplay import: https://support.studiobinder.com/en/articles/10952562-how-to-import-your-screenplay
- StudioBinder screenplay sync to project: https://support.studiobinder.com/en/articles/2071922-how-to-sync-a-script-to-the-project
- StudioBinder shot list from screenplay: https://support.studiobinder.com/en/articles/1458081-how-to-create-shot-lists-with-a-screenplay
- StudioBinder shot list population limits: https://support.studiobinder.com/en/articles/1455273-how-to-populate-the-shot-list
