setopt histignorealldups sharehistory

# Keep 1000 lines of history within the shell and save it to ~/.zsh_history:
HISTSIZE=1000
SAVEHIST=1000
HISTFILE=~/.zsh_history

export CLICOLOR=1
export LSCOLORS=GxFxCxDxBxegedabagaced

# Use modern completion system
autoload -Uz compinit

compinit

autoload -U colors && colors
#PROMPT="%{$fg[red]%}%n%{$reset_color%}@%{$fg[green]%}%m %{$fg[yellow]%}%(4~|%-1~/.../%2~|%3~) %{$reset_color%}%% "
PROMPT="%{$fg[green]%}%(4~|%-1~/.../%2~|%3~) %{$reset_color%}%% "

set -o vi
export EDITOR=vi    # Use vi as the default editor
bindkey -v          # But still use emacs-style zsh bindings
# incremental search in insert mode (Ctrl-R, Ctrl-F)
bindkey "^R" history-incremental-search-backward
bindkey "^F" history-incremental-search-forward
# incremental search in vi command mode
bindkey -M vicmd '/' history-incremental-search-backward
bindkey -M vicmd '?' history-incremental-search-forward
# navigate matches in incremental search
bindkey -M viins '^R' history-incremental-pattern-search-backward
bindkey -M viins '^F' history-incremental-pattern-search-forward

alias k=kubectl
alias kctx=kubectx
alias kns=kubens
alias ll='ls -lGFh'
alias ls='ls -G --color=auto'
alias vim='nvim'

