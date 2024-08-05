#!/bin/bash

# Function to push changes
push_changes() {
    echo " "
    # Ask for confirmation to push the changes
    if gum confirm "🚀 Ready to blast off and push the commit to the remote? 🌌"; then
        echo "$(gum style --italic --foreground 80 'Damn, enjoy your code going live! 🎉🚀')"
        echo " "
        
        # Run git push and store the output
        push_output=$(git push 2>&1)

        # Vibrate the output with gum
        echo "$push_output" | gum style --border rounded --padding "1 2" --width 80 --margin "1" --foreground 82 --bold

    else
        echo "$(gum style --italic --foreground 70 'Alright, no space travel today. 🌠 Maybe next time! 🚀👨‍🚀')"
    fi
}