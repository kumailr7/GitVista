# GitVista

GitVista is an interactive Git tool that combines the power of Gum for user interactions with Talisman for advanced Git scanning. This open-source project aims to enhance your development workflow by providing insightful file analysis and secure Git operations.

## Features

- **Interactive Interface:** Utilize Gum to interactively navigate and manage your Git repository.
  
- **Advanced Scanning:** Leverage Talisman for comprehensive scanning of your Git files to detect sensitive data and potential issues.
  
- **Open Source:** Contributions are welcome! Join the community to help improve and expand GitVista.

## Getting Started

To start using GitVista, follow these steps:

### 1. Clone the Repository:
```
git clone https://github.com/yourusername/GitVista.git
cd GitVista
```

### 2. Install Dependencies:

Ensure you have Gum and Talisman installed. For detailed installation instructions, visit their respective documentation:

- [Gum Documentation](https://github.com/charmbracelet/gum)
- [Talisman Documentation](https://github.com/thoughtworks/talisman)
  
### 3. Usage:

Give Permission to the file `git_commit.sh`  & `git_status.sh`
```
chmod +x git_commit.sh && chmod +x git_status.sh
./git_commit.sh
```
**NOTE:** You dont need to run `git_status.sh` its already included in the `git_commit.sh` script

## Contributing

We welcome contributions to GitVista! To contribute:

### 1. Fork the Repository.

### 2. Create a Feature Branch:
```
git checkout -b feature/name
```
### 3. Make Your Changes and Commit them.

Please ensure that you follow the repository's coding standards and guidelines. The `main` branch is protected to maintain the integrity of the project, so all changes must be made through feature branches and pull requests.


## License

GitVista is licensed under the MIT License.