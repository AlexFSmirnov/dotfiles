import os
import platform
import shutil
import subprocess
import requests

# Nerd Font URLs
FONT_URLS = [
    "https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/Hack/Bold/HackNerdFont-Bold.ttf",
    "https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/Hack/Regular/HackNerdFont-Regular.ttf",
    "https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/Hack/Italic/HackNerdFont-Italic.ttf",
    "https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/Hack/BoldItalic/HackNerdFont-BoldItalic.ttf"
]

# Common configurations copy function
def copy_common_configs():
    home_dir = os.path.expanduser("~")

    for config_dir in ["bash", "zsh", "tmux", "vim", "nvim"]:
        source_path = os.path.join(config_dir, ".")
        target_path = os.path.join(home_dir, f".{config_dir}")
        if os.path.exists(source_path):
            shutil.copytree(source_path, target_path, dirs_exist_ok=True)

    # Additional vim directories
    vim_dirs = [".vim/undodir", ".vim/backups", ".vim/swapfiles"]
    for vim_dir in vim_dirs:
        os.makedirs(os.path.join(home_dir, vim_dir), exist_ok=True)

    # nvim config
    nvim_config = os.path.join(home_dir, ".config/nvim")
    os.makedirs(nvim_config, exist_ok=True)
    if os.path.exists("nvim"):
        shutil.copytree("nvim", nvim_config, dirs_exist_ok=True)

# Unified font installation function
def install_fonts():
    system = platform.system()

    if system == "Darwin":
        fonts_dir = os.path.expanduser("~/Library/Fonts")
    elif system == "Linux":
        fonts_dir = "/usr/local/share/fonts"
        os.makedirs(fonts_dir, exist_ok=True)
    elif system == "Windows":
        fonts_dir = os.path.join(os.environ['WINDIR'], "Fonts")
    else:
        print(f"Unsupported OS for font installation: {system}")
        return

    for url in FONT_URLS:
        file_name = os.path.basename(url)
        if system == "Linux":
            temp_file = f"/tmp/{file_name}"
            download_file(url, temp_file)
            print(f"Moving {file_name} to {fonts_dir}...")
            subprocess.run(["sudo", "mv", temp_file, os.path.join(fonts_dir, file_name)], check=True)
        elif system == "Windows":
            file_path = os.path.join(fonts_dir, file_name)
            download_file(url, file_path)

            # Add font to the Windows Registry
            font_name = os.path.splitext(file_name)[0]
            subprocess.run([
                "reg", "add",
                "HKLM\\SOFTWARE\\Microsoft\\Windows NT\\CurrentVersion\\Fonts",
                "/v", font_name,
                "/t", "REG_SZ",
                "/d", file_path,
                "/f"
            ], check=True)
        else:
            file_path = os.path.join(fonts_dir, file_name)
            download_file(url, file_path)

    if system == "Linux":
        print("Refreshing font cache...")
        subprocess.run(["sudo", "fc-cache", "-fv"], check=True)

# File downloader
def download_file(url, file_path):
    print(f"Downloading {url}...")
    response = requests.get(url, stream=True)
    if response.status_code == 200:
        with open(file_path, "wb") as f:
            shutil.copyfileobj(response.raw, f)
        print(f"Downloaded {file_path}")
    else:
        print(f"Failed to download {url}: {response.status_code}")

# Alacritty configuration copy function
def copy_alacritty_config():
    system = platform.system()
    home_dir = os.path.expanduser("~")

    if system == "Darwin":
        alacritty_dir = os.path.join(home_dir, ".config/alacritty")
        os.makedirs(alacritty_dir, exist_ok=True)
        shutil.copy("alacritty/alacritty-mac.toml", os.path.join(alacritty_dir, "alacritty.toml"))
    elif system == "Linux":
        alacritty_dir = os.path.join(home_dir, ".config/alacritty")
        os.makedirs(alacritty_dir, exist_ok=True)
        shutil.copy("alacritty/alacritty.toml", os.path.join(alacritty_dir, "alacritty.toml"))
    elif system == "Windows":
        appdata_dir = os.getenv("APPDATA")
        alacritty_dir = os.path.join(appdata_dir, "alacritty")
        os.makedirs(alacritty_dir, exist_ok=True)
        shutil.copy("alacritty/alacritty-windows.toml", os.path.join(alacritty_dir, "alacritty.toml"))

        # Print additional instructions for Windows
        print("\033[33mTo make icons work correctly with Alacritty on Windows you need to update the libraries that it uses by default:\033[0m")
        print("\033[33m1. Download WezTerm (portable .zip)\033[0m")
        print("\033[33m2. Copy the conpty.dll and OpenConsole.exe files from WezTerm into the installation folder of Alacritty (usually C:/ProgramFiles/Alacritty)\033[0m")

    else:
        print(f"Unsupported OS for Alacritty configuration: {system}")

# Platform-specific configuration
def configure_system():
    system = platform.system()

    install_fonts()
    copy_common_configs()
    copy_alacritty_config()

    print("Configurations and fonts installed successfully.")

if __name__ == "__main__":
    configure_system()
