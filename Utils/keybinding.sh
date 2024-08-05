#!/bin/bash

# Function to handle keypress event
handle_keypress() {
    local key
    echo -n "Press 'm' to open the Git menu or 'q' to quit: "
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
}


