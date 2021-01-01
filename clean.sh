#!/bin/zsh

links=("${(@f)$(find ~ -maxdepth 2 -path '*.Trash*' -prune -false -o -type l)}")
for link in $links
do
    if read -q "choice?rm $link? "
    then
        rm $link
    else
        echo "\nnot removing $link"
    fi
done
