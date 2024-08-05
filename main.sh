#!/bin/bash

# Clear the terminal screen
clear


source git_intro.sh


# Display header function
display_header() {
    local header_text="$1"
    local color="$2"
    echo "$(gum style --align center --bold --foreground "$color" "$header_text")"
}

# Main function
main() {
    git_vista 
}

# Load the API key
load_api_key

# Run the main function
main

