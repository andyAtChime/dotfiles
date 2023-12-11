## .zshrc - Loaded after .zshenv
## Script relies heavily on safepathappend, safepathprepend and safesource from .zshenv

stty -ixon

## Environment display setup
autoload -Uz compinit
compinit

autoload -U colors
colors

autoload -U select-word-style
select-word-style bash

bindkey -e

setopt prompt_subst

# Environment diagnostic data
export LOCALE="en_US.UTF-8"
export LANG="en_US.UTF-8"

#Prompt Setup
export CLICOLOR=1
export LSCOLORS=GxFxCxDxBxegedabagaced
export LS_COLORS="di=34:ln=35:so=32:pi=33:ex=31:bd=34:cd=34:su=0:sg=0:tw=0:ow=0:"
export EDITOR=vim
export LESS='XFR'
alias grep=grep --color=auto

source ./.tokens

# The parent directory for all your Chime repos
export WORK_DIR_PATH=~/github/1debit
export LOCAL_GEM_PATH=$WORK_DIR_PATH

get_paged_memory() {
  echo $(( $(vm_stat | grep "Pages $1" | awk '{gsub(/\./,"")} {print $NF}') * 4096 / 1024 / 1024 / 1000.0 ))
}

freemem() {
  installed=$(( $(sysctl -n hw.memsize) / 1024 / 1024 / 1000.0 ))
  wired_down=$(get_paged_memory 'wired down')
  active=$(get_paged_memory 'active')
  inactive=$(get_paged_memory 'inactive')

  printf "%.2fG" "$(( installed - wired_down - active - inactive ))"
}

if [[ "$platform" == "osx" ]]; then
  PROMPT='%{$fg_bold[green]%}%~%{$fg_bold[blue]%} $(git_prompt_info)%{$reset_color%} %# '
fi

# ZSH Settings (LOCAL)
setopt INTERACTIVE_COMMENTS

# Common Tools

if type "postgres" > /dev/null; then
  safepathappend /Applications/Postgres.app/Contents/Versions/latest/bin
fi

if type hub > /dev/null; then
  alias git=hub
fi

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

function git_prompt_info() {
  ref=$(git symbolic-ref HEAD 2> /dev/null) || return
  echo "$ZSH_THEME_GIT_PROMPT_PREFIX${ref#refs/heads/}$ZSH_THEME_GIT_PROMPT_SUFFIX"
}

# This is for ruby 2.7.0 until rails address deprecation warnings
# You can remove in a shell with `unset RUBYOPT`
# export RUBYOPT='-W:no-deprecated -W:no-experimental'

source ~/chit/.chit
alias g="git"
alias gg="g g"
alias gd="git diff -w"
alias gds="git ds"
alias gst="git st"
alias ga="git add"
alias gc="git commit"
alias gcm="git commit -m"
alias gco="git checkout"
alias gnew="git checkout -b"
alias gdel="git branch -D"
alias gp="git push -u"
alias gpp="git push.please"
alias gget="git pull"
alias gaa="git add ."
alias zzz="source ~/.zshrc"
alias vvv="vim ~/.config/nvim/init.vim"
alias vvz="vim ~/.zshrc"

function ggg  = { gg $1 | grep $2 }

export RTDE="real-time-decision-engine"
export rtde="real_time_decision_engine"
tmux source-file ~/.tmux.conf
export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init -)"

alias k="kubectl"
alias kbc-prod="k config use-context csproduction-rails-test -n chime01; k config set-context --current --namespace=chime01"
alias kbc-qa="k config use-context csstable-rails-test -n qa; k config set-context --current --namespace=qa"
alias kbc-dev1="k config use-context csstable-rails-test -n dev1; k config set-context --current --namespace=dev1"
alias kbc-dev2="k config use-context csstable-rails-test -n dev2; k config set-context --current --namespace=dev2"
alias kbc-dev3="k config use-context csstable-rails-test -n dev3; k config set-context --current --namespace=dev3"
alias kbc-dev4="k config use-context csstable-rails-test -n dev4; k config set-context --current --namespace=dev4"
alias kbc-dev5="k config use-context csstable-rails-test -n dev5; k config set-context --current --namespace=dev5"
function aoc { ruby /Users/andrew.wagner/advent_of_code/$1.rb $2 $3 }
function lox { cd ~/mi/golox/ && go build ./ && ./golox $@; }
function remain { git co main && git pull && git co - }
function localdir { basename $(echo $(pwd)); }

[[ -s "/Users/andrew.wagner/.gvm/scripts/gvm" ]] && source "/Users/andrew.wagner/.gvm/scripts/gvm"
alias go="grc go"
export GOPRIVATE=github.com/1debit/*

alias vim="nvim"

export VISUAL=nvim
export EDITOR="$VISUAL"

export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm

source /Users/andrew.wagner/.docker/init-zsh.sh || true # Added by Docker Desktop
source /Users/andrew.wagner/.halo_help/halo.sh || true # import halo help
alias htesta="htest -- --exclude_pattern \"spec/de_integration/**/*_spec.rb\""
alias cci="circleci"
