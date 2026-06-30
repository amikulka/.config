#!/usr/bin/env zsh
# 1Password-backed secret access.
#
# Contains ONLY op:// references and helper functions — never secret values.
# Safe to commit. Secrets resolve on-demand via the 1Password CLI (`op`),
# gated by Touch ID, and are never persisted in the shell environment.

export OP_ACCOUNT_DEBTSY="debtsy.1password.com"

# Run a command with Datadog credentials injected ephemerally from 1Password.
# The secrets exist only inside the spawned process — never exported to the
# parent shell, so other processes (incl. agent tooling) can't read them.
#   Usage: dd-run <command> [args...]
#   e.g.   dd-run uv run my-datadog-script.py
dd-run() {
  OP_ACCOUNT="$OP_ACCOUNT_DEBTSY" \
    op run --env-file="$HOME/.config/zsh/datadog.env" -- "$@"
}

# Escape hatch: export DD_API_KEY / DD_APP_KEY into the CURRENT shell.
# This re-pollutes the environment for this shell's lifetime — prefer dd-run.
# Use only for interactive sessions where a tool insists on reading the env.
dd-export() {
  DD_API_KEY="$(OP_ACCOUNT="$OP_ACCOUNT_DEBTSY" op read 'op://Employee/DD API Key/credential')" || return 1
  DD_APP_KEY="$(OP_ACCOUNT="$OP_ACCOUNT_DEBTSY" op read 'op://Employee/DD API Key/username')" || return 1
  export DD_API_KEY DD_APP_KEY
  print "DD_API_KEY / DD_APP_KEY exported to this shell only."
}

# Print the GitHub PAT to stdout on-demand (Touch ID gated). Nothing currently
# reads it — `gh` uses its own keyring — but kept for ad-hoc script use:
#   GITHUB_PERSONAL_ACCESS_TOKEN="$(gh-pat)" some-command
# Referenced by item/field ID because the item title contains parentheses,
# which break op:// path parsing.
gh-pat() {
  OP_ACCOUNT="$OP_ACCOUNT_DEBTSY" \
    op read 'op://Employee/o74zzmqbw5sdls4krpplhji2q4/pcukzyksfqxlqd4dxbla6gyore'
}
