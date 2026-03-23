#!/bin/bash
set -euo pipefail

# Set the marketing team project root for all sessions (local and remote).
# This ensures scheduled/automated prompts always find agent files at absolute paths.

MARKETING_ROOT="/home/user/markertingskills"

# Persist MARKETING_ROOT for the entire session so agents can reference it
if [ -n "${CLAUDE_ENV_FILE:-}" ]; then
  echo "export MARKETING_ROOT=\"${MARKETING_ROOT}\"" >> "$CLAUDE_ENV_FILE"
fi

# Verify critical agent files are present
if [ ! -f "${MARKETING_ROOT}/.agents/marketing-team/ORCHESTRATOR.md" ]; then
  echo "WARNING: ORCHESTRATOR.md not found at ${MARKETING_ROOT}/.agents/marketing-team/ORCHESTRATOR.md" >&2
fi
