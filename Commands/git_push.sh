#!/bin/bash

push_changes() {
  echo " "

  # Get current branch
  local current_branch=$(git symbolic-ref --short HEAD)

  # Check if it's a new branch
  local branch_status=$(git status)
  local is_new_branch=$(echo "$branch_status" | grep -q "Your branch is based on 'origin/$current_branch'" && echo "false" || echo "true")

  if gum confirm "🚀 Ready to blast off and push the commit to the remote? 🌌"; then
    echo " "
    echo "$(gum style --foreground 226 --bold "🛫 Initiating Super Fancy Launch Sequence!")"
    echo " "

    # Super Fancy Rocket Animation 🚀✨
    rocket_stages=(
      "🕑 Countdown: 3..."
      "🕐 Countdown: 2..."
      "🕛 Countdown: 1..."
      "🚀 Ignition..."
    )

    for stage in "${rocket_stages[@]}"; do
      echo "$(gum style --foreground 45 "$stage")"
      sleep 0.5
    done

    # Rocket flying animation
    echo " "
    rocket="🚀"
    trail=""
    for i in {1..20}; do
      printf "\r%s%s" "$trail" "$rocket"
      trail+="✨"
      sleep 0.05
    done
    echo " "
    echo "$(gum style --foreground 226 --bold "🌌 Rocket has left the launch pad! Initiating push...")"
    echo " "

    # Spinner while pushing
    if [ "$is_new_branch" == "true" ]; then
      push_output=$(gum spin --spinner monkey --title "✨ Setting upstream and pushing new branch '$current_branch' to remote..." -- git push --set-upstream origin "$current_branch" 2>&1)
    else
      push_output=$(gum spin --spinner monkey --title "🚀 Pushing branch '$current_branch' to remote..." -- git push 2>&1)
    fi

    echo " "
    gum style --foreground 82 --bold "✅ Push Complete! Here's the log:"
    echo "$push_output" | gum format --type=code | gum pager

  else
    echo "$(gum style --italic --foreground 159 "❌ Launch aborted. Maybe next orbit! 🌌🚫")"
  fi
}

