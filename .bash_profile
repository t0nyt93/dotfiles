PATH=$PATH:/usr/local/sbin
source ~/.bashrc

# You were kind to me Python v2, but you're old, decrepit, and need to die.
alias python='python3'
alias kdiff3='/Applications/kdiff3.app/Contents/MacOS/kdiff3'

# added by Anaconda2 5.1.0 installer
export PATH="/anaconda2/bin:$PATH"

# added by Miniconda3 installer
export PATH="/Users/atyrrell/miniconda3/bin:$PATH"

alias npm-react='npm config set registry https://registry.npmjs.org && yarn config set registry https://registry.npmjs.org'
alias npm-default='npm config set registry http://npm.aws.cbtnuggets.com  && yarn config set registry http://npm.aws.cbtnuggets.com'

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*
