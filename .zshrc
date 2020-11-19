if [[ -f $HOME/.antigen/antigen.zsh ]]; then
  source $HOME/.antigen/antigen.zsh
  antigen bundle zsh-users/zsh-completions src
  antigen bundle greymd/docker-zsh-completion
  antigen bundle b4b4r07/enhancd
  antigen bundle zsh-users/zaw
  antigen bundle sroze/docker-compose-zsh-plugin
  antigen bundle mollifier/anyframe
  antigen apply

  # anyframe
  bindkey '^gb' anyframe-widget-checkout-git-branch
  bindkey '^g^b' anyframe-widget-checkout-git-branch
  bindkey '^gh' anyframe-widget-put-history
  bindkey '^g^h' anyframe-widget-put-history
  bindkey '^gk' anyframe-widget-kill
  bindkey '^g^k' anyframe-widget-kill
  bindkey '^ge' anyframe-widget-insert-git-branch
  bindkey '^g^e' anyframe-widget-insert-git-branch
  bindkey '^gf' anyframe-widget-insert-filename
  bindkey '^g^f' anyframe-widget-insert-filename
fi


##
## Color
##
TERM=xterm-256color
autoload -Uz colors
colors


##
## keymap
##
# emacs keymap
bindkey -e
# bindkey "^I" menu-complete


##
## Completion
##
zmodload -i zsh/complist
autoload -U compinit promptinit
compinit
zstyle ':completion::complete:*' use-cache true
zstyle ':completion:*:default' menu select=1

# zsh-completion
fpath=($HOME/.zsh/zsh-completions/src $fpath)

# ignore case
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

# use color highlight
zstyle ':completion:*' list-colors "${LS_COLORS}"

#kill の候補にも色付き表示
zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([%0-9]#)*=0=01;31'

#コマンドにsudoを付けても補完
zstyle ':completion:*:sudo:*' command-path `env|grep -e "^PATH="|sed -e "s/^PATH=\|:/ /g"`

# 補完時にhjklで選択
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'j' vi-down-line-or-history
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char


##
## Prompt
##
autoload -U promptinit
local p_sep="%B%F{black}------------------------------------------------------------------------------%f%b"$'\n'
local p_info="%B%F{yellow}[%n %(!,#,>)][%M]%f %F{cyan}(%D{%Y/%m/%d(%a)} %*)%f%b"$'\n'
local p_cmdline1=" %B( OwO)y-%F{red}~%f%F{yellow}~%f%F{green}~ %f%b"
local p_rprompt="%B%F{cyan}[%~]%f%b"
PROMPT="$p_sep$p_info$p_cmdline1"

# RPROMPT. display git branch
autoload -Uz vcs_info
setopt prompt_subst
zstyle ':vcs_info:git:*' check-for-changes true
zstyle ':vcs_info:git:*' stagedstr "%F{yellow}!"
zstyle ':vcs_info:git:*' unstagedstr "%F{red}+"
zstyle ':vcs_info:*' formats "%F{green}%c%u[%b]%f"
zstyle ':vcs_info:*' actionformats '[%b|%a]'
precmd () { vcs_info }
RPROMPT='${vcs_info_msg_0_} '$p_rprompt


##
## General
##
autoload history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
# 入力途中の履歴補完
bindkey "^P" history-beginning-search-backward-end
bindkey "^N" history-beginning-search-forward-end
#履歴のインクリメンタル検索でワイルドカード利用可能
bindkey '^R' history-incremental-pattern-search-backward
bindkey '^S' history-incremental-pattern-search-forward
# ヒストリーサイズ設定
HISTFILE=$HOME/.zsh_history
HISTSIZE=1000000
SAVEHIST=1000000

# ヒストリの一覧を読みやすい形に変更
HISTTIMEFORMAT="[%Y/%M/%D %H:%M:%S] "

# 補完リストが多いときに尋ねない
LISTMAX=1000

# 同時に起動したzshの間でヒストリを共有する
setopt share_history

# 同じコマンドをヒストリに残さない
setopt hist_ignore_all_dups

# スペースから始まるコマンド行はヒストリに残さない
setopt hist_ignore_space

# ヒストリに保存するときに余分なスペースを削除する
setopt hist_reduce_blanks

# 区切り文字
WORDCHARS="*?_-.[]~&;!#$%^(){}<>|"

# コマンド訂正
setopt correct

EDITOR="vim"

PATH=${PATH}:~/bin

# 環境ごとの設定
if [ -e $HOME/.zshrc.local ]; then
    source $HOME/.zshrc.local
fi

# 日本語ファイル名を表示可能にする
setopt print_eight_bit

# beep を無効にする
setopt no_beep

# フローコントロールを無効にする
setopt no_flow_control

# Ctrl+Dでzshを終了しない
setopt ignore_eof

# '#' 以降をコメントとして扱う
setopt interactive_comments

# cd したら自動的にpushdする
setopt auto_pushd
# 重複したディレクトリを追加しない
setopt pushd_ignore_dups

# 高機能なワイルドカード展開を使用する
setopt extended_glob

# stty stop undef
stty stop '^S'

##
## Alias
##
alias ll='ls -l'
alias la='ls -a'
alias lla='ls -al'
alias llt='ls -ltr'
alias llh='ls -lh'
alias llha='ls -lha'
alias rm="rm -i"
alias mv="mv -i"
alias cp="cp -i"
alias grep="grep --color"
alias vimr='vim -R'
alias less='less -iMR'
alias cdh='cd ~'
alias cdp='cd ../'
alias cdpp='cd ../../'
alias history='history -E 1'
alias vi='vim -u NONE -U NONE --noplugin -c "set paste" -c "set nocompatible"'
alias shutdown='echo oops...'
alias reload='echo oops...'

# OS 別の設定
case ${OSTYPE} in
  darwin*)
    export CLICOLOR=1
    alias ls='ls -G -F'
    ;;
  linux*)
    alias ls='ls -F --color=auto'
    ;;
esac


# reload .zshrc
alias R='clear; exec $SHELL; exec -l $SHELL'

# anyenv
if [ -d ${HOME}/.anyenv ] ; then
  export PATH="$HOME/.anyenv/bin:$PATH"
  eval "$(anyenv init -)"
  # for D in `ls $HOME/.anyenv/envs`
  # do
  #   export PATH="$HOME/.anyenv/envs/${D}shims:$PATH"
  # done
  # go
  export GOPATH="$HOME/go"
  export PATH="$GOPATH/bin:$PATH"
fi

export LESS='-i -M -R -S -W -z-4'

##
## Local setting
##
if [[ -f $HOME/.zshrc.local ]]; then
    source $HOME/.zshrc.local
fi
