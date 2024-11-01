#!/usr/bin/env zsh
cd /workspaces/autoteam
git clone https://github.com/flachica/autoteam-front.git -b develop
git clone https://github.com/flachica/autoteam-back.git -b develop
cd autoteam-back
npm install
cd ..
cd autoteam-front
npm install

if [ ! -f $HOME/.copied ]; then
    touch $HOME/.copied
    echo "source /workspaces/autoteam/.devcontainer/aliases.sh" >> $HOME/.zshrc
fi
source $HOME/.zshrc
