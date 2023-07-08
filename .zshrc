source ~/zsh-snap/znap.zsh
# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
#setopt appendhistory autocd extendedglob nomatch notify
#unsetopt beep
#bindkey -e
## End of lines configured by zsh-newuser-install
## The following lines were added by compinstall
#zstyle :compinstall filename '/home/masashi/.zshrc'
#
autoload -Uz compinit
compinit
#autoload -Uz colors
#colors
## End of lines added by compinstall
##
## history search
ZSH_AUTOSUGGEST_STRATEGY=(history completion)
bindkey '^P' history-beginning-search-backward
bindkey '^N' history-beginning-search-forward
# setopt auto_cd
setopt auto_pushd
setopt pushd_ignore_dups
setopt extended_glob
setopt hist_ignore_all_dups
setopt hist_ignore_space
setopt correct
#
#zstyle ':completion:*default' menu select=1
#setopt prompt_subst
#
#{{{ prompt
#http://tkengo.github.io/blog/2013/05/12/zsh-vcs-info/
# autoload -Uz vcs_info
# setopt prompt_subst
# #
# zstyle ':vcs_info:git:*' check-for-changes true
# zstyle ':vcs_info:git:*' stagedstr "%F{yellow}!"
# zstyle ':vcs_info:git:*' unstagedstr "%F{red}+"
# zstyle ':vcs_info:*' formats "%F{green}%c%u[%b]%f"
# zstyle ':vcs_info:*' actionformats '[%b|%a]'
# precmd () { vcs_info }
# 
# Must be surrounded by SINGLE quote, not double quote
# Double quote evaluates once when zshrc is loaded.
# PROMPT='%{$fg[red]%}[zsh %l-%{$fg[white]%}†$fg[red]%}%{$bg[black]%}%n%{$reset_color%}%{$fg[white]%}†%{$fg[red]%}@%M:%~]%{$reset_color%} $vcs_info_msg_0_
# %{$fg[red]%}≫%{$fg[yellow]%}≫%{$fg[blue]%}≫%{$reset_color%} '
# %{$fg[red]%}♪%{$fg[yellow]%}♪%{$fg[blue]%}♪%{$reset_color%}

if [ -f ${HOME}/.zsh_aliases ]; then
  . ${HOME}/.zsh_aliases
fi
#}}}

export TERM=rxvt-unicode-256color
export PATH=~/.local/bin/:/opt/bin/:~/project/HyLaGI/bin/:~/.npm-global/bin:$PATH

# direnv
eval "$(direnv hook ${SHELL})"
export ANDROID_HOME=$HOME/Android/Sdk
export PATH=$PATH:~/.local/bin/
export PATH=$PATH:$ANDROID_HOME/emulator
export PATH=$PATH:$ANDROID_HOME/tools
export PATH=$PATH:$ANDROID_HOME/tools/bin
export PATH=$PATH:$ANDROID_HOME/platform-tools

# Rust
export PATH="$HOME/.cargo/bin:$PATH"
#android-java
export JAVA_HOME=/opt/android-studio/jre
export PATH=$JAVA_HOME/bin:$PATH

# Rails
export PATH="$HOME/.gem/ruby/2.7.0/bin:$PATH"

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin"

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"

# go
export GOPATH="$HOME/go"
export GOBIN="$GOPATH/bin"
export PATH=$PATH:$GOBIN

if [ -e /home/masashi/.nix-profile/etc/profile.d/nix.sh ]; then . /home/masashi/.nix-profile/etc/profile.d/nix.sh; fi # added by Nix installer

[ -f "/home/masashi/.ghcup/env" ] && source "/home/masashi/.ghcup/env" # ghcup-env

export PYENV_ROOT="$HOME/.pyenv"
command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"

eval "$(starship init zsh)"

### Znap
# Download Znap, if it's not there yet.
[[ -f ~/Git/zsh-snap/znap.zsh ]] ||
    git clone --depth 1 -- \
        https://github.com/marlonrichert/zsh-snap.git ~/Git/zsh-snap

source ~/Git/zsh-snap/znap.zsh  # Start Znap

#### syntax hilight
znap source zsh-users/zsh-syntax-highlighting

#### auto suggest ###
znap source zsh-users/zsh-autosuggestions
# bindkey '^K' autosuggest-execute

#### syntax auto complete
# znap source marlonrichert/zsh-autocomplete
#
export PATH="$HOME/.tfenv/bin:$PATH"

alias g='git'
alias d='docker'
alias dc='docker compose'
alias -g G='| grep'
alias -g H='| head'
alias -g T='| tail'
alias -g L='| less'

# Alt-c
export FZF_ALT_C_OPTS="--preview 'tree -C {}'"
