#!/usr/bin/env bash
set -euo pipefail

required_dirs=(
  "00-inbox"
  "01-references/ai-engineering"
  "01-references/ux-writing"
  "01-references/literature"
  "01-references/science"
  "01-references/tools"
  "02-projects/toss"
  "02-projects/eobchae"
  "03-daily"
  "config/agents/researcher"
  "config/agents/librarian"
  "config/agents/curator"
  "templates"
  "scripts"
)

required_files=(
  "config/interests.md"
  "config/agents/researcher/CLAUDE.md"
  "config/agents/librarian/CLAUDE.md"
  "config/agents/curator/CLAUDE.md"
  "scripts/vault-sync.sh"
  "templates/reference-note-template.md"
  "config/scheduler-prompts.md"
  "RUNBOOK.md"
)

for d in "${required_dirs[@]}"; do
  [[ -d "$d" ]] || { echo "[FAIL] missing dir: $d"; exit 1; }
done

for f in "${required_files[@]}"; do
  [[ -f "$f" ]] || { echo "[FAIL] missing file: $f"; exit 1; }
done

[[ -x scripts/vault-sync.sh ]] || { echo "[FAIL] scripts/vault-sync.sh is not executable"; exit 1; }

grep -q "핵심 관심사" config/interests.md || { echo "[FAIL] interests.md content invalid"; exit 1; }
grep -q "Researcher Agent" config/agents/researcher/CLAUDE.md || { echo "[FAIL] researcher CLAUDE missing heading"; exit 1; }
grep -q "Librarian Agent" config/agents/librarian/CLAUDE.md || { echo "[FAIL] librarian CLAUDE missing heading"; exit 1; }
grep -q "Curator Agent" config/agents/curator/CLAUDE.md || { echo "[FAIL] curator CLAUDE missing heading"; exit 1; }

echo "[PASS] setup validation completed"
