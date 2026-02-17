#!/usr/bin/env bash
#
# setup-links.sh - Create AI tool configuration links
#
# Creates symlinks (Unix/macOS) or copies (Windows/MSYS/Git Bash)
# from each AI tool's config file to the shared CLAUDE.md instructions.
#
# Usage: bash scripts/setup-links.sh
#

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"
SOURCE_FILE="$PROJECT_ROOT/CLAUDE.md"

if [ ! -f "$SOURCE_FILE" ]; then
    echo "Error: CLAUDE.md not found at $SOURCE_FILE"
    exit 1
fi

# Detect if we should use copies instead of symlinks.
# On Windows (Git Bash/MSYS/Cygwin), symlinks may not work without
# Developer Mode enabled, so we default to copies.
USE_COPY=false
case "$(uname -s)" in
    CYGWIN*|MINGW*|MSYS*)
        USE_COPY=true
        ;;
esac

# Allow forcing copy mode via flag
if [ "${1:-}" = "--copy" ]; then
    USE_COPY=true
fi

# link_or_copy <target> <link_path>
#   target:    relative path from link_path's directory to CLAUDE.md
#   link_path: absolute path where the link/copy should be created
link_or_copy() {
    local target="$1"
    local link_path="$2"
    local link_dir
    link_dir="$(dirname "$link_path")"

    # Ensure parent directory exists
    mkdir -p "$link_dir"

    # Remove existing file/link
    if [ -e "$link_path" ] || [ -L "$link_path" ]; then
        rm "$link_path"
    fi

    if [ "$USE_COPY" = true ]; then
        cp "$SOURCE_FILE" "$link_path"
        echo "  Copied  -> $(basename "$link_path")"
    else
        ln -s "$target" "$link_path"
        echo "  Linked  -> $(basename "$link_path") -> $target"
    fi
}

echo "Setting up AI tool configuration files..."
echo "Source: CLAUDE.md"
if [ "$USE_COPY" = true ]; then
    echo "Mode: copy (Windows-compatible)"
else
    echo "Mode: symlink"
fi
echo ""

# Root-level links (target: CLAUDE.md)
link_or_copy "CLAUDE.md" "$PROJECT_ROOT/.cursorrules"
link_or_copy "CLAUDE.md" "$PROJECT_ROOT/.clinerules"
link_or_copy "CLAUDE.md" "$PROJECT_ROOT/.windsurfrules"
link_or_copy "CLAUDE.md" "$PROJECT_ROOT/instructions.md"

# Nested links (target: ../CLAUDE.md)
link_or_copy "../CLAUDE.md" "$PROJECT_ROOT/.continue/instructions.md"
link_or_copy "../CLAUDE.md" "$PROJECT_ROOT/.gemini/instructions.md"

echo ""
echo "Done! All AI tool config files are set up."
if [ "$USE_COPY" = true ]; then
    echo ""
    echo "Note: Files were copied. If you update CLAUDE.md, run this script"
    echo "again to sync changes to all tool config files."
fi
