#!/bin/bash
############################
# makesymlinks.sh
# This script creates symlinks from the home directory to any desired dotfiles in ~/dotfiles
############################

########## Variables

dir=~/dotfiles                    # dotfiles directory
olddir=~/dotfiles_old             # old dotfiles backup directory
files=".bashrc .vimrc .gitconfig .tmux.conf"    # list of files/folders to symlink in homedir
vimDir=~/.vim/colors		# vim directory

##########

# Git prompt
echo -n "Getting git-prompt.sh"
echo -n ""
curl https://raw.githubusercontent.com/git/git/master/contrib/completion/git-prompt.sh > ~/.git-prompt.sh
curl https://raw.githubusercontent.com/git/git/master/contrib/completion/git-completion.bash > ~/.git-completion.bash
echo "done"

# Get dircolors for Bash console
echo -n "Getting and applying dircolors"
echo -n ""
curl https://raw.githubusercontent.com/seebi/dircolors-solarized/master/dircolors.256dark > ~/.dircolors
echo "done"

# Add vim colors
echo -n "Creating $vimDir and getting gruvbox"
mkdir -p $vimDir
echo -n ""
curl https://raw.githubusercontent.com/morhetz/gruvbox/master/colors/gruvbox.vim > $vimDir/gruvbox.vim
echo "done"

# create dotfiles_old in homedir
echo -n "Creating $olddir for backup of any existing dotfiles in ~ ..."
mkdir -p $olddir
echo "done"

# change to the dotfiles directory
echo -n "Changing to the $dir directory ..."
cd $dir
echo "done"

# move any existing dotfiles in homedir to dotfiles_old directory, then create symlinks from the homedir to any files in the ~/dotfiles directory specified in $files
for file in $files; do
    echo "Moving any existing dotfiles from ~ to $olddir"
    mv ~/$file ~/dotfiles_old/
    echo "Creating symlink to $file in home directory."
    ln -s $dir/$file ~/$file
done
