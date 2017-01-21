#!/usr/bin/env bash

EXCLUDED_ITEMS=(
  ".DS_Store" ".git/" "sync.sh" "README.md"
)

git pull origin master;

function build_options() {
  OPTIONS=''
  for ITEM in ${EXCLUDED_ITEMS[@]}
  do
    OPTIONS="$OPTIONS --exclude $ITEM"
  done
  echo $OPTIONS
}

function sync() {
  OPTIONS=$(build_options);
  rsync $OPTIONS -avh --no-perms . ~;
#	ls -A | grep -e ^\\. | while read file; do
#		cat $file >> ~/${file};
#    done;
}

if [ "$1" == "--force" -o "$1" == "-f" ]; then
  sync;
else
	read -p "This may overwrite existing files in your home directory. Are you sure? (y/n) " -n 1;
	echo "";
	if [[ $REPLY =~ ^[Yy]$ ]]; then
		sync;
	fi;
fi;
unset sync;

source ~/.zshrc;
