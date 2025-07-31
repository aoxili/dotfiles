# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="blinks"

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(vi-mode vundle pip brew git colorize)

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/dsa_id"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

platform=$(uname)

# platform dependent settings
if [[ $platform == *Darwin* ]]
then
  # This makes our PATH visible to GUI apps
  launchctl setenv PATH $PATH

  # Brew paths over system paths
  export PATH=/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:$PATH
fi

source $ZSH/oh-my-zsh.sh

# global settiings
bindkey "^[[A" history-search-backward
bindkey "^[[B" history-search-forward


LOCAL_RC=~/.zshrc.local
[ -f $LOCAL_RC ] && source $LOCAL_RC

# History configuration (matching bash infinite history)
export HISTSIZE=1000000
export SAVEHIST=1000000
export HISTTIMEFORMAT='%F %T '
setopt HIST_IGNORE_DUPS
setopt HIST_FIND_NO_DUPS
setopt SHARE_HISTORY
setopt APPEND_HISTORY
setopt INC_APPEND_HISTORY
setopt EXTENDED_HISTORY

# History aliases (matching bash)
alias h='fc -li -25'

# Commands prefixed with a space don't go into history
setopt HIST_IGNORE_SPACE

# Exclude common commands from history (matching bash HISTIGNORE)
HISTORY_IGNORE="(ls|ll|sl|l|[bf]g|clear|cd|cd ..|cd ...|cd ....|h|history|exit|dirs|d|[1-9]|[1-9][0-9])"

# Function to filter commands from history
zshaddhistory() {
    emulate -L zsh
    [[ $1 != ${~HISTORY_IGNORE} ]]
}

# load keychain if keychain exists
if [[ -a /usr/bin/keychain ]]; then
  /usr/bin/keychain $HOME/.ssh/id_rsa
  source $HOME/.keychain/$HOST-sh
fi
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# Better FZF history search - prioritize exact phrase matches
export FZF_CTRL_R_OPTS="--exact"
[ -f ~/.dotfiles/zsh/zbell.zsh ] && source ~/.dotfiles/zsh/zbell.zsh
alias vim='nvim'
export EDITOR="nvim"
export VISUAL="nvim"
alias vi='nvim'

# Use colorized versions as defaults
alias cat='ccat'
alias less='cless'
