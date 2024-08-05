#!/bin/bash

# Function to commit changes
commit_changes() {
    # Display a bold and centered header using gum
     display_header "📝 Git Commit 📝" 219

    echo " "

    # Define the commit types with colors
    local COMMIT_TYPES=(
        "$(gum style --foreground 202 --bold '🐛 fix: Bug fix')"
        "$(gum style --foreground 114 --bold '✨ feat: New feature')"
        "$(gum style --foreground 33 --bold '📝 docs: Documentation changes')"
        "$(gum style --foreground 160 --bold '💄 style: Code style changes')"
        "$(gum style --foreground 39 --bold '♻️ refactor: Code refactoring')"
        "$(gum style --foreground 226 --bold '⚡ perf: Performance improvement')"
        "$(gum style --foreground 76 --bold '✅ test: Add or update tests')"
        "$(gum style --foreground 171 --bold '🔧 build: Build system changes')"
        "$(gum style --foreground 63 --bold '⚙️ ci: CI configuration changes')"
    )


    echo -e "Select the type of change you're committing: $(gum style --italic --foreground 98 '(use arrow keys)')"

    # Prompt the user to choose a commit type
    local SELECTED_TYPE=$(printf "%s\n" "${COMMIT_TYPES[@]}" | gum choose)

    echo " "

    # Extract type from the selected commit type
    local TYPE=$(echo "$SELECTED_TYPE" | cut -d ' ' -f 2- | cut -d ':' -f 1)

    # Ask for the scope of the change (class or file name)
    echo -e "Specify the files or class name that you've changed: $(gum style --italic --foreground 99 '(e.g.,app.py)')?\n"
    local SCOPE=$(gum input --placeholder "Enter the scope of the change")

    # Since the scope is optional, wrap it in parentheses if it has a value
    test -n "$SCOPE" && SCOPE="($SCOPE)"

    echo -e "Write a short and imperative summary of the code changes: $(gum style --italic --foreground 99 '(lower case and no period)')?\n"
    # Pre-populate the input with the type(scope): so that the user may change it
    local SUMMARY=$(gum input --placeholder "Summary of this change")

    echo -e "Provide additional contextual information about the code changes: $(gum style --italic --foreground 99 '(lower case and no period)')?\n"
    local DESCRIPTION=$(gum write --placeholder "Details of this change")

    echo -e $(gum style --italic --bold --foreground 99 'Tailsman will scans your files for git-leaks before commit')

    echo " "

    # Function to display styled commit output
    local output="$1"
    echo "$(gum style --foreground 45 --bold "$output")"
    

    # Function to commit changes if user confirms
    local TYPE="$1"
    local SCOPE="$2"
    local SUMMARY="$3"
    local DESCRIPTION="$4"

    # Commit these changes if user confirms
    if gum confirm "Commit changes?"; then
        commit_output=$(git commit -m "$TYPE:$SCOPE: $SUMMARY" -m "$DESCRIPTION" 2>&1)
        styled_commit_output "$commit_output"
    fi
    

    # # Commit these changes if user confirms
    # if gum confirm "Commit changes?"; then
    #     git commit -m "$TYPE:$SCOPE: $SUMMARY" -m "$DESCRIPTION"
    # fi
}

