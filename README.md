# GitVista

GitVista is an interactive Git tool that combines the power of Gum for user interactions with Talisman for advanced Git scanning. This open-source project aims to enhance your development workflow by providing insightful file analysis and secure Git operations.

## Features

- **Interactive UI:** Easily manage branches, commits, status checks, and more with Gum-powered menus.
  
- **AI-Powered Git Help:** Instantly understand any Git command with context-aware explanations and examples from Google Gemini.
  
- **Automatic Secret Scanning:** Prevent accidental leaks with Talisman — scan commits and files for secrets.

- **Open Source & Extensible:** Fork, contribute, and help shape the future of GitVista!


## Getting Started

To start using GitVista, follow these steps:

### 1. Clone the Repository:
```
git clone https://github.com/yourusername/GitVista.git
cd GitVista
```
### 2. Create a virtual environment
```
python3 -m venv .venv
source .venv/bin/activate  # macOS/Linux
# OR
.venv\Scripts\activate     # Windows
```

### 3. Make Scripts Executable
```
# Make all shell scripts executable
chmod +x *.sh
chmod +x Commands/*.sh
```
### 4. Install Python Requirements
```
cd /Utils
pip install -r requirements.txt
```

### 5. Install Dependencies:

Ensure you have Gum and Talisman installed. For detailed installation instructions, visit their respective documentation:

- [Gum Documentation](https://github.com/charmbracelet/gum)
- [Talisman Documentation](https://github.com/thoughtworks/talisman)
  
### 6. Usage:

Start the interactive interface:
```
./main.sh
```

## Contributing

We welcome contributions to GitVista! To contribute:

### 1. Fork the Repository.

### 2. Create a Feature Branch:
```
git checkout -b feature/name
```
### 3. Make Your Changes and Commit them.

Please ensure that you follow the repository's coding standards and guidelines. The `main` branch is protected to maintain the integrity of the project, so all changes must be made through feature branches and pull requests.

## Notes

- The main.sh script launches the full interactive experience.

- The AI help feature requires a valid Google Gemini API key in your .env.

- All Git operations run locally and securely

## License

GitVista is licensed under the MIT License.