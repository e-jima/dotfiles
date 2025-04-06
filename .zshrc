###################
# brew
###################
# for Apple silicon Mac
if [ -e "/opt/homebrew/bin/brew" ]; then
    brew_path="/opt/homebrew/bin/brew"
    eval "$($brew_path shellenv)"
fi
# for Intel Mac
if [ -e "/usr/local/bin/brew" ]; then
    brew_path="/usr/local/bin/brew"
    eval "$($brew_path shellenv)"
fi

###################
# settings
###################
export EDITOR='vim'
export LC_ALL='ja_JP.UTF-8'
export LANG='ja_JP.UTF-8'
export HISTSIZE=1000
export SAVEHIST=100000
# 自作コマンドへの path を通す
export PATH="$ZDOTDIR/bin:$ZSECRETDOTDIR/bin:$PATH"

# syntax highlight
export ZSH_HIGHLIGHT_HIGHLIGHTERS_DIR=$(brew --prefix)/share/zsh-syntax-highlighting/highlighters

# 大文字小文字の区別をなくす
autoload -Uz compinit
compinit
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

# 重複した履歴を保存しない
setopt hist_ignore_dups
# 履歴の開始と終了を記録
setopt EXTENDED_HISTORY

# 色
autoload -Uz colors
colors

# terminal で効かなくなった crtl を治す
bindkey -e

# alt + 矢印を動作させる(VSCode)
bindkey '^[[1;2D' backward-word
bindkey '^[[1;2C' forward-word

# asterisk の挙動を修正
unsetopt nomatch

###################
# prompt
###################
setopt PROMPT_SUBST
export PS1='%F{006}%~%f %F{216}% $(get_git_branch) %f
$ '


###################
# Git
###################
function get_git_branch {
    git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/[\1]/'
}

# 補完
fpath=(
  ${HOME}/.zsh/completions
  ${fpath}
)

###################
# alias
###################
alias ls='ls -FG'
alias ll='ls -alFG'

###################
# python
###################
# Activate the global uv virtual environment
if [[ -d "$HOME/.venv" ]]; then
    source "$HOME/.venv/bin/activate"
else
    echo "No virtual environment found in .venv or ~/.venv"
fi

# uv run コマンド用の補完設定
_uv_run_completions() {
  # 最初の引数がディレクトリならば、ディレクトリの候補を表示
  if [[ $words[2] == '' ]]; then
    _files -d
  # 次にファイル名を補完
  else
    _files
  fi
}
# uv run コマンドに補完を適用
compdef _uv_run_completions uv

# .pyc をつくらない
export PYTHONDONTWRITEBYTECODE=1
