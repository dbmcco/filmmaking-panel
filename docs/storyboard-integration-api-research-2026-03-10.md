# Storyboard Integration API Research

Date: 2026-03-10
Status: draft
Scope: `Claude Cowork` + storyboard/preproduction integration options

## Bottom Line

Use `Boords` as the first integration target.

Use `StudioBinder` if the filmmaker prefers its native production workflow, but assume a mostly manual bridge until a clear official API surface is confirmed.

Important clarification:

- I did `not` confirm a public Boords developer API in official Boords docs.
- The current Boords recommendation is based on `official imports/exports + Zapier integration + Zapier MCP`, not a direct Boords REST API.

## Evaluation Criteria

- official, currently supported automation surface
- fit with `Claude Desktop + Cowork`
- ability to start from a finished screenplay
- ability to carry Claude-generated planning data into the storyboard tool
- friction level for a non-technical filmmaker
- operational cost and failure recovery

## Anthropic Integration Surfaces

These are the current supported ways to connect Claude to outside tools.

### Local desktop extensions

Best for:

- local screenplay files
- local export bundles
- private notes and working folders
- lightweight personal tooling

Current official shape:

- packaged as `.mcpb`
- installed through Claude Desktop
- supports Node.js, Python, and binary MCP servers
- can be privately distributed

Recommendation:

- use this for the `Film Prep` core

### Remote connectors using MCP

Best for:

- cloud applications
- OAuth-authenticated services
- team-facing tools
- services already exposed over the web

Current official shape:

- available in Claude and Claude Desktop
- custom connectors are in beta
- meant for trusted remote MCP servers

Recommendation:

- use for Google services
- use if a clean hosted storyboard connector becomes worth maintaining

### Cowork plugins

Best for:

- packaging the user experience
- bundling commands, connectors, skills, and sub-agents

Recommendation:

- package later, after the local extension is stable

## Boords

### What is officially supported

Boords' official docs and product pages currently show:

- `AI script import`
- `shot list view`
- export formats including `PDF`, `DOCX`, `XLSX`, `ZIP images`, `MP4 animatic`, and `Google Slides`
- official `Zapier integration`
- official `Zapier MCP` page for Boords actions

This is a meaningful surface for Claude-led workflows.

### Current Boords automation surface

From the current Zapier pages, Boords exposes at least these actions:

- `Create Project`
- `Create Storyboard`
- `Create Frame`

And these triggers:

- `New Storyboard`
- `New Animatic`
- `New Comment on Project`
- `New Comment on Storyboard`
- `Download Images`

### What this is good for

- creating a project shell from Claude
- creating a storyboard once a scene pack is approved
- adding a limited set of frames
- syncing comments or rendered animatics back to local project files
- using exports for shot tracking and review

### What this is bad for

- high-volume frame creation through MCP
- pushing hundreds of incremental edits one action at a time
- assuming a rich direct REST API exists

### Important cost and workflow constraint

Zapier's current MCP docs say:

- Zapier MCP is `one action at a time`
- one MCP tool call uses `2 tasks`
- batch operations can consume multiple tool calls quickly

That means a frame-heavy sync model will get expensive and brittle fast.

### Recommendation for Boords

Use Boords in one of two ways:

1. `Best immediate path`
   - Claude generates shot lists, prompts, and exports
   - the filmmaker imports or pastes into Boords with light human review

2. `Selective automation path`
   - Claude uses Zapier MCP to create projects, storyboards, and a curated subset of approved frames

### Missing piece

As of this research pass, I did not find an official public Boords REST API document on Boords' own docs. The supported automation story appears to be `product exports/imports + Zapier`.

## StudioBinder

### What is officially supported

StudioBinder's support docs currently show:

- screenplay import from `.fdx`, `.sbx`, `.pdf`, `.fountain`, and `.txt`
- screenplay import can feed scheduling, breakdowns, shot lists, and storyboards
- syncing revised scripts can regenerate related project views
- image uploads to shot lists/storyboards

This makes StudioBinder strong as a native preproduction system.

### Important workflow constraints

The support docs also state:

- free plans import only `50%` of a script
- `Movie Magic Scheduling (.mms)` files cannot be imported
- shot lists cannot currently be imported from `Excel or CSV`

That last point is the key blocker for a Claude-generated structured shot list pipeline.

