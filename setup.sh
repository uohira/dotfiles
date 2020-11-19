#!/usr/bin/env bash

FILES=(.zshrc .vim .tmux.conf .gitconfig .gitignore)
for i in ${FILES[@]}; do
  ln -s $HOME/dotfiles/$i $HOME/$i
done

if [ ! -d $HOME/.antigen ]; then
  git clone https://github.com/zsh-users/antigen.git $HOME/.antigen
fi

if [ ! -d $HOME/.anyenv ]; then
  git clone https://github.com/riywo/anyenv $HOME/.anyenv
fi

if [ ! -d $HOME/.vim/plugged ]; then
  mkdir -p $HOME/.vim/plugged
  curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
fi

if [ ! -d $HOME/bin ]; then
  mkdir $HOME/bin
fi

if [ ! -d $HOME/go ]; then
  mkdir -p $HOME/go/src
  mkdir -p $HOME/go/pkg
  mkdir -p $HOME/go/bin
fi

cat << END
packages:
  tmux
    https://tmux.github.io/
  zsh
    http://zsh.sourceforge.net/Arc/source.html
  fzf
    https://github.com/junegunn/fzf-bin/releases
  vim
    https://github.com/vim/vim.git

requirements:
  Vim: latest
  python: latest
  nodejs: latest

exec:
  vim +":PlugInstall" +:q

see: https://github.com/neoclide/coc.nvim/wiki/Language-servers
END
