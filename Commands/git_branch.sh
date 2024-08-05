#!/bin/bash

# Function to create or delete a branch
manage_branch() {
    # Ask the user if they want to create or delete a branch
    local action
    action=$(gum choose "Create a new branch 🌿" "Delete an existing branch 🗑️")

    if [[ "$action" == "Create a new branch 🌿" ]]; then
        # Ask for the branch name with a styled prompt
        local branch_name
        branch_name=$(gum input --placeholder "Enter the new branch name 🌿" --prompt "📢 New Branch: ")

        # Check if the branch name is empty
        if [ -z "$branch_name" ]; then
            echo "$(gum style --foreground 160 --bold '❌ Branch name cannot be empty! Please try again.')"
            return
        fi

        # Confirm branch creation
        if gum confirm "Do you want to create the branch \"$branch_name\"?"; then
            # Create the branch and capture the output
            branch_output=$(git branch "$branch_name" 2>&1)

            # Check if the branch creation was successful
            if [ $? -eq 0 ]; then
                echo "$(gum style --foreground 82 --bold '🌿 Branch created successfully: '$branch_name'')"
            else
                echo "$(gum style --foreground 160 --bold '❌ Failed to create branch: '$branch_output'')"
            fi
        else
            echo "$(gum style --foreground 214 --bold '⚠️ Branch creation canceled.')"
        fi
    elif [[ "$action" == "Delete an existing branch 🗑️" ]]; then
        # Ask for the branch name to delete with a styled prompt
        local branch_name
        branch_name=$(gum input --placeholder "Enter the branch name to delete 🗑️" --prompt "📢 Delete Branch: ")

        # Check if the branch name is empty
        if [ -z "$branch_name" ]; then
            echo "$(gum style --foreground 160 --bold '❌ Branch name cannot be empty! Please try again.')"
            return
        fi

        # Confirm branch deletion
        if gum confirm "Are you sure you want to delete the branch '$branch_name'? This action cannot be undone."; then
            # Delete the branch and capture the output
            branch_output=$(git branch -d "$branch_name" 2>&1)

            # Check if the branch deletion was successful
            if [ $? -eq 0 ]; then
                echo "$(gum style --foreground 196 --bold '😢 Oh no! The branch has been deleted: '$branch_name'')"
            else
                echo "$(gum style --foreground 160 --bold '❌ Failed to delete branch: '$branch_output'')"
            fi
        else
            echo "$(gum style --foreground 214 --bold '⚠️ Branch deletion canceled.')"
        fi
    else
        echo "$(gum style --foreground 160 --bold '❌ Invalid action selected.')"
    fi
}



