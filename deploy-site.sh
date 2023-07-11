#!/bin/zsh
 rsync --delete --exclude=".git" --exclude=".nova" --exclude=".DS_Store" -avz ./ prod:/var/www/jamiedumont.com/html