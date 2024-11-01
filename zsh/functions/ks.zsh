function ks() {
  export PROJECT_DIR=$1
  kitty --session ~/.dotfiles/kitty/session.conf --detach --single-instance
}
