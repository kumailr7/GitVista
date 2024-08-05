#!/bin/bash

# Clear the terminal screen
clear


# Source utility functions
source Utils/load_api_key.sh

# Source command scripts
source Commands/git_add.sh
source Commands/git_status.sh
source Commands/git_push.sh
source Commands/git_commit.sh
source Commands/get_git_help.sh

# Display header function
display_header() {
    local header_text="$1"
    local color="$2"
    echo "$(gum style --align center --bold --foreground "$color" "$header_text")"
}

# Main function
main() {
    display_header "🚀 Git Help (AI-Guide) 🚀" 216
    if gum confirm "🤔 Do you need help with a Git command?"; then
        echo " "
        get_git_help
    fi
    echo " "

    display_header "📁 Git Add 📁" 218
    add_files
    echo " "

    display_header " 🔄 Git Status 🔄 " 216
    git_status

    commit_changes
    push_changes
}

# Load the API key
load_api_key

# Run the main function
main
