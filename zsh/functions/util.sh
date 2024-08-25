#!/bin/sh

function gitnukeall() {
    git fetch --prune

    for branch in $(git branch | grep -v "main"); do
        git branch -D "$branch"
    done
    echo "Deleted all branches except 'main'."
}

lines_of_code() {
  local dir="${1:-.}"  # Default to current directory if no argument is provided

  if [ ! -d "$dir" ]; then
    echo "Error: '$dir' is not a valid directory."
    return 1
  fi

  if [ ! -d "$dir/.git" ]; then
    echo "Error: '$dir' is not a Git repository."
    return 1
  fi

  # Define patterns for lock files
  local lock_patterns="package-lock.json|yarn.lock|pnpm-lock.yaml|npm-shrinkwrap.json|composer.lock|Gemfile.lock|Podfile.lock|Cargo.lock|*.lock|.lock|*.yarn.lock|*.pnpm-lock.yaml|*.npm-lock.json|*.yarnrc.yml|*.yarnrc.json|*.package-lock.json|*.npmrc|*.pnpmfile.cjs|*.lockfile|*.flutter-plugins|*.flutter-plugins-dependencies|*.flutter-plugins-dependencies.json|*.flutter-plugins-dependencies.lock|*.flutter-plugins-dependencies.lock.json|*.flutter-plugins-dependencies.yaml|*.flutter-plugins.lock|*.flutter-plugins.yaml|*.flutter-plugins.json|*.flutter-plugins.lock.json|*.flutter-plugins.lock.yaml"

  # Run the command in the specified directory
  (
    cd "$dir" || return
    git ls-files 2>/dev/null | grep -v -E "$lock_patterns" | xargs wc -l 2>/dev/null | sort -n | awk '{printf "\033[0;32m%s\033[0m %s\n", $1, substr($0, index($0, $2))}'
  )
}

urlencode()
{
  local args="$@"
  jq -nr --arg v "$args" '$v|@uri'; 
}

google_search() {
  local query="$*"
  local encoded_query
  encoded_query=$(urlencode "$query")
  local url="https://www.google.com/search?q=$encoded_query"
  google-chrome-stable "$url"
}

open_file() {
    case "$1" in
        *.jpg|*.JPG|*.jpeg|*.JPEG|*.png|*.PNG|*.gif|*.GIF|*.bmp|*.BMP|*.tiff|*.TIFF|*.webp|*.WEBP)
            kitty +kitten icat "$1"
            ;;
        *.pdf|*.PDF|*.doc|*.docx|*.xls|*.xlsx|*.ppt|*.pptx|*.odt|*.ods|*.odp)
            mupdf "$1"
            ;;
        *.mp4|*.mkv|*.flv|*.webm|*.avi|*.mov|*.wmv|*.mpeg|*.mpg|*.ogv|*.3gp)
            mpv "$1"
            ;;
        *)
            bat --theme="Catppuccin Mocha" "$1"
            ;;
    esac
}


# Quick creation of next.js projects
function next() {
  npx create-next-app@latest "$1" --typescript --tailwind --eslint --app --use-pnpm --no-src-dir --no-import-alias --empty
  cd "$1"
}

# Quick creation of next.js RC projects
function nextrc() {
  npx create-next-app@rc "$1" --empty --turbo --typescript --tailwind --eslint --app --use-pnpm --no-src-dir --no-import-alias
  cd "$1"
}

function a() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")"
	yazi "$@" --cwd-file="$tmp"
	if cwd="$(cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
		cd -- "$cwd"
	fi
	rm -f -- "$tmp"
}

backup-current-directory() {
    local current_dir
    current_dir=$(basename "$PWD")
    rm -rf ~/bak/"$current_dir"
    mkdir -p ~/bak/"$current_dir"
    cp -r . ~/bak/"$current_dir"
}
