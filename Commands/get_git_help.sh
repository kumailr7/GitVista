#!/bin/bash

# Function to get Git command help from the Python script
get_git_help() {
    local command=$(gum input --placeholder "Git command")

    # Display spinner with vibrant text and emoji while fetching help text
    local help_text
    help_text=$(gum spin -s pulse --title "$(gum style --foreground 33 --bold '🧠 AI is getting the response...')" -- \
        bash -c "python3 ./Utils/get_gemini_help.py '$command'")

    # Apply ANSI escape codes for bold and color formatting
    help_text=$(echo "$help_text" | sed \
        -e 's/\*\*\(.*\)\*\*/\x1b[1m\1\x1b[0m/g' \
        -e 's/`\(.*\)`/\x1b[32m\1\x1b[0m/g')

    # Display the help text in a horizontal rectangle with gum style
    echo -e "$help_text" | gum style --border rounded --padding "1 2" --width 100 --margin "1" --foreground 217
}