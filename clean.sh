#!/bin/zsh

links=("${(@f)$(find ~ -maxdepth 2 -path '*.Trash*' -prune -false -o -type l)}")
for link in $links
do
    echo "rm $link"
    rm $link
done
