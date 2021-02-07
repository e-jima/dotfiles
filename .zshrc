###################
# export
###################
export EDITOR='vim'
export LC_ALL='ja_JP.UTF-8'
export LANG='ja_JP.UTF-8'


###################
# settings
###################

# syntax highlight
# brew install zsh-syntax-highlighting
source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# 大文字小文字の区別をなくす
autoload -U compinit
compinit
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

# 色
autoload -Uz colors
colors

# terminal で効かなくなった crtl を治す
bindkey -e


###################
# prompt
###################
setopt PROMPT_SUBST
export PS1='%F{009}Beau-Regard%f %F{006}%~%f %F{216}% $(get_git_branch) %f
$ '


###################
# fuction
###################
function get_git_branch {
    git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/[\1]/'
}


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
# 自作コマンド
###################
export PATH=$PATH:~/Documents/github/dotfiles/bin
