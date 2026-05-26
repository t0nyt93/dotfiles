export ZSH="/Users/atyrrell/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="half-life"
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#ff00ff,bg=cyan,bold,underline"

# Customize our CLI Prompt
PROMPT='%{$fg[yellow]%}[%D{%m/%f/%y} %D{%L:%M:%S}] '$PROMPT

export ZSH_DISABLE_COMPFIX=true
export NVM_DIR=~/.nvm
export TERM_COLOR=truecolor
export FZF_DEFAULT_COMMAND='ag --path-to-ignore ~/.agignore ""'

decode_jwt() {
  echo "$1" | jq -R 'split(".") | .[0,1] | @base64d | fromjson'
}


[ -f ~/.zprofile ] && source ~/.zprofile



# GIT ALIASES
alias gitp="git log --pretty=oneline"
alias git-commits='git log main.. --pretty=oneline | wc -l'
alias gitp="git log --pretty=oneline"
alias gitb="git branch --sort=-committerdate | sed -n '1,10p'"
alias git-branches='git branch --sort=-committerdate | sed -n "1,15p"'

# QOL
alias vim=nvim
alias python='python3'
alias config='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'
alias z='zellij'


export EDITOR=nvim

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

# Uncomment the following line to disable auto-setting terminal title.
DISABLE_AUTO_TITLE="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# Caution: this setting can cause issues with multiline prompts (zsh 5.7.1 and newer seem to work)
# See https://github.com/ohmyzsh/ohmyzsh/issues/5765
COMPLETION_WAITING_DOTS="true"

plugins=(
    git
    zsh-autosuggestions
    zsh-syntax-highlighting
)

source $ZSH/oh-my-zsh.sh

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

alias ha-sync='cd ~/Projects/ShoshoneNexus && ./scripts/ha-sync.sh'

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

source $ZSH/oh-my-zsh.sh

# Source some other files that are machine dependeny...
source ~/dotfiles/zsh/.zshrc_keys
source ~/dotfiles/zsh/.zshrc_local


# User configuration
source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
