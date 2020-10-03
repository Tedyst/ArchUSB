export LC_ALL=en_US.UTF-8
export LC_CTYPE=en_US.UTF-8
export LC_MESSAGES=en_US.UTF-8
export LC_COLLATE=en_US.UTF-8
export LANG=en_US.UTF-8
export LANGUAGE=en_US:en
[ -z "$PS1" ] && return
# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block, everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

#vscode fixes
export HISTIGNORE="sh /tmp/Microsoft-MIEngine-Cmd*"

export ZSH_DISABLE_COMPFIX="true"
export ZSH="/home/$USER/.oh-my-zsh"
export GOPATH="/home/tedy/go"
export TERM=xterm-256color
ZSH_THEME=powerlevel10k/powerlevel10k
HYPHEN_INSENSITIVE="true"
DISABLE_AUTO_UPDATE="true"
ENABLE_CORRECTION="true"

plugins=(
      git
      github
      zsh-autosuggestions
      sudo
      kubectl
)

export GO15VENDOREXPERIMENT=1
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8
alias su='sudo -E -s'
alias exi='exit'
alias ex='exit'
alias cdgit='cd /mnt/hddext4/Git/'
export PATH="$PATH:/home/$USER/.local/bin"
export SSH_AUTH_SOCK=/run/user/1000/gnupg/S.gpg-agent.ssh
export DOCKER_CLI_EXPERIMENTAL=enabled

ZSH_AUTOSUGGEST_USE_ASYNC=true
POWERLEVEL9K_BACKGROUND_JOBS_BACKGROUND='178'
POWERLEVEL9K_BACKGROUND_JOBS_FOREGROUND='green'
POWERLEVEL9K_COMMAND_EXECUTION_TIME_BACKGROUND='red'
POWERLEVEL9K_COMMAND_EXECUTION_TIME_FOREGROUND='black'
POWERLEVEL9K_COMMAND_EXECUTION_TIME_THRESHOLD="1"
POWERLEVEL9K_COMMAND_TIME_FOREGROUND='gray'
POWERLEVEL9K_CONTEXT_DEFAULT_BACKGROUND="green"
POWERLEVEL9K_CONTEXT_DEFAULT_FOREGROUND="black"
POWERLEVEL9K_CONTEXT_REMOTE_BACKGROUND="green"
POWERLEVEL9K_CONTEXT_REMOTE_FOREGROUND="black"
POWERLEVEL9K_CONTEXT_TEMPLATE="%n"
POWERLEVEL9K_DIR_PATH_ABSOLUTE=false
POWERLEVEL9K_SHORTEN_DIR_LENGTH=2
POWERLEVEL9K_SHORTEN_STRATEGY="truncate_with_package_name"
POWERLEVEL9K_DIR_WRITABLE_FORBIDDEN_FOREGROUND="015"
POWERLEVEL9K_GITSTATUS_DIR="/home/$USER/.oh-my-zsh/custom/plugins/gitstatus"
POWERLEVEL9K_GITSTATUS_HIDE_BRANCH_ICON=false
POWERLEVEL9K_HOST_LOCAL_BACKGROUND='green'
POWERLEVEL9K_HOST_LOCAL_FOREGROUND='black'
POWERLEVEL9K_HOST_REMOTE_BACKGROUND='green'
POWERLEVEL9K_HOST_REMOTE_FOREGROUND='black'
POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(ssh root_indicator context dir dir_writable vcs)
POWERLEVEL9K_MODE='nerdfont-complete'
POWERLEVEL9K_NVM_BACKGROUND="238"
POWERLEVEL9K_NVM_FOREGROUND="green"
POWERLEVEL9K_PUBLIC_IP_BACKGROUND='green'
POWERLEVEL9K_PUBLIC_IP_FOREGROUND='black'
POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(status command_execution_time_joined background_jobs)
POWERLEVEL9K_ROOT_INDICATOR_BACKGROUND="grey"
POWERLEVEL9K_STATUS_ERROR_BACKGROUND='red'
POWERLEVEL9K_STATUS_ERROR_FOREGROUND='black'
POWERLEVEL9K_STATUS_ERROR_ICON=""
POWERLEVEL9K_STATUS_HIDE_SIGNAME=false
POWERLEVEL9K_STATUS_OK=false
POWERLEVEL9K_STATUS_SHOW_PIPESTATUS=false
POWERLEVEL9K_TIME_BACKGROUND='white'
POWERLEVEL9K_TIME_FORMAT="%D{%H:%M}"

source $ZSH/oh-my-zsh.sh

unsetopt correct_all  
setopt correct
