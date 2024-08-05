#!/bin/bash

# Function to list all branches
list_branches() {
    # Get the list of branches
    branch_list=$(git branch 2>&1)
    
    # Check if the command was successful
    if [ $? -eq 0 ]; then
        echo "$(gum style --foreground 46 --bold '🌟 Here are your branches:')"
        echo "$branch_list" | gum style --foreground 33 --bold
    else
        echo "$(gum style --foreground 160 --bold '❌ Failed to list branches: $branch_list')"
    fi
}