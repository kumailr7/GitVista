
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
