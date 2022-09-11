# If you come from bash you might have to change your $PATH.
#export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.

export ZSH="/Users/atyrrell/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="half-life"

export ZSH_DISABLE_COMPFIX=true
export NVM_DIR=~/.nvm
export ADEPT_HOME=~/Projects/adept
export AWS_SDK_LOAD_CONFIG=true
export AWS_PROFILE=adept-tony
export AWS_REGION=us-west-2
export ACCOUNT_ALIAS=adept-tony
export NODE_OPTIONS=--max-old-space-size=8192

alias gitp="git log --pretty=oneline"
alias ctags='/usr/local/bin/ctags'

alias python='python3'
alias learndev="NODE_ENV=development npm start"

alias browsedev="HTTPS=true SSL_CRT_FILE=~/Projects/adept/dev-certs/cert.pem SSL_KEY_FILE=~/Projects/adept/dev-certs/key.pem NODE_ENV=development HOST=dev.tony.adept.at npm run dev"

alias startapi="AWS_PROFILE=adept-tony NODE_ENV=tony npm run start:live"


alias deploy_learn_dev='AWS_REGION=us-east-1 AWS_PROFILE=adept-tony aws s3 sync ./build/ s3://adept-tony-us-east-1-webapp --cache-control="public, max-age=31536000" && AWS_REGION=us-west-2 AWS_PROFILE=adept-tony aws s3 cp ./build/index.html s3://adept-tony-us-west-2-webapp --cache-control="no-cache"'

alias deploy_learn_dev_west='AWS_PROFILE=adept-tony aws s3 sync ./build/ s3://adept-tony-us-west-2-webapp --cache-control="public, max-age=31536000"'

alias deploy_api_dev='AWS_PROFILE=adept-tony NODE_ENV=tony npx serverless deploy --stage=live --verbose --region us-east-1; NODE_ENV=tony AWS_PROFILE=adept-tony npx serverless deploy --stage=live --verbose --region us-west-2'
# Needed for FZF Vim to use Ag
#
export FZF_DEFAULT_COMMAND='ag --path-to-ignore ~/.agignore ""'

# Control Audio Output (brew install switchaudio-osx)
alias useSpeakers="SwitchAudioSource -s \"MacBook Pro Speaker\""
alias useYeti="SwitchAudioSource -s \"Yeti Stereo Microphone\""
alias useJBL="SwitchAudioSource -s \"JBL LIVE FREE 2 TWS\""


function setterm {
	# Escape the argument for printf formatting.
    echo $1
	local title=$1
	title=${title//\\/\\\\}
	title=${title//\"/\\\"}
	title=${title//\%/\%\%}

	# OSC 0, 1, and 2 are the portable escape codes for setting window titles.
	printf "\e]0;$title\a"  # Both tab and window
	printf "\e]1;$title\a"  # Tab title
	printf "\e]2;$title\a"  # Window title
}

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to automatically update without prompting.
# DISABLE_UPDATE_PROMPT="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# Caution: this setting can cause issues with multiline prompts (zsh 5.7.1 and newer seem to work)
# See https://github.com/ohmyzsh/ohmyzsh/issues/5765
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
    git
    zsh-syntax-highlighting
    zsh-autosuggestions
)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
