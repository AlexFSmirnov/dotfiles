cp -a bash/. ~
. ~/.bashrc

cp -a zsh/. ~
#. ~/.zshrc

cp -a tmux/. ~

cp -a vim/. ~
mkdir -p ~/.vim/undodir
mkdir -p ~/.vim/backups
mkdir -p ~/.vim/swapfiles

mkdir -p ~/.config/nvim
cp -a nvim/. ~/.config/nvim

mkdir -p /usr/local/share/fonts
sudo wget https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/Hack/Bold/HackNerdFont-Bold.ttf -O /usr/local/share/fonts/HackNerdFont-Bold.ttf
sudo wget https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/Hack/Regular/HackNerdFont-Regular.ttf -O /usr/local/share/fonts/HackNerdFont-Regular.ttf
sudo wget https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/Hack/Italic/HackNerdFont-Italic.ttf -O /usr/local/share/fonts/HackNerdFont-Italic.ttf
sudo wget https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/Hack/BoldItalic/HackNerdFont-BoldItalic.ttf -O /usr/local/share/fonts/HackNerdFont-BoldItalic.ttf

mkdir -p ~/.config/alacritty
cp -a alacritty/. ~/.config/alacritty

sudo apt install fd-find
sudo apt install ripgrep
sudo apt install unzip
