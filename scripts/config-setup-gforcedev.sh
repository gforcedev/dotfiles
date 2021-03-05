cd

echo ".cfg" >> .gitignore
git clone git@github.com:gforcedev/dotfiles.git $HOME/.cfg --bare

/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME config --local status.showUntrackedFiles no

echo Setup complete - run \"alias config=\'/usr/bin/git --git-dir=\$HOME/.cfg/ --work-tree=\$HOME\'\", and then \"config checkout\" to instantiate the files