### What this is good for

- one-tool native production flow
- filmmakers who want script, schedule, breakdown, shot list, and storyboard inside one system
- manual or semi-manual workflows with screenplay import at the center

### What this is bad for

- treating StudioBinder as a programmable target for Claude-generated data
- importing structured shot lists from external files
- assuming an open public integration layer

### API status

As of March 10, 2026, I did not locate a clear official public API, developer portal, or official Zapier integration for StudioBinder in the official support/domain searches I ran.

Inference:

- treat StudioBinder as `app-first`, not `API-first`
- prefer manual import plus human review if StudioBinder is chosen

## Comparison

| Criterion | Boords | StudioBinder |
| --- | --- | --- |
| Official AI/script intake | Yes | Yes |
| Official exports useful to Claude workflow | Strong | Some, but less integration-oriented in current docs checked |
| Official automation surface | Zapier + Zapier MCP | Not clearly documented |
| Fit for local-extension + selective sync | Stronger | Weaker |
| Fit for all-in-one native production app | Moderate | Stronger |
| Best role in this project | Automation target | Manual/native alternate |

## Recommended Integration Strategy

### Preferred stack

- `Claude Desktop + Cowork`
- local `Film Prep` extension
- `Boords` for storyboards
- `Google Docs/Sheets/Drive` for editable planning artifacts
- optional `Zapier MCP` for project-level Boords actions

### If she prefers StudioBinder

Use:

- Claude for screenplay analysis, incentive modeling, location planning, and packet drafting
- StudioBinder for screenplay import and native production management

Do not plan around:

- direct API sync
- CSV shot list ingestion

### What to build first

Build first:

- screenplay parser
- scene normalization
- shot list exporter
- location matrix generator
- incentive comparison workbook
- PA packet drafting/checklist support

Delay:

- hosted remote connector
- full Boords sync
- any StudioBinder automation beyond file prep

## Specific API Recommendations

### Use now

- Anthropic local desktop extension API surface via MCP
- Anthropic remote connector support for Google tools
- Zapier MCP for a narrow Boords action set

### Use carefully

- Boords `Create Frame` via Zapier MCP, only for approved/high-value frames

### Avoid for MVP

- any design that assumes Boords bulk frame APIs beyond what Zapier exposes
- any design that assumes StudioBinder has a stable public API
- any design that depends on pushing CSV shot lists into StudioBinder

## Sources

- Anthropic Cowork: https://support.claude.com/en/articles/13345190-get-started-with-cowork
- Anthropic plugins in Cowork: https://support.claude.com/en/articles/13837440-use-plugins-in-cowork
- Anthropic local desktop extensions: https://support.claude.com/en/articles/10949351-getting-started-with-local-mcp-servers-on-claude-desktop
- Anthropic remote connectors: https://support.claude.com/en/articles/11175166-get-started-with-custom-connectors-using-remote-mcp
- Anthropic connector guidance: https://support.claude.com/en/articles/11725091-when-to-use-desktop-and-web-connectors
- Boords AI script import: https://help.boords.com/en/articles/10894763-importing-scripts-with-ai
- Boords export formats: https://boords.com/docs/export-formats
- Boords storyboard views: https://boords.com/docs/storyboard-views
- Boords export page: https://boords.com/export
- Boords integrations announcement: https://boords.com/changes/integrations
- Zapier Boords integrations: https://zapier.com/apps/boords/integrations
- Zapier Boords MCP: https://zapier.com/mcp/boords
- Zapier MCP docs: https://docs.zapier.com/mcp/home
- Zapier MCP usage: https://docs.zapier.com/mcp/usage/overview
- StudioBinder screenplay import: https://support.studiobinder.com/en/articles/10952562-how-to-import-your-screenplay
- StudioBinder sync screenplay to project: https://support.studiobinder.com/en/articles/2071922-how-to-sync-a-script-to-the-project
- StudioBinder from Movie Magic Scheduling: https://support.studiobinder.com/en/articles/2039676-go-from-movie-magic-scheduling-to-studiobinder
- StudioBinder shot list with screenplay: https://support.studiobinder.com/en/articles/1458081-how-to-create-shot-lists-with-a-screenplay
- StudioBinder populate shot list: https://support.studiobinder.com/en/articles/1455273-how-to-populate-the-shot-list
