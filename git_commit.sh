#!/bin/bash

# Clear the terminal screen
clear

# Load API Key from .env
load_api_key() {
    if [ -f .env ]; then
        export $(grep -v '^#' .env | xargs)
    fi
}


# Function to get Git command help from the Python script
get_git_help() {
    local command=$(gum input --placeholder "Git command")

    # Display spinner with vibrant text and emoji while fetching help text
    local help_text
    help_text=$(gum spin -s pulse --title "$(gum style --foreground 33 --bold '🧠 AI is getting the response...')" -- \
        bash -c "python3 get_gemini_help.py '$command'")

    # Apply ANSI escape codes for bold and color formatting
    help_text=$(echo "$help_text" | sed \
        -e 's/\*\*\(.*\)\*\*/\x1b[1m\1\x1b[0m/g' \
        -e 's/`\(.*\)`/\x1b[32m\1\x1b[0m/g')

    # Display the help text in a horizontal rectangle with gum style
    echo -e "$help_text" | gum style --border rounded --padding "1 2" --width 80 --margin "1" --foreground 217
}

# Function to display a header
display_header() {
    local header_text="$1"
    local color="$2"
    echo "$(gum style --align center --bold --foreground $color "$header_text")"
}

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

# # Function to commit changes
# commit_changes() {
#     # Display a bold and centered header using gum
#      display_header "📝 Git Commit 📝" 219

#     echo " "

#     # Define the commit types
#     local COMMIT_TYPES=(
#         "🐛 fix: Bug fix"
#         "✨ feat: New feature"
#         "📝 docs: Documentation changes"
#         "💄 style: Code style changes"
#         "♻️ refactor: Code refactoring"
#         "⚡ perf: Performance improvement"
#         "✅ test: Add or update tests"
#         "🔧 build: Build system changes"
#         "⚙️ ci: CI configuration changes"
#     )

#     echo -e "Select the type of change you're committing: $(gum style --italic --foreground 98 '(use arrow keys)')"

#     # Prompt the user to choose a commit type
#     local SELECTED_TYPE=$(printf "%s\n" "${COMMIT_TYPES[@]}" | gum choose)

#     echo " "

#     # Extract type from the selected commit type
#     local TYPE=$(echo "$SELECTED_TYPE" | cut -d ' ' -f 2- | cut -d ':' -f 1)

#     # Ask for the scope of the change (class or file name)
#     echo -e "Specify the file or class name that you've changed: $(gum style --italic --foreground 99 '(e.g., app.py)')?\n"
#     local SCOPE=$(gum input --placeholder "Enter the scope of the change")

#     # Since the scope is optional, wrap it in parentheses if it has a value
#     test -n "$SCOPE" && SCOPE="($SCOPE)"

#     echo -e "Write a short and imperative summary of the code changes: $(gum style --italic --foreground 99 '(lower case and no period)')?\n"
#     # Pre-populate the input with the type(scope): so that the user may change it
#     local SUMMARY=$(gum input --placeholder "Summary of this change")

#     echo -e "Provide additional contextual information about the code changes: $(gum style --italic --foreground 99 '(lower case and no period)')?\n"
#     local DESCRIPTION=$(gum write --placeholder "Details of this change")

#     echo -e $(gum style --italic --bold --foreground 99 'Tailsman will scans your files for git-leaks before commit')

#     echo " "

#     # Commit these changes if user confirms
#     if gum confirm "Commit changes?"; then
#         git commit -m "$TYPE:$SCOPE: $SUMMARY" -m "$DESCRIPTION"
#     fi
# }

# Function to commit changes
commit_changes() {
    # Display a bold and centered header using gum
    echo -e "$(gum style --border rounded --padding "1 2" --width 80 --margin "1" --foreground 219 "📝 Git Commit 📝")"

    echo " "

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

    echo -e "$(gum style --border rounded --padding "1 2" --width 80 --margin "1" --foreground 219 --bold "Select the type of change you're committing: (use arrow keys)")"
    local SELECTED_TYPE=$(printf "%s\n" "${COMMIT_TYPES[@]}" | gum choose)

    echo " "

    # Extract type from the selected commit type
    local TYPE=$(echo "$SELECTED_TYPE" | cut -d ' ' -f 2- | cut -d ':' -f 1)

    # Ask for the scope of the change (class or file name)
    echo -e "$(gum style --border rounded --padding "1 2" --width 80 --margin "1" --foreground 219 --italic "Specify the file or class name that you've changed: (e.g., app.py)?")"
    local SCOPE=$(gum input --placeholder "Enter the scope of the change")

    # Since the scope is optional, wrap it in parentheses if it has a value
    test -n "$SCOPE" && SCOPE="($SCOPE)"

    echo -e "$(gum style --border rounded --padding "1 2" --width 80 --margin "1" --foreground 219 --italic "Write a short and imperative summary of the code changes: (lower case and no period)?")"
    local SUMMARY=$(gum input --placeholder "Summary of this change")

    echo -e "$(gum style --border rounded --padding "1 2" --width 80 --margin "1" --foreground 219 --italic "Provide additional contextual information about the code changes: (lower case and no period)?")"
    local DESCRIPTION=$(gum write --placeholder "Details of this change")

    echo -e "$(gum style --border rounded --padding "1 2" --width 80 --margin "1" --foreground 219 --italic --bold 'Tailsman will scan your files for git-leaks before commit')"

    echo " "

    # Commit these changes if user confirms
    if gum confirm "Commit changes?"; then
        git commit -m "$TYPE:$SCOPE: $SUMMARY" -m "$DESCRIPTION"
    fi
}


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

# Function to display Git status
git_status() {
    # Fetch Git status output
    local status_output=$(git status)

    # Apply formatting and colors to the Git status output
    status_output=$(echo "$status_output" | sed \
        -e 's/On branch/\\033[1mOn branch\\033[0m/' \
        -e 's/Your branch/\\033[1mYour branch\\033[0m/' \
        -e 's/Changes not staged for commit:/\\033[33mChanges not staged for commit:\\033[0m/' \
        -e 's/Untracked files:/\\033[31mUntracked files:\\033[0m/' \
        -e 's/\(modified:\)/\\033[34m\1\\033[0m/' \
        -e 's/\(use "git add <file>...\)/\\033[36m\1\\033[0m/' \
        -e 's/\(use "git restore <file>...\)/\\033[36m\1\\033[0m/')

    # Display the formatted Git status output
    echo -e "$status_output" | gum style --border rounded --padding "1 2" --width 80 --margin "1" --foreground 217
}

# Main function
main() {
    # Vibrant header with emoji
    display_header() {
        local header_text="$1"
        local color="$2"
        echo "$(gum style --align center --bold --foreground "$color" "$header_text")"
    }

    # Display Git Help Guide
    display_header "🚀 Git Help (AI-Guide) 🚀" 216
    if gum confirm "🤔 Do you need help with a Git command?"; then
        echo " "
        get_git_help
    fi
    echo " "

    # Add Files Section
    display_header "📁 Git Add 📁" 218
    add_files
    echo " "

    # Display Git Status    
    display_header " 🔄 Git Status 🔄 " 216
    git_status

    # Commit Changes
    commit_changes

    # Push Changes
    push_changes
}


# Load the API key
load_api_key

# Run the main function
main
