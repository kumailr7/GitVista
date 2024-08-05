#!/bin/bash 

# Function to add files
add_files() {
    local ADD="Add All Files"
    local ADD_ONE="Add One File"
    local RESET="Reset"

    # Prompt the user to choose an action (Add All Files, Add One File, or Reset)
    local ACTION=$(gum choose "$ADD" "$ADD_ONE" "$RESET")

    # Perform the chosen action
    if [ "$ACTION" == "$ADD" ]; then
        # Add all files to the staging area
        git add .
    elif [ "$ACTION" == "$ADD_ONE" ]; then
        # Add selected file to the staging area
        git status --short | cut -c 4- | gum choose | xargs git add
    else
        # Restore selected files to their previous state
        git status --short | cut -c 4- | gum choose --no-limit | xargs git restore
    fi
}