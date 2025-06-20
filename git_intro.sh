#!/bin/bash

# Load API key
source Utils/load_api_key.sh

# Source command scripts
source Commands/git_push.sh
source Commands/git_add.sh
source Commands/git_status.sh
source Commands/get_git_help.sh
source Commands/git_commit.sh

# Utility: display a styled header
display_header() {
  local header_text="$1"
  local color="$2"
  echo "$(gum style --align center --bold --foreground "$color" "$header_text")"
}

# Main menu
git_vista() {
  local header_color="35"
  local subtitle_color="33"
  local prompt_color="36"
  local prompt_italic="--italic"

  local header=$(gum style --foreground "$header_color" --bold --underline "🚀 GIT VISTA 🚀")
  local subtitle=$(gum style --foreground "$subtitle_color" --italic "✨ Your Interactive Git Tool ✨")
  local prompt=$(gum style --foreground "$prompt_color" $prompt_italic "🔧 Choose an option:")

  gum style \
    --foreground 212 --border-foreground 218 --border "rounded" --width 40 --align "center" \
    --margin "1 1" --padding "2 4" \
    "${header}" "${subtitle}"

  local options=(
    "$(gum style --foreground 34 --bold '1. Git Command Help (AI-Guide) 📚')"
    "$(gum style --foreground 39 --bold '2. Commit and Push Your Files 📝🚀')"
    "$(gum style --foreground 56 --bold '3. Create New Branch 🌿')"
    "$(gum style --foreground 23 --bold '4. Git Config ⚙️')"
  )

  echo "$prompt"
  local selected_option=$(printf "%s\n" "${options[@]}" | gum choose --height 10 --cursor.foreground 212)

  echo "Selected option: '$selected_option'"

  case "$selected_option" in
    "1. Git Command Help (AI-Guide) 📚")
      echo "$(gum style --foreground 20 --bold 'You selected Git Command Help (AI-Guide) 📚')"
      echo
      display_header "🚀 Git Help (AI-Guide) 🚀" 216
      if gum confirm "🤔 Do you need help with a Git command?"; then
        echo
        get_git_help
      fi
      echo
      ;;

    "2. Commit and Push Your Files 📝🚀")
      clear
      echo "$(gum style --foreground 34 --bold 'You selected Commit and Push Your Files 📝🚀')"
      echo
      display_header "📁 Git Add 📁" 218
      add_files
      echo

      display_header " 🔄 Git Status 🔄 " 216
      git_status

      commit_changes
      push_changes
      ;;
    "3. Create New Branch 🌿")
      echo "$(gum style --foreground 82 --bold '🌱 Awesome! You selected Create New Branch 🌿. Let’s branch out and create something new!')"
      ;;
    "4. Git Config ⚙️")
      echo "$(gum style --foreground 33 --bold '🔧 Great choice! You selected Git Config ⚙️. Let’s get your configuration sorted!')"
      ;;
    *)
      echo "$(gum style --foreground 160 --bold '😕 Oops! That option seems to be invalid. Please try again.')"
      ;;
  esac
}
