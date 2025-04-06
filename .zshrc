###################
# export
###################
export EDITOR='vim'
export LC_ALL='ja_JP.UTF-8'
export LANG='ja_JP.UTF-8'
export HISTSIZE=1000
export SAVEHIST=100000
# 自作コマンドへの path を通す
export PATH="$ZDOTDIR/bin:$PATH"
# zlib
export LDFLAGS="-L/opt/homebrew/opt/zlib/lib"
export CPPFLAGS="-I/opt/homebrew/opt/zlib/include"
export PKG_CONFIG_PATH="/usr/local/opt/zlib/lib/pkgconfig"

###################
# settings
###################
# brew path
eval "$(/opt/homebrew/bin/brew shellenv)"

# syntax highlight
export ZSH_HIGHLIGHT_HIGHLIGHTERS_DIR=/opt/homebrew/share/zsh-syntax-highlighting/highlighters

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
alias g-pull='git checkout master && git pull origin master'
alias g-push='git push origin `git rev-parse --abbrev-ref HEAD`'
alias g-add='git add .'
alias g-status='git status'


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
