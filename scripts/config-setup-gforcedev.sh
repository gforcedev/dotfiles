cd

echo ".cfg" >> .gitignore
git clone git@github.com:gforcedev/dotfiles.git $HOME/.cfg --bare

/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME config --local status.showUntrackedFiles no

echo "Setup complete - run 'config checkout' to instantiate the files"
