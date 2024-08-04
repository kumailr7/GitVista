#!/bin/bash

# Display options to the user
choice=$(gum choose "🚀 Push to Git" "🔄 Pull from Git" "🔍 Status" "🛠️ Configure")

case $choice in
    "🚀 Push to Git")
        echo "Pushing to Git..."
        git push origin main
        ;;
    "🔄 Pull from Git")
        echo "Pulling from Git..."
        git pull origin main
        ;;
    "🔍 Status")
        echo "Showing Git status..."
        git status
        ;;
    "🛠️ Configure")
        echo "Configuring Git settings..."
        # Add configuration commands here if needed
        ;;
    *)
        echo "Invalid choice. Please select a valid option."
        ;;
esac
