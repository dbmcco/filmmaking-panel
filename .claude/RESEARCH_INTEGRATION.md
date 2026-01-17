# ABOUTME: Documentation of Perplexity AI research integration for Filmmaking Panel
# Research Integration Architecture

## Overview

The Filmmaking Panel uses Perplexity AI for targeted research when local materials
are insufficient. Use it to validate comps, market signals, deal structures, and
production context without replacing the panel's creative judgment.

## Research Specialist (Optional)

**File:** `prompts/specialists/researcher.md`

**Role:** Trend Scan and gap-filling specialist for complex research needs.

**Best used for:**
- Recent market signals (festival buys, streamer strategy shifts).
- Comparable films and reported outcomes.
- Financing benchmarks or distribution terms.
- Publicly documented production constraints (tax incentives, union rules).

## Specialist Direct Access

Specialists may use pp-cli for quick fact checks when details are essential to
their analysis. Research must include citations and confidence notes.

## Research Tool: pp-cli (Perplexity AI)

**Quick Mode (Default):**
```bash
pp --no-interactive "query" --output json
```

**Research Mode (Deep Analysis):**
```bash
pp -r --no-interactive "complex query" --output json
```

## Key Principles

1. Research fills gaps; it does not replace panel judgment.
2. All research must include citations and confidence notes.
3. Prefer local materials before external search.
4. Log research in transcripts and context_packet.md.
