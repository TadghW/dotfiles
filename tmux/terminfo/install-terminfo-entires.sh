#!/usr/bin/env bash

set -euo pipefail

script_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
target_dir="${HOME}/.terminfo"

if ! command -v tic >/dev/null 2>&1; then
  echo "error: tic not found in PATH" >&2
  exit 1
fi

mkdir -p "${target_dir}"

installed=0
for entry in "${script_dir}"/*.terminfo; do
  [ -e "${entry}" ] || continue
  echo "Installing $(basename "${entry}") to ${target_dir}"
  tic -x -o "${target_dir}" "${entry}"
  installed=1
done

if [ "${installed}" -eq 0 ]; then
  echo "No .terminfo files found in ${script_dir}" >&2
  exit 1
fi

echo
echo "Installed terminfo entries:"
for entry in "${script_dir}"/*.terminfo; do
  [ -e "${entry}" ] || continue
  name="$(basename "${entry}" .terminfo)"
  infocmp -x -A "${target_dir}" "${name}" >/dev/null 2>&1 && echo "  - ${name}"
done

echo
echo "Current shell TERM: ${TERM:-<unset>}"
if command -v tmux >/dev/null 2>&1; then
  if [ -n "${TMUX:-}" ]; then
    echo "tmux pane TERM: ${TERM:-<unset>}"
    echo "tmux client TERM: $(tmux display-message -p '#{client_termname}' 2>/dev/null || echo '<unknown>')"
  else
    echo "Outside tmux. If you want the terminal tmux sees, start tmux and run:"
    echo "  tmux display-message -p '#{client_termname}'"
  fi
fi
