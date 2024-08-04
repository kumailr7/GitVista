#!/bin/bash

# Check if git is installed
if ! command -v git &> /dev/null
then
    echo "git could not be found. Please install git first."
    exit
fi

# Run git status and store the output
status_output=$(git status)

# Use gum to format the output
formatted_output=$(echo "$status_output" | while read -r line; do
    if [[ "$line" == "On branch"* ]]; then
        echo "$(gum style --foreground 99 --bold "$line")"
    elif [[ "$line" == "Your branch is ahead of"* ]]; then
        echo "$(gum style --foreground 178 "$line")"
    elif [[ "$line" == "Changes to be committed:"* ]]; then
        echo "$(gum style --foreground 34 --bold "$line")"
    elif [[ "$line" == "Changes not staged for commit:"* ]]; then
        echo "$(gum style --foreground 208 --bold "$line")"
    elif [[ "$line" == "Untracked files:"* ]]; then
        echo "$(gum style --foreground 196 --bold "$line")"
    else
        echo "$line"
    fi
done)

# Print the formatted output
echo "$formatted_output" | gum style --padding "1 2" --margin "1 0" --align left --width 80