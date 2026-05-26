# If you come from bash you might have to change your $PATH.
#export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.

export ZSH="/home/atyrrell/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="half-life"

export ZSH_DISABLE_COMPFIX=true
export NVM_DIR=~/.nvm
export NODE_OPTIONS=--max-old-space-size=8192
export TERM_COLOR=truecolor

alias gitp="git log --pretty=oneline"
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

# Uncomment the following line to disable auto-setting terminal title.
DISABLE_AUTO_TITLE="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# Caution: this setting can cause issues with multiline prompts (zsh 5.7.1 and newer seem to work)
# See https://github.com/ohmyzsh/ohmyzsh/issues/5765
COMPLETION_WAITING_DOTS="true"

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

plugins=(
    git
    zsh-syntax-highlighting
    zsh-autosuggestions
)

source $ZSH/oh-my-zsh.sh

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

alias ha-sync='cd ~/Projects/ShoshoneNexus && ./scripts/ha-sync.sh'
alias vim='nvim'

#-----------------------------------
# HOME ASSISTANT THINGS
alias mosquittoSub="/usr/bin/mosquitto_sub"

export HA_HOST="ws://192.168.0.143:8123/api/websocket"
export HA_TOKEN="eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiIyYWY5MmQ1OTQ3ODU0ZjliOTVmZmI1MzhjMjA4NmM4NyIsImlhdCI6MTc3OTE1MzAxOCwiZXhwIjoyMDk0NTEzMDE4fQ.VnKrcsuhTIYDxL4gX4p10bJpr6c9joRzHxbcO9vzem4"
export LOG_LEVEL="DEBUG"


# END OF HOME ASSISTANT THINGS
#-----------------------------------

# Start ssh-agent if it's not already running
if [ -z "$SSH_AUTH_SOCK" ]; then
  eval "$(ssh-agent -s)"
     ssh-add ~/.ssh/id_ed25519 # Replace with the actual name of your key if different
fi

# Add wisely, as too many plugins slow down shell startup.
plugins=(git)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv zsh)"
