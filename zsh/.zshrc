export ZSH="/Users/atyrrell/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="half-life"
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=244,italics"
ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE=20
ZSH_AUTOSUGGEST_USE_ASYNC=true
ZSH_AUTOSUGGEST_STRATEGY=(match_prev_cmd history)

export ZSH_DISABLE_COMPFIX=true
export TERM_COLOR=truecolor
export FZF_DEFAULT_COMMAND='rg --files --hidden --glob "!.git"'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

decode_jwt() {
  echo "$1" | jq -R 'split(".") | .[0,1] | @base64d | fromjson'
}




# GIT ALIASES
alias git-commits='git log main.. --pretty=oneline | wc -l'

alias gitp="git log --pretty=oneline"

alias precommit="npm run lint:quiet && npm run test"
alias gpp="npm run lint:quiet && npm run test && git push"

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
)

source $ZSH/oh-my-zsh.sh

# Custom git shortcuts (after oh-my-zsh so they override the git plugin)
ghelp() {
  local f=~/.aliases/github.aliases.md
  if (( $+commands[glow] )); then glow "$f"; return; fi
  sed -E \
    -e 's/^# (.*)/\x1b[1;35m\1\x1b[0m/' \
    -e 's/^## (.*)/\x1b[1;33m\1\x1b[0m/' \
    -e 's/^- `([^`]*)`/  \x1b[1;36m\1\x1b[0m/' \
    -e 's/^- /  /' \
    -e 's/\(oh-my-zsh\)/\x1b[2m(oh-my-zsh)\x1b[0m/' "$f"
}
# gcb and gd already come from the git plugin
# half-life theme only refreshes git info when the typed command contains "git"
_always_refresh_git_prompt() { PR_GIT_UPDATE=1; }
add-zsh-hook preexec _always_refresh_git_prompt
gcbt() { git checkout -b "tonyt/$1"; }
alias gcm='git checkout main && git pull'
# gck [msg]: stage everything (incl. new files) and commit; default message "checkpoint"
gck() {
  git add -A
  if git diff --cached --quiet; then
    echo "nothing to checkpoint"; return 1
  fi
  git commit -m "${*:-checkpoint}"
}
gxb() {
  local branch
  branch=$(git branch --sort=-committerdate \
      --format='%(refname:short)%09%(committerdate:relative)%09%(subject)' \
    | column -t -s $'\t' \
    | fzf --height 50% --reverse --prompt='checkout > ' --nth=1 \
          --preview 'git log --oneline --color=always -15 {1}' \
    | awk '{print $1}') || return
  [[ -n "$branch" ]] && git checkout "$branch"
}

# gsync [-n] [-m]: update local main in place, predict conflicts, rebase onto main.
#   -n  dry run: fetch + report only.  -m  merge main instead of rebasing.
gsync() {
  local dry=0 mode=rebase opt
  while getopts "nm" opt; do
    case $opt in
      n) dry=1 ;;
      m) mode=merge ;;
      *) echo "usage: gsync [-n] [-m]"; return 1 ;;
    esac
  done

  local branch
  branch=$(git rev-parse --abbrev-ref HEAD) || return 1
  if [[ $branch == main ]]; then
    git pull --ff-only origin main; return
  fi
  if [[ -n $(git status --porcelain) ]]; then
    echo "working tree is dirty; commit or stash first"; return 1
  fi

  git fetch origin main:main || return 1

  local base
  base=$(git merge-base HEAD main)
  local -a incoming
  incoming=("${(@f)$(git log --oneline $base..main)}")
  if [[ -z $incoming[1] ]]; then
    echo "$branch is already up to date with main"; return 0
  fi

  echo "\n== ${#incoming} incoming commit(s) on main =="
  printf '  %s\n' "${incoming[@]}"

  local -a overlap
  overlap=("${(@f)$(comm -12 \
    <(git diff --name-only $base main | sort) \
    <(git diff --name-only $base HEAD | sort))}")
  if [[ -n $overlap[1] ]]; then
    echo "\n== ${#overlap} file(s) changed on BOTH sides (likely conflicts) =="
    local f
    for f in "${overlap[@]}"; do
      echo "  $f"
      git log --format='      %h %an: %s' $base..main -- "$f"
    done
  else
    echo "\n== no overlapping files; $mode should be clean =="
  fi

  (( dry )) && { echo "\n(dry run; nothing changed)"; return 0 }

  echo
  if [[ $mode == merge ]]; then
    git merge main && return 0
  else
    git rebase main && return 0
  fi

  echo "\n== $mode stopped on conflicts =="
  for f in $(git diff --name-only --diff-filter=U); do
    echo "  $f"
    git log --format='      %h %an: %s' $base..main -- "$f"
  done
  echo "\nresolve, then:  git add <files> && git $mode --continue"
  echo "or bail:        git $mode --abort"
  [[ $mode == rebase ]] && echo "or merge instead: git rebase --abort && gsync -m"
  return 1
}

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

alias ha-sync='cd ~/Projects/ShoshoneNexus && ./scripts/ha-sync.sh'

#-----------------------------------
# HOME ASSISTANT THINGS
alias mosquittoSub="/usr/bin/mosquitto_sub"

export HA_HOST="ws://192.168.0.143:8123/api/websocket"
export HA_TOKEN="eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiIyYWY5MmQ1OTQ3ODU0ZjliOTVmZmI1MzhjMjA4NmM4NyIsImlhdCI6MTc3OTE1MzAxOCwiZXhwIjoyMDk0NTEzMDE4fQ.VnKrcsuhTIYDxL4gX4p10bJpr6c9joRzHxbcO9vzem4"
export LOG_LEVEL="DEBUG"


# END OF HOME ASSISTANT THINGS
#-----------------------------------

# Source some other files that are machine dependeny...
source ~/dotfiles/zsh/.zshrc_keys
source ~/dotfiles/zsh/.zshrc_local


# User configuration
source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# >>> adept cap >>>
# Managed by 'adept cap'. Re-run the command to update.
export ADEPT_PROFILE_DIR="$HOME/.adept_profiles"

cap() {
  if [ -z "$1" ]; then
    echo "Usage: cap <profile_name>" >&2
    echo "Available:" >&2
    ls "$ADEPT_PROFILE_DIR"/*.sh 2>/dev/null | xargs -n1 basename 2>/dev/null | sed 's/\.sh$//' | sed 's/^/  /' >&2
    return 1
  fi
  local profile="$ADEPT_PROFILE_DIR/$1.sh"
  if [ ! -f "$profile" ]; then
    echo "Profile '$1' does not exist at $profile" >&2
    return 1
  fi
  source "$profile"
  echo "Switched to profile: $PROFILE_NAME"
}

_cap() {
  local profiles_dir="$HOME/.adept_profiles"
  local profiles=(${(f)"$(ls ${profiles_dir}/*.sh 2>/dev/null)"})
  profiles=(${profiles[@]##*/})
  profiles=(${profiles[@]%.sh})
  _describe 'profiles' profiles
}
compdef _cap cap

# Unset everything any cap profile exports, restoring a clean shell.
capclear() {
  local v
  for v in $(grep -h '^export ' "$ADEPT_PROFILE_DIR"/*.sh 2>/dev/null \
      | sed 's/^export \([A-Za-z_][A-Za-z0-9_]*\)=.*/\1/' | sort -u); do
    unset "$v"
  done
  echo "cap profile cleared"
}
# <<< adept cap <<<
eval "$(/opt/homebrew/bin/brew shellenv)"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
