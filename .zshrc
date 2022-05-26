setopt histignorealldups sharehistory

# Keep 1000 lines of history within the shell and save it to ~/.zsh_history:
HISTSIZE=1000
SAVEHIST=1000
HISTFILE=~/.zsh_history

export CLICOLOR=1 
export LSCOLORS=GxFxCxDxBxegedabagaced

# Use modern completion system
autoload -Uz compinit

# case insensitive path-completion 
zstyle ':completion:*' matcher-list 'm:{[:lower:][:upper:]}={[:upper:][:lower:]}' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]} l:|=* r:|=*' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]} l:|=* r:|=*' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]} l:|=* r:|=*' 
# partial completion suggestions
zstyle ':completion:*' list-suffixes zstyle ':completion:*' expand prefix suffix 
zstyle ':completion:*' auto-description 'specify: %d'
zstyle ':completion:*' completer _expand _complete _correct _approximate
zstyle ':completion:*' format 'Completing %d'
zstyle ':completion:*' group-name ''
zstyle ':completion:*' menu select=2
eval "$(dircolors -b)"
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' list-prompt %SAt %p: Hit TAB for more, or the character to insert%s
zstyle ':completion:*' menu select=long
zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
zstyle ':completion:*' use-compctl false
zstyle ':completion:*' verbose true

zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31'
zstyle ':completion:*:kill:*' command 'ps -u $USER -o pid,%cpu,tty,cputime,cmd'

compinit

autoload -U colors && colors
PROMPT="%{$fg[red]%}%n%{$reset_color%}@%{$fg[green]%}%m %{$fg[yellow]%}%(4~|%-1~/.../%2~|%3~) %{$reset_color%}%% "

set -o vi
export EDITOR=vi    # Use vi as the default editor
bindkey -e          # But still use emacs-style zsh bindings
# incremental search in insert mode (Ctrl-R, Ctrl-F)
bindkey "^f" history-incremental-search-forward
bindkey "^r" history-incremental-search-backward
bindkey -M vicmd "^f" history-incremental-search-forward 
bindkey -M vicmd "^r" history-incremental-search-backward

alias k=kubectl
alias kctx=kubectx
alias kns=kubens
alias ll='ls -lGFh'
alias ls='ls -G --color=auto'
alias vim='nvim'

