#!/bin/bash

# Source utility functions
source Utils/load_api_key.sh

# Source command scripts
source Commands/git_push.sh
source Commands/git_add.sh
source Commands/git_status.sh
source Commands/get_git_help.sh
source Commands/git_commit.sh
source Commands/git_branch.sh
source Commands/list_branches.sh

# Function to display the menu and perform actions
git_vista() {
  # Define colors
  local header_color="35"    # Magenta
  local subtitle_color="33"  # Yellow
  local prompt_color="36"    # Cyan
  local prompt_italic="--italic"

  # Header and prompt configuration with colors and styles
  local header=$(gum style --foreground "$header_color" --bold --underline "🚀 GIT VISTA 🚀")
  local subtitle=$(gum style --foreground "$subtitle_color" --italic "✨ Your Interactive Git Tool ✨")
  local prompt=$(gum style --foreground "$prompt_color" $prompt_italic "🔧 Choose an option:")
  
  gum style \
	--foreground 212 --border-foreground 218 --border "rounded" --width 40 --align "center" \
	--margin "1 1" --padding "2 4" \
  "${header}"  "${subtitle}" 
  # Define options with gum style
  local options=(
    "$(gum style --foreground 34 --bold '1. Git Command Help (AI-Guide) 📚')"
    "$(gum style --foreground 39 --bold '2. Commit and Push Your Files 📝🚀')"
    "$(gum style --foreground 56 --bold '3. Create New Branch 🌿 or Delete an Existing Branch 🗑️')"
    "$(gum style --foreground 23 --bold '4. Git Config ⚙️')"
  )

  # # Display the header
  # gum style \
  #   --foreground 212 --border-foreground 212 \
  #   "$header" \
  #   "$subtitle"

  echo "$prompt"
  # Display the menu and capture the selected option
  local selected_option=$(printf "%s\n" "${options[@]}" | gum choose --height 10 --cursor.foreground 212)

  # Debug: Print the selected option to ensure it matches
  echo "Selected option: '$selected_option'"

  # Function to display a header with color
  display_header() {
    local header_text="$1"
    local color="$2"
    echo "$(gum style --align center --bold --foreground "$color" "$header_text")"
  }

  # Perform the corresponding action based on the selected option
  case "$selected_option" in
    "1. Git Command Help (AI-Guide) 📚")
      echo "$(gum style --foreground 20 --bold 'You selected Git Command Help (AI-Guide) 📚')"
      echo " "
      display_header "🚀 Git Help (AI-Guide) 🚀" 216
      if gum confirm "🤔 Do you need help with a Git command?"; then
        echo " "
        get_git_help
      fi
      echo " "
      ;;

    "2. Commit and Push Your Files 📝🚀")
      clear
      echo "$(gum style --foreground 34 --bold 'You selected Commit and Push Your Files 📝🚀')"
      echo " "
      display_header "📁 Git Add 📁" 218
      add_files
      echo " "

      display_header " 🔄 Git Status 🔄 " 216
      git_status

      commit_changes
      push_changes
      ;;
    "3. Create New Branch 🌿 or Delete an Existing Branch 🗑️")
      echo "$(gum style --foreground 82 --bold '🌱 You chose to Create a New Branch 🌿 or Delete an Existing Branch 🗑️. Let’s get it done!')"
      manage_branch
      echo " "
      list_branches
      echo " "
      ;;
    "4. Git Config ⚙️")
      echo "$(gum style --foreground 33 --bold '🔧 Great choice! You selected Git Config ⚙️. Let’s get your configuration sorted!')"
      echo " "
      ;;
    *)
      echo "$(gum style --foreground 160 --bold '😕 Oops! That option seems to be invalid. Please try again.')"
      ;;
  esac
}



# Function to handle keypress event
handle_keypress() {
    local key
    echo -n "Press 'm' to open the Git menu or 'q' to quit: "
    while true; do
        read -n 1 key
        case $key in
            m|M)
                git_vista
                ;;
            q|Q)
                echo "$(gum style --foreground 160 --bold '👋 Quitting...')"
                exit 0
                ;;
            *)
                echo "$(gum style --foreground 160 --bold '❓ Invalid key. Press "m" to open the menu or "q" to quit.')"
                ;;
        esac
    done
}

# Main workflow
echo "$(gum style --foreground 34 --bold 'Starting your Git workflow. Press "m" anytime to access the menu or "q" to quit.')"
while true; do
    # Call the keypress handler
    handle_keypress
    # You can add your other workflow commands here, e.g., Git commands
done