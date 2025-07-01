# dependencies
echo "Installing dependencies..."

# install dependencies if arch
if [ -f /etc/arch-release ]; then
  echo "Installing dependencies for Arch..."
  sudo pacman -S git curl unzip zsh tmux neovim python luarocks eza neofetch
fi

# install dependencies if ubuntu
if [ -f /etc/lsb-release ]; then
  echo "Installing dependencies for Ubuntu..."
  sudo apt install git curl unzip zsh tmux luarocks eza neofetch
fi

# install dependencies if mac
if [ "$(uname)" == "Darwin" ]; then
  echo "Installing dependencies for Mac..."
  brew install git curl unzip zsh tmux luarocks eza neofetch
fi

# backup .dotfiles
echo "Backing up existing dotfiles..."
if [ -d ~/.dotfiles ]; then
  rm -rf ~/.dotfiles.bak && rm -f ~/.dotfiles.bak
  mv ~/.dotfiles ~/.dotfiles.bak
fi

# clone dotfiles https://github.com/cesargomez89/kiddots.git
echo "Cloning dotfiles..."
git clone https://github.com/cesargomez89/kiddots.git ~/.dotfiles
# antidote
echo "Installing antidote..."
if [ -d ${ZDOTDIR:-~}/.antidote ]; then
  rm -rf ${ZDOTDIR:-~}/.antidote
fi

git clone --depth=1 https://github.com/mattmc3/antidote.git ${ZDOTDIR:-~}/.antidote

# starship
echo "Installing starship..."
curl -sS https://starship.rs/install.sh | sh

# tmux
echo "Installing tmux plugin manager..."
if [ -d ~/.tmux/plugins/tpm ]; then
  rm -rf ~/.tmux/plugins/tpm
fi

git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

# backup existing dotfiles
echo "Backing up existing directories..."
if [ -d ~/.config/nvim ]; then
  rm -rf ~/.config/nvim.bak && rm -f ~/.config/nvim.bak
  mv ~/.config/nvim ~/.config/nvim.bak
fi

if [ -d ~/.config/kitty ]; then
  rm -rf ~/.config/kitty.bak && rm -f ~/.config/kitty.bak
  mv ~/.config/kitty ~/.config/kitty.bak
fi

if [ -f ~/.zshrc ]; then
  rm ~/.zshrc.bak
  mv ~/.zshrc ~/.zshrc.bak
fi

if [ -f ~/.zsh_plugins.txt ]; then
  rm ~/.zsh_plugins.txt.bak
  mv ~/.zsh_plugins.txt ~/.zsh_plugins.txt.bak
fi

if [ -f ~/.tmux.conf ]; then
  rm ~/.tmux.conf.bak
  mv ~/.tmux.conf ~/.tmux.conf.bak
fi

# link dotfiles folders and files
echo "Linking dotfiles..."
ln -fs ~/.dotfiles/zsh/zshrc ~/.zshrc
ln -fs ~/.dotfiles/zsh/zsh_plugins.txt ~/.zsh_plugins.txt
ln -fs ~/.dotfiles/tmux/tmux.conf ~/.tmux.conf
ln -fs ~/.dotfiles/nvim ~/.config
ln -fs ~/.dotfiles/kitty ~/.config
ln -fs ~/.dotfiles/git/gitconfig ~/.gitconfig
ln -fs ~/.dotfiles/starship/starship.toml ~/.config/starship.toml
ln -fs ~/.dotfiles/fum/config.jsonc ~/.config/fum/config.jsonc

touch ~/.zshrc_profile

echo "Download fonts to  ~/.dotfiles/fonts"
./fonts/download.sh

echo "Install ~/.dotfiles/fonts/CaskaydiaCoveNerdFontComplete-Regular.ttf manually to get glyphs working."
