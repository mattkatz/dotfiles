#! /bin/bash

# Installs or updates all settings and configurations
# 
# TODO:
#   Check for vim, curl and vim+python
#   Don't try submodules if no git
#   Check success of submodule updates
#   Test if we can get ssh?
#   Test success of Vundle update
#   
#   cd && git clone http://github.com/captbaritone/dotfiles && dotfiles/install.sh
#   curl bit.ly/installdots
#     Could run git clone for us?
#     Can't depend of either wget or curl :(

cd ~/dotfiles

# Check for some required tools
echo "Checking for commonly used tools:"
# git
if [ `command -v git` ]; then
    echo "    OK - Git"
else
    echo "    MISSING - Git"
    echo -e "\nYou serioulsy expect me to do this witout git?. Fix that shit."
    exit
fi
# vim
if [ `command -v vim` ]; then
    echo "    OK - Vim"
    #   +python?
    if [ "$(vim --version | grep \+python)" ]; then
        echo "    OK - Vim +python"
    else
        echo "    MISSING - Vim +python (Gundo won't work)"
    fi
else
    echo "    MISSING - Vim"
fi

# curl
if [ `command -v curl` ]; then
    echo "    OK - Curl"
else
    echo "    Missing - Curl (Vim-Gist won't work)"
fi

echo "Updating dotfiles:"
# Is the dotfiles repo clean?
if [[ $(git status 2> /dev/null | tail -n1 | cut -c1-17) = "nothing to commit" ]]; then
  if [[ $(git pull 2> /dev/null) = "Already up-to-date." ]]; then
    echo "    OK - Already up-to-date"
  else
    echo "    OK - Updated dotfiles"
  fi
  # Perhaps here we should 
else
  echo "    NOTICE - Did not upldate dotfiles (unclean)"
fi


echo "Updating submodules:"
git submodule update -q --init ~/dotfiles/vim/bundle/vundle
echo "    OK - Vundle"
git submodule update -q --init ~/dotfiles/tools/z
echo "    OK - Z"
#echo "    .ssh..."
#git submodule update -q --init ~/dotfiles/ssh

echo "Updating Vundle bundles:"
vim -u ~/.vim/bundles.vim +BundleInstall +qall
echo "    OK"

echo "Linking dotfiles into place:"
for name in *; do
    if [ "$name" != 'install.sh' ] && [ "$name" != 'README.md' ] && [ "$name" != 'tools' ] && [ "$name" != 'ssh' ]; then
        target="$HOME/.$name"
        if [ "$target" -ef "$name" ]; then
            echo "    OK - .$name"
        else
            if [ -e "$target" ]; then
                mv $target "$target.local"
                echo "    MOVED - $target to $target.local"
            fi
            ln -s "$PWD/$name" "$target"
            echo "    INSTALLED .$name"
        fi
    fi
done

echo -e "\nInstallation complete. You may wish to issue the following:"
echo "    . ~/.bashrc"
