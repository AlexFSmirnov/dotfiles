font_urls=(
    "https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/Hack/Bold/HackNerdFont-Bold.ttf"
    "https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/Hack/Regular/HackNerdFont-Regular.ttf"
    "https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/Hack/Italic/HackNerdFont-Italic.ttf"
    "https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/Hack/BoldItalic/HackNerdFont-BoldItalic.ttf"
)

# Function to copy common configurations
copy_common_configs() {
    cp -a bash/. ~
    . ~/.bashrc

    cp -a zsh/. ~
    # . ~/.zshrc

    cp -a tmux/. ~

    cp -a vim/. ~
    mkdir -p ~/.vim/undodir
    mkdir -p ~/.vim/backups
    mkdir -p ~/.vim/swapfiles

    mkdir -p ~/.config/nvim
    cp -a nvim/. ~/.config/nvim
}

# Function to install Nerd Fonts on macOS
install_fonts_macos() {
    sudo mkdir -p "$HOME/Library/Fonts"

    for url in "${font_urls[@]}"; do
        file_name=$(basename "$url")
        sudo curl -fLo "$HOME/Library/Fonts/$file_name" "$url"
    done
}

# Function to install Nerd Fonts on Linux
install_fonts_linux() {
    sudo mkdir -p /usr/local/share/fonts

    for url in "${font_urls[@]}"; do
        file_name=$(basename "$url")
        sudo wget "$url" -O "/usr/local/share/fonts/$file_name"
    done
}

# Detect OS and run appropriate functions
if [[ "$OSTYPE" == "darwin"* ]]; then
    # macOS
    copy_common_configs
    install_fonts_macos

    mkdir -p "$HOME/.config/alacritty"
    cp -a alacritty/alacritty-mac.toml "$HOME/.config/alacritty/alacritty.toml"
elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
    # Linux
    copy_common_configs
    install_fonts_linux

    mkdir -p "$HOME/.config/alacritty"
    cp -a alacritty/alacritty.toml "$HOME/.config/alacritty/alacritty.toml"
else
    echo "Unsupported OS type: $OSTYPE"
    exit 1
fi

echo "Configurations and fonts installed successfully."
