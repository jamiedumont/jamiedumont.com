#!/bin/zsh
 rsync --delete --exclude=".DS_Store" -avz ./html/ prod:/var/www/jamiedumont.com/html