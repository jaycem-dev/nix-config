#!/usr/bin/env bash
# List Windows executables (.exe) shipped with installed Steam games.
#
# Scans every Steam library declared in libraryfolders.vdf, plus the usual
# fallback locations, and skips Proton/runtime and Windows-only support
# folders (redistributables, installers, anti-cheat, etc.).

declare -a roots=()

add_root() {
  local common r

  common="$(realpath -e "$1/steamapps/common" 2>/dev/null)" || return 0
  [[ -d "$common" ]] || return 0

  for r in ${roots[@]+"${roots[@]}"}; do
    [[ "$r" == "$common" ]] && return 0
  done

  roots+=("$common")
}

# Libraries registered with Steam.
vdf="$HOME/.local/share/Steam/steamapps/libraryfolders.vdf"
if [[ -f "$vdf" ]]; then
  while IFS= read -r lib; do
    add_root "$lib"
  done < <(sed -n 's/^[[:space:]]*"path"[[:space:]]*"\(.*\)".*/\1/p' "$vdf")
fi

# Fallbacks in case the vdf is missing or stale.
add_root "$HOME/.local/share/Steam"
for mnt in /mnt/*/SteamLibrary /mnt/*/steamlibrary; do
  add_root "$mnt"
done

if ((${#roots[@]} == 0)); then
  echo "No Steam libraries found." >&2
  exit 1
fi

# Directory names to skip: Proton/Wine runtimes and Windows-only
# support/redistributable folders. fd's --exclude is case-sensitive, so use
# character classes where the casing varies.
skip_names=(
  'Lossless Scaling'
  '[Pp]roton*'
  'SteamLinuxRuntime*'
  'Steamworks Common Redistributables'
  'Steam Controller Configs'
  '*[Rr]edist*'
  '[Dd]irect[Xx]'
  '[Dd]otnet'
  '*[Ii]nstaller*'
  '[Ss]upport'
  '[Mm]anual'
  '[Ee]asy[Aa]nti[Cc]heat'
  '[Bb]attl[Ee]ye'
)

fd_args=()
for name in "${skip_names[@]}"; do
  fd_args+=(--exclude "$name")
done

# Print paths relative to each library's steamapps/common directory.
fd --type f --extension exe --hidden --no-ignore "${fd_args[@]}" . "${roots[@]}" \
  | sed 's|.*/steamapps/common/||' \
  | sort -u
