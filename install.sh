#!/bin/bash

set -e

echo "====================================="
echo " 🚀 GitVista Installer + Self-Test "
echo "====================================="

# 📁 Define where to install
INSTALL_DIR="$HOME/.gitvista"
BIN_DIR="$HOME/bin"

echo "📂 Installing to: $INSTALL_DIR"
echo "🔗 Symlink will be: $BIN_DIR/gitvista"
echo ""

# ✅ Create necessary dirs
mkdir -p "$INSTALL_DIR"
mkdir -p "$BIN_DIR"

# ✅ Remove old version safely
rm -rf "$INSTALL_DIR"

# ✅ Copy current project to ~/.gitvista
rsync -av --progress ./ "$INSTALL_DIR" \
  --exclude ".git" \
  --exclude "node_modules" \
  --exclude ".venv"

# ✅ Make sure main.sh is executable
chmod +x "$INSTALL_DIR/main.sh"

# ✅ Create symlink to ~/bin
ln -sf "$INSTALL_DIR/main.sh" "$BIN_DIR/gitvista"

# ✅ Add ~/bin to PATH if needed
if [[ ":$PATH:" != *":$BIN_DIR:"* ]]; then
  SHELL_RC="$HOME/.bashrc"
  [[ "$SHELL" =~ zsh ]] && SHELL_RC="$HOME/.zshrc"

  echo "export PATH=\"$BIN_DIR:\$PATH\"" >> "$SHELL_RC"
  echo "✅ Added $BIN_DIR to PATH in $SHELL_RC"
  echo "👉 Please run: source $SHELL_RC"
else
  echo "✅ $BIN_DIR already in PATH"
fi

# ===============================
# ✅ Auto-Test: verify the install
# ===============================

echo ""
echo "🔍 Running self-test..."

TEST_OUTPUT=$("$BIN_DIR/gitvista" --version 2>&1 || true)

if [[ "$TEST_OUTPUT" == *"GIT VISTA"* ]]; then
  echo "✅ Self-test passed: CLI works and shows version!"
else
  echo "❌ Self-test failed!"
  echo "Output was:"
  echo "$TEST_OUTPUT"
  echo ""
  echo "🔑 Hints:"
  echo "  - Ensure main.sh resolves \$GITVISTA_HOME correctly."
  echo "  - Check that all sourced files use \$GITVISTA_HOME, not relative paths."
  echo "  - Inspect the symlink: ls -l $BIN_DIR/gitvista"
  exit 1
fi

echo ""
echo "🎉 Installation complete!"
echo "👉 You can now run: gitvista"
echo "🚀 Enjoy your interactive Git experience!"

