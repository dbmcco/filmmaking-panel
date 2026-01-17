#!/bin/bash
# ABOUTME: Build a materials index from repo resources for Phase 0 intake.
# ABOUTME: Creates a lightweight preview file for the moderator to read first.

set -e

SCENARIO_ID=$1
if [ -z "$SCENARIO_ID" ]; then
    echo "Usage: $0 SCENARIO-YYYY-NNN" >&2
    exit 1
fi

SCENARIO_DIR="scenarios/active/${SCENARIO_ID}"
RESOURCES_ROOT="resources"
CURATED_DIR="${RESOURCES_ROOT}/curated"
MANIFEST_FILE="${CURATED_DIR}/manifest.txt"
RESOURCES_DIR="${RESOURCES_ROOT}"
OUTPUT_DIR="${SCENARIO_DIR}/phase_0_discovery"
OUTPUT_FILE="${OUTPUT_DIR}/materials_index.md"

if [ -d "$CURATED_DIR" ]; then
    RESOURCES_DIR="$CURATED_DIR"
fi

if [ ! -d "$RESOURCES_DIR" ]; then
    echo "Resources directory not found: ${RESOURCES_DIR}"
    exit 0
fi

RESOURCE_FILES=()

resource_seen() {
    local candidate="$1"
    local existing
    for existing in "${RESOURCE_FILES[@]}"; do
        if [ "$existing" = "$candidate" ]; then
            return 0
        fi
    done
    return 1
}

add_resource() {
    local path="$1"
    if [ -z "$path" ]; then
        return
    fi
    if resource_seen "$path"; then
        return
    fi
    RESOURCE_FILES+=("$path")
}

while IFS= read -r file; do
    add_resource "$file"
done < <(find "$RESOURCES_DIR" -type f \
    ! -name "README.md" \
    ! -name "manifest.txt" \
    ! -name "manifest.md" \
    ! -name ".gitkeep" \
    ! -name ".DS_Store")

if [ -f "$MANIFEST_FILE" ]; then
    while IFS= read -r line; do
        line=$(echo "$line" | sed -e 's/^[[:space:]]*//' -e 's/[[:space:]]*$//')
        case "$line" in
            ""|\#*) continue ;;
        esac
        if [ -f "$line" ]; then
            add_resource "$line"
        elif [ -f "$RESOURCES_ROOT/$line" ]; then
            add_resource "$RESOURCES_ROOT/$line"
        else
            echo "Warning: manifest entry not found: $line" >&2
        fi
    done < "$MANIFEST_FILE"
fi

if [ ${#RESOURCE_FILES[@]} -eq 0 ]; then
    echo "No resources found in ${RESOURCES_DIR}"
    exit 0
fi

mkdir -p "$OUTPUT_DIR"

{
    echo "# Materials Index"
    echo ""
    echo "Generated: $(date -u +"%Y-%m-%d %H:%M:%SZ")"
    echo ""
    echo "This index lists available resources and includes light previews when possible."
    echo ""
} > "$OUTPUT_FILE"

for file in "${RESOURCE_FILES[@]}"; do
    [ -z "$file" ] && continue

    filename=$(basename "$file")
    filesize=$(wc -c < "$file" | tr -d ' ')
    filetype=$(file -b "$file" 2>/dev/null || echo "unknown")

    {
        echo "## ${filename}"
        echo "- Path: ${file}"
        echo "- Size: ${filesize} bytes"
        echo "- Type: ${filetype}"
        echo ""
    } >> "$OUTPUT_FILE"

    case "$file" in
        *.md|*.txt|*.csv|*.tsv|*.json|*.yaml|*.yml)
            {
                echo "### Text Preview"
                echo '```'
                head -n 40 "$file"
                echo '```'
                echo ""
            } >> "$OUTPUT_FILE"
            ;;
        *.pdf)
            if command -v pdftotext >/dev/null 2>&1; then
                {
                    echo "### PDF Text Preview"
                    echo '```'
                    pdftotext "$file" - 2>/dev/null | head -n 40
                    echo '```'
                    echo ""
                } >> "$OUTPUT_FILE"
            else
                {
                    echo "### Notes"
                    echo "PDF preview not available (pdftotext missing)."
                    echo ""
                } >> "$OUTPUT_FILE"
            fi
            ;;
        *)
            {
                echo "### Notes"
                echo "No preview available for this file type."
                echo ""
            } >> "$OUTPUT_FILE"
            ;;
    esac
done

echo "Materials index created: ${OUTPUT_FILE}"
