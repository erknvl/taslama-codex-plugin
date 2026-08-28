#!/bin/sh

set -eu

archive_url="https://github.com/erknvl/taslama-codex-plugin/archive/refs/heads/main.zip"
install_root="${HOME}/Library/Application Support/Taslama"
marketplace_dir="${install_root}/codex-marketplace"
temporary_dir="$(mktemp -d)"
archive_path="${temporary_dir}/taslama-marketplace.zip"
extracted_dir="${temporary_dir}/taslama-codex-plugin-main"

cleanup() {
  rm -rf "${temporary_dir}"
}
trap cleanup EXIT INT TERM

if command -v codex >/dev/null 2>&1; then
  codex_bin="$(command -v codex)"
elif [ -x "/Applications/ChatGPT.app/Contents/Resources/codex" ]; then
  codex_bin="/Applications/ChatGPT.app/Contents/Resources/codex"
else
  echo "Codex was not found. Install or update ChatGPT/Codex, then run this script again." >&2
  exit 1
fi

echo "Downloading the Taslama marketplace..."
curl --fail --location --silent --show-error "${archive_url}" --output "${archive_path}"

if command -v ditto >/dev/null 2>&1; then
  ditto -x -k "${archive_path}" "${temporary_dir}"
elif command -v unzip >/dev/null 2>&1; then
  unzip -q "${archive_path}" -d "${temporary_dir}"
else
  echo "No ZIP extractor was found." >&2
  exit 1
fi

if [ ! -f "${extracted_dir}/.agents/plugins/marketplace.json" ]; then
  echo "The downloaded archive is not a valid Taslama marketplace." >&2
  exit 1
fi

mkdir -p "${install_root}"
rm -rf "${marketplace_dir}"
mv "${extracted_dir}" "${marketplace_dir}"

if "${codex_bin}" plugin list --json 2>/dev/null | grep -q '"pluginId"[[:space:]]*:[[:space:]]*"taslama@taslama"'; then
  "${codex_bin}" plugin remove taslama@taslama >/dev/null
fi

if "${codex_bin}" plugin marketplace list --json 2>/dev/null | grep -q '"name"[[:space:]]*:[[:space:]]*"taslama"'; then
  "${codex_bin}" plugin marketplace remove taslama >/dev/null
fi

"${codex_bin}" plugin marketplace add "${marketplace_dir}"
"${codex_bin}" plugin add taslama@taslama

echo "Opening Taslama authorization..."
"${codex_bin}" mcp login taslama --oauth-client-registration dcr

echo "Taslama is installed and connected. Restart ChatGPT/Codex and open a new task."
