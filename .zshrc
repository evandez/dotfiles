export EDITOR="$(which code) --wait"
export VISUAL="$(which code) --wait"

# Make prompt nice and colorful.
autoload -U colors && colors
export PS1="%B%{${fg[yellow]}%}%n%{${fg[cyan]}%}@%{${fg[yellow]}%}%m %{${fg[cyan]}%}%(7~,.../,)%6~ %{${fg[yellow]}%}%% %b%{${fg[default]}%}"

# Case-insensitive autocomplete.
autoload -Uz compinit && compinit
zstyle ':completion:*' matcher-list '' 'm:{a-zA-Z}={A-Za-z}'

# Nicer kill-last-word behavior.
autoload -U select-word-style
select-word-style bash

# Load aliases.
source ~/.aliasrc
