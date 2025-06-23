# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
*i*) ;;
*) return ;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
  debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
xterm-color | *-256color) color_prompt=yes ;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
  if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
    # We have color support; assume it's compliant with Ecma-48
    # (ISO/IEC-6429). (Lack of such support is extremely rare, and such
    # a case would tend to support setf rather than setaf.)
    color_prompt=yes
  else
    color_prompt=
  fi
fi

if [ "$color_prompt" = yes ]; then
  PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
  PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm* | rxvt*)
  PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
  ;;
*) ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
  test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
  alias ls='ls --color=auto'
  alias dir='dir --color=auto'
  alias vdir='vdir --color=auto'

  alias grep='grep --color=auto'
  alias fgrep='fgrep --color=auto'
  alias egrep='egrep --color=auto'
fi

# colored GCC warnings and errors
export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
  . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

. "$HOME/.cargo/env"

export VISUAL=nvim
export EDITOR="$VISUAL"

function yy() {
  local tmp
  tmp="$(mktemp -t "yazi-cwd.XXXXX")"
  yazi "$@" --cwd-file="$tmp"
  if cwd="$(cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
    cd -- "$cwd" || exit
  fi
  rm -f -- "$tmp"
}

function addr2lines() (
  perl -ne '$m = s/(.*).*\(([^)]*)\).*/gdb -nh -q -batch -ex "info line *\2" \1/;print $_ if $m' | bash
)

# fzf tokyonight theme
export FZF_DEFAULT_OPTS="$FZF_DEFAULT_OPTS \
  --highlight-line \
  --info=inline-right \
  --ansi \
  --layout=reverse \
  --border=none
  --color=bg+:#2d3f76 \
  --color=bg:#1e2030 \
  --color=border:#589ed7 \
  --color=fg:#c8d3f5 \
  --color=gutter:#1e2030 \
  --color=header:#ff966c \
  --color=hl+:#65bcff \
  --color=hl:#65bcff \
  --color=info:#545c7e \
  --color=marker:#ff007c \
  --color=pointer:#ff007c \
  --color=prompt:#65bcff \
  --color=query:#c8d3f5:regular \
  --color=scrollbar:#589ed7 \
  --color=separator:#ff966c \
  --color=spinner:#ff007c \
"

_find_dir() {
  local result
  result=$(fd . -td --absolute-path --exclude anaconda3 --exclude snap --exclude x86_64-pc-linux-gnu-library --exclude Downloads "$1" | fzf)

  echo "$result"
}

function f() {
  local result
  result=$(_find_dir ~)

  if [[ "$result" != "" ]]; then
    cd "$result" || exit
  fi
}

ff() {
  local result
  result=$(_find_dir "$(pwd)")

  if [[ "$result" != "" ]]; then
    cd "$result" || exit
  fi
}

# Setup hyperlink formatting for ripgrep and ls
alias rg="rg --hyperlink-format=kitty"
alias ls="ls --hyperlink=auto --color=auto"

alias mergetool="nvim -c DiffviewOpen"

export ANDROID_HOME=/opt/android-sdk

# Path setup
export PATH="/home/ashbythorpe/.local/share/bob/nvim-bin:$PATH"
export PATH="/home/ashbythorpe/.local/bin:$PATH"
export PATH="/home/ashbythorpe/.local/apps/idea-IU-233.14475.28/bin:$PATH"
export PATH="/home/ashbythorpe/.local/apps/apache-maven-3.9.6/bin:$PATH"
export PATH="/usr/local/go/bin:$PATH"
export PATH="/home/ashbythorpe/.local/apps/zig-linux-x86_64-0.11.0:$PATH"
export PATH="/home/ashbythorpe/.local/apps/flutter/bin:$PATH"
export PATH="/opt/android-sdk/cmdline-tools/latest/bin:$PATH"
export PATH="/home/ashbythorpe/.config/emacs/bin:$PATH"
export PATH="/home/ashbythorpe/.cache/rebar3/bin:$PATH"
export PATH="/home/ashbythorpe/.local/apps/yazi-x86_64-unknown-linux-gnu:$PATH"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH=$BUN_INSTALL/bin:$PATH

# kerl
export KERL_BUILD_BACKEND="git"
export KERL_CONFIGURE_OPTIONS="--disable-debug"

# asdf
. "$HOME/.asdf/asdf.sh"
. "$HOME/.asdf/completions/asdf.bash"

export PYENV_ROOT="$HOME/.pyenv"
[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"

eval "$(zoxide init bash)"

eval "$(starship init bash)"

[[ -f ~/.bash-preexec.sh ]] && source ~/.bash-preexec.sh
eval "$(atuin init bash --disable-up-arrow)"

source /home/ashbythorpe/.bash_completions/kittybg.sh

[ -f "/home/ashbythorpe/.ghcup/env" ] && . "/home/ashbythorpe/.ghcup/env" # ghcup-env

[ -f ~/.fzf.bash ] && source ~/.fzf.bash

. "/home/ashbythorpe/.deno/env"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"                   # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion" # This loads nvm bash_completion

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/home/ashbythorpe/anaconda3/bin/conda' 'shell.bash' 'hook' 2>/dev/null)"
if [ $? -eq 0 ]; then
  eval "$__conda_setup"
else
  if [ -f "/home/ashbythorpe/anaconda3/etc/profile.d/conda.sh" ]; then
    . "/home/ashbythorpe/anaconda3/etc/profile.d/conda.sh"
  else
    export PATH="/home/ashbythorpe/anaconda3/bin:$PATH"
  fi
fi
unset __conda_setup
# <<< conda initialize <<<

# completion
export CARAPACE_BRIDGES='zsh,fish,bash,inshellisense' # optional
source <(carapace _carapace)

eval "$(_PIPENV_COMPLETE=bash_source pipenv)"
eval "$(uv generate-shell-completion bash)"
eval "$(uvx --generate-shell-completion bash)"
