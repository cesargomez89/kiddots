# KIDD🌀TS - Minimalistic Dotfiles for Developers

---

## Description

KIDD🌀TS is a collection of minimalistic dotfiles designed to provide a productive development environment with a focus on simplicity, performance, and usability.

## Tools

This setup includes the following tools:

- **[🐱 Kitty](https://sw.kovidgoyal.net/kitty/)** – A fast, feature-rich, GPU-based terminal emulator.
- **[⬛ Zsh](https://www.zsh.org/)** – A powerful shell with customizable features and plugins.
- **[💉 Antidote](https://getantidote.github.io/)** – A plugin manager for Zsh to help with organizing your shell plugins.
- **[🚀 Starship](https://starship.rs/)** – A minimal, fast, and customizable prompt for any shell.
- **[🪟 Tmux](https://tmux.github.io/)** – A terminal multiplexer to manage multiple terminal windows and panes.
- **[🔌 TPM](https://github.com/tmux-plugins/tpm)** – Tmux Plugin Manager for easy management of Tmux plugins. **[📓 Neovim](https://neovim.io/)** – A modern, extensible text editor, designed for power users.

## Dependencies

- **Neovim** v0.10+
- **Kitty Terminal** v0.32+
- **[Eza](https://github.com/eza-community/eza)** – A modern replacement for `ls` with extra features and better usability.
## Installation

To get started with KIDD🌀TS, simply run the following command:

```bash
curl -s https://raw.githubusercontent.com/cesargomez89/kiddots/main/install.sh | bash
```

This script will automatically install the necessary dependencies and configure the dotfiles for your environment.

## Kitty Configuration

### Navigation

- **Pane Navigation (Neovim):**
  - `Ctrl + h/j/k/l` – Move between panes or windows in Kitty.
  
- **Tab Navigation:**
  - `Ctrl + Shift + Left/Right Arrow` – Switch between open tabs.
  - `Ctrl + TAB` – Cycle through tabs in order.
  
- **Create New Tab:**
  - `Ctrl + Shift + t` – Open a new tab.
  
- **Alternate Layout (Zoom):**
  - `Ctrl + Shift + l` – Toggle between standard and zoomed layout.

## Shell Aliases

KIDD🌀TS comes with a variety of useful shell aliases to improve your workflow. For a full list of available aliases, refer to the [Aliases documentation](ALIASES.md).

## Neovim Configuration

Package manager: Lazy.nvim

Plugins: [lua plugins](./nvim/lua/plugins/)

Customizations: [options.lua](/nvim/lua/options.lua)

AI completion: [Codeium](https://codeium.com/)

## Screenshots

Here are a few screenshots showcasing the look and feel of the KIDD🌀TS setup:

![Screenshot 1](./screenshots/1.png)

![Screenshot 2](./screenshots/2.png)

![Screenshot 3](./screenshots/3.png)

---

## Contributing

Contributions are welcome! If you'd like to contribute, please fork the repository and submit a pull request.

## Source Code
The source code for KIDD🌀TS is available on [Github](https://github.com/cesargomez89/kiddots)
