#!/bin/zsh
 rsync --delete --exclude=".DS_Store" -avz ./ prod:/var/www/jamiedumont.com/html