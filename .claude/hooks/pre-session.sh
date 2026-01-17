#!/bin/bash

# Filmmaking Panel Pre-Session Hook
# Displays project info at session start

echo "🎯 Filmmaking Scenario Panel"
echo ""

# Check for active scenarios
ACTIVE_COUNT=0
if [ -d "scenarios/active" ]; then
    ACTIVE_COUNT=$(find scenarios/active -maxdepth 1 -type d -name "SCENARIO-*" 2>/dev/null | wc -l | tr -d ' ')
fi

if [ $ACTIVE_COUNT -eq 0 ]; then
    echo "📁 No active scenarios"
    echo ""
    echo "To begin:"
    echo "  1. Run: .claude/scenario-init.sh"
    echo "  2. Start conversation with the panel moderator"
    echo ""
else
    echo "📁 Active Scenarios: $ACTIVE_COUNT"
    echo ""

    # Show latest scenario
    LATEST=$(ls -t scenarios/active/SCENARIO-* 2>/dev/null | head -1)
    if [ -n "$LATEST" ] && [ -f "$LATEST/metadata.json" ]; then
        SCENARIO_ID=$(basename "$LATEST")
        PHASE=$(jq -r '.phase // "unknown"' "$LATEST/metadata.json" 2>/dev/null)

        echo "Latest: $SCENARIO_ID"
        echo "Phase: $PHASE"
        echo ""
    fi

    echo "Use .claude/list-scenarios.sh to see all scenarios"
    echo ""
fi

# Display specialist roster
echo "👥 Available Specialists:"
echo ""
echo "  Filmmakers:"
echo "    • Tony Gilroy - Institutional realism, revolution mechanics"
echo "    • Kathryn Bigelow - Rigor, physical authenticity, present-tense realism"
echo "    • Steven Soderbergh - Formalism, ego-muted process, iteration"
echo "    • Michael Mann - Causality, professional competence, collision"
echo "    • Denis Villeneuve - Poetic camera, dark tension, visual truth"
echo "    • Oliver Stone - Truth-telling, confrontation with power"
echo "    • Adam McKay - Satire with bite, comedy played straight"
echo "    • Costa-Gavras - Power relationships, political thriller engine"
echo "    • Tomas Alfredson - Interiority, betrayal, silence as actor"
echo "    • Chloe Zhao - Authenticity and ethics balance, humanist core"
echo ""

echo "⚠️  Phase 0 worldview model + context enrichment + internal baseline are mandatory."
echo "   Review materials_index.md with the user and log 'Materials Reviewed' in company.md before interviewing."
echo ""

echo "✅ Ready for scenario planning"
exit 0
