export PATH="/Users/atyrrell/Library/Python/2.7/bin:$PATH"
export PATH="/Applications/kdiff3.app/Contents/MacOS:$PATH"
FIGNORE='package-lock.json'

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm

export NODE_ENV=development
export LOCAL_ENV=true
export ASSUME_ROLE=true
export NODE_LOGGER_CONSOLE=true
export NODE_LOGGER_CONSOLE_LEVEL=debug
export SKIP_BOT_MESSAGES=true

#Everyday Dev Aliases to make life easier.
#-> DB Aliases for quick access
alias qamongo='mongo --host 172.18.21.152'
alias qamongo-pps='/usr/local/Cellar/mongodb/3.4.7/bin/mongo --host 172.18.31.32 payment-provider'

alias qamongo-pps2='/usr/local/Cellar/mongodb/3.4.7/bin/mongo --host 172.18.21.140.mongo.qa.us-east-1.nuggets.local payment-provider'


alias qamongo-pps3='/usr/local/Cellar/mongodb/3.4.7/bin/mongo --host 172.18.41.24.mongo.qa.us-east-1.nuggets.local payment-provider'

alias prodmongo-pps1='/usr/local/Cellar/mongodb/3.4.7/bin/mongo --host 172.18.41.225 payment-provider'
alias prodmongo-pps2='/usr/local/Cellar/mongodb/3.4.7/bin/mongo --host 172.18.21.41 payment-provider'
alias prodmongo-pps3='/usr/local/Cellar/mongodb/3.4.7/bin/mongo --host 172.18.31.11 payment-provider'

alias qamongo-irs3='/usr/local/Cellar/mongodb/3.4.7/bin/mongo --host 172.18.21.143 internal-receipt'

alias qamongo-irs2='/usr/local/Cellar/mongodb/3.4.7/bin/mongo --host 172.18.41.242 internal-receipt'

alias qamongo-irs='/usr/local/Cellar/mongodb/3.4.7/bin/mongo --host 172.18.31.51 internal-receipt'

alias pmongo='mongo --host 172.18.21.51'

alias nodetest='NODE_ENV=test npm test'
alias startqa='NODE_ENV=qa node app.js'
alias startprod='NODE_ENV=production node app.js'
alias startdev='NODE_ENV=integration node app.js'

#ESlint simplification alias.
alias eslint-this='./node_modules/eslint/bin/eslint.js .'
alias eslint-this2='./node/node_modules/eslint/bin/eslint.js . --ignore-path .gitignore'
alias eslint-fix='./node_modules/eslint/bin/eslint.js . --fix --ignore-path .gitignore'
alias eslint-fix2='./node/node_modules/eslint/bin/eslint.js . --fix --ignore-path .gitignore'

alias startredis='redis-server /usr/local/etc/redis.conf'
alias startardor='~/Downloads/ardor/run.sh'

alias gentags='find ./node -name "*.js" -not -path "./node/node_modules/*" -exec jsctags {} -f \; | sed "/^&/d" | sort > tags'

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
