function ksession() {
  local session=$1
  local dir=$2

  if [[ -z "$session" || -z "$dir" ]]; then
    echo "Usage: ksession <session_name> <project_dir>"
    return 1
  fi

  local session_file="$HOME/.dotfiles/kitty/sessions/${session}.conf"

  if [[ ! -f "$session_file" ]]; then
    echo "Session file not found: $session_file"
    return 1
  fi

  kitty --session "$session_file" \
        --detach \
        --single-instance \
        --directory "$dir" \
        -- start-as=maximized
}
