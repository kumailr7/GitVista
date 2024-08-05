#!/bin/bash

push_changes() {
    echo " "

    # Get the current branch name
    local current_branch=$(git symbolic-ref --short HEAD)

    # Check if the current branch is new
    local branch_status=$(git status)
    local is_new_branch=$(echo "$branch_status" | grep -q "Your branch is based on 'origin/$current_branch'" && echo "false" || echo "true")

    if gum confirm "🚀 Ready to blast off and push the commit to the remote? 🌌"; then
        if [ "$is_new_branch" == "true" ]; then
            # If branch is new, push with --set-upstream
            echo "$(gum style --italic --foreground 226 '🌟 Setting up the new branch and pushing to the remote! 🌠')"
            echo " "
            push_output=$(git push --set-upstream origin "$current_branch" 2>&1)
        else
            # If branch is not new, push normally
            echo "$(gum style --italic --foreground 82 '🚀 Your code is taking off! 🎉')"
            echo " "
            push_output=$(git push 2>&1)
        fi

        # Display push output
        echo "$push_output" | gum style --border rounded --padding "1 2" --width 80 --margin "1" --foreground 82 --bold
    else
        echo "$(gum style --italic --foreground 159 'Alright, no space travel today. 🌠 Maybe next time! 🚀👨‍🚀')"
    fi
}
