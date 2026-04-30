# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
    . /etc/bashrc
fi

# User specific environment
if ! [[ "$PATH" =~ "$HOME/.local/bin:$HOME/bin:" ]]; then
    PATH="$HOME/.local/bin:$HOME/bin:$PATH"
fi
export PATH

# Uncomment the following line if you don't like systemctl's auto-paging feature:
# export SYSTEMD_PAGER=

# User specific aliases and functions
if [ -d ~/.bashrc.d ]; then
    for rc in ~/.bashrc.d/*; do
        if [ -f "$rc" ]; then
            . "$rc"
        fi
    done
fi
unset rc

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

# Setup hyperlink formatting for ripgrep and ls
alias rg="rg --hyperlink-format=kitty"
alias ls="ls --hyperlink=auto --color=auto"

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

export VISUAL=nvim
export EDITOR="$VISUAL"

. "$HOME/.cargo/env"
