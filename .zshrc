# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
setopt appendhistory autocd extendedglob nomatch notify
unsetopt beep
bindkey -e
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/home/masashi/.zshrc'

autoload -Uz compinit
compinit
autoload -Uz colors
colors
# End of lines added by compinstall
#
# history search
bindkey '^P' history-beginning-search-backward
bindkey '^N' history-beginning-search-forward

setopt auto_cd
setopt auto_pushd
setopt pushd_ignore_dups
setopt extended_glob
setopt hist_ignore_all_dups
setopt hist_ignore_space
setopt correct

zstyle ':completion:*default' menu select=1

#{{{ prompt
#http://tkengo.github.io/blog/2013/05/12/zsh-vcs-info/
autoload -Uz vcs_info
setopt prompt_subst

zstyle ':vcs_info:git:*' check-for-changes true
zstyle ':vcs_info:git:*' stagedstr "%F{yellow}!"
zstyle ':vcs_info:git:*' unstagedstr "%F{red}+"
zstyle ':vcs_info:*' formats "%F{green}%c%u[%b]%f"
zstyle ':vcs_info:*' actionformats '[%b|%a]'
precmd () { vcs_info }

# Must be surrounded by SINGLE quote, not double quote
# Double quote evaluates once when zshrc is loaded.
PROMPT='%{$fg[red]%}[zsh %l-%{$fg[white]%}†$fg[red]%}%{$bg[black]%}%n%{$reset_color%}%{$fg[white]%}†%{$fg[red]%}@%M:%~]%{$reset_color%} $vcs_info_msg_0_
%{$fg[red]%}≫%{$fg[yellow]%}≫%{$fg[blue]%}≫%{$reset_color%} '
#%{$fg[red]%}♪%{$fg[yellow]%}♪%{$fg[blue]%}♪%{$reset_color%}

if [ -f ${HOME}/.zsh_aliases ]; then
  . ${HOME}/.zsh_aliases
fi
#}}}

export TERM=rxvt-unicode-256color

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
# Go
export GOPATH=${HOME}/go
export GOBIN=${GOPATH}/bin
export PATH=$PATH:${GOBIN}
#android-java
export JAVA_HOME=/opt/android-studio/jre
export PATH=$JAVA_HOME/bin:$PATH

if [ -e /home/masashi/.nix-profile/etc/profile.d/nix.sh ]; then . /home/masashi/.nix-profile/etc/profile.d/nix.sh; fi # added by Nix installer
