# Quick Start Guide

## How to Use Filmmaking Scenario Panel

### Step 1: Prerequisites

**Install pp-cli:**
```bash
npm install -g @dbmcco/pp-cli
pp --version
```

**Install the worldview-elicitor skill:**
```bash
mkdir -p ~/.claude/skills
ln -s "$(pwd)/skills/worldview-elicitor" ~/.claude/skills/worldview-elicitor
```

### Step 2: Start a Session
```bash
.claude/session-start.sh --new
```

### Step 3: Tell the Moderator What You Need

Just start describing your project and the decision you need to make:

**Example:**
> "I have a draft for a political thriller. I need to decide whether to keep a quiet, slow-burn structure or push it toward a more commercial tempo. I also need to understand what a viable budget tier looks like."

### What Happens Next

The moderator will:
1. Capture your creative worldview (Phase 0)
2. Route the focus (writing, production, fundraising, or market)
3. Establish a focal question
4. Consult specialists strategically
5. Build scenarios + strategy analysis
6. Integrate outcomes back into your worldview

You do not need to run any scripts manually after session start.
