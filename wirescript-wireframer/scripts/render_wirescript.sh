#!/usr/bin/env bash
set -euo pipefail

usage() {
  cat <<'EOF'
Usage:
  render_wirescript.sh <input.wire> [output_dir] [--png|--html|--both]

Examples:
  render_wirescript.sh wireframes/home.wire
  render_wirescript.sh wireframes/home.wire wireframes --both
EOF
}

if [[ "${1:-}" == "-h" || "${1:-}" == "--help" || "${1:-}" == "" ]]; then
  usage
  exit 0
fi

input_file="$1"
output_dir="${2:-$(dirname "$input_file")}"
mode="${3:---png}"
base_name="$(basename "$input_file" .wire)"
html_out="$output_dir/$base_name.html"
png_out="$output_dir/$base_name.png"

if [[ ! -f "$input_file" ]]; then
  echo "Input file not found: $input_file" >&2
  exit 1
fi

mkdir -p "$output_dir"

case "$mode" in
  --png)
    format="png"
    ;;
  --html)
    format="html"
    ;;
  --both)
    format="both"
    ;;
  *)
    echo "Unknown mode: $mode" >&2
    usage
    exit 1
    ;;
esac

run_with_cli_verify() {
  wirescript verify "$input_file"
}

run_with_cli_html() {
  wirescript render "$input_file" > "$html_out"
}

run_with_cli_png() {
  wirescript render "$input_file" -f png -o "$png_out"
}

run_with_docker_verify() {
  docker compose run --rm wirescript wirescript verify "$input_file"
}

run_with_docker_html() {
  docker compose run --rm wirescript wirescript render "$input_file" > "$html_out"
}

run_with_docker_png() {
  docker compose run --rm wirescript wirescript render "$input_file" -f png -o "$png_out"
}

run_with_npx_verify() {
  npx wirescript verify "$input_file"
}

run_with_npx_html() {
  npx wirescript render "$input_file" > "$html_out"
}

run_with_npx_png() {
  npx wirescript render "$input_file" -f png -o "$png_out"
}

if command -v wirescript >/dev/null 2>&1; then
  run_with_cli_verify
  if [[ "$format" == "html" || "$format" == "both" ]]; then
    run_with_cli_html
  fi
  if [[ "$format" == "png" || "$format" == "both" ]]; then
    run_with_cli_png
  fi
elif [[ -f "docker-compose.yml" ]] && command -v docker >/dev/null 2>&1; then
  run_with_docker_verify
  if [[ "$format" == "html" || "$format" == "both" ]]; then
    run_with_docker_html
  fi
  if [[ "$format" == "png" || "$format" == "both" ]]; then
    run_with_docker_png
  fi
elif command -v npx >/dev/null 2>&1; then
  run_with_npx_verify
  if [[ "$format" == "html" || "$format" == "both" ]]; then
    run_with_npx_html
  fi
  if [[ "$format" == "png" || "$format" == "both" ]]; then
    run_with_npx_png
  fi
else
  echo "No WireScript runner found. Install wirescript CLI, or run from a repo with docker-compose.yml." >&2
  exit 1
fi

echo "Validated and rendered '$input_file' into '$output_dir'."
