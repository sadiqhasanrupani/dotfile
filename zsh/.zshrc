eval "$(starship init zsh)"

export EDITOR="nvim"
export SUDO_EDITOR="$EDITOR"

# export PGHOST="/var/run/postgresql"

# export PATH=$PATH:/usr/local/go/bin

HISTFILE=~/.history
HISTSIZE=10000
SAVEHIST=50000

# setopt inc_append_history

# . "$HOME/.asdf/asdf.sh"

# append completions to fpath
# fpath=(${ASDF_DIR}/completions $fpath)
# initialise completions with ZSH's compinit

# autoload -Uz compinit && compinit


# [ -f ~/.fzf.zsh ] && source ~/.fzf.zsh


# ------------------------------ Home Brew ------------------------
eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
# ----------------------------------------------------------------------------

# ------------------------------ Path Configuration ------------------------
# Add custom paths to $PATH variable
export PATH="$HOME/.tmuxifier/bin:$PATH"
export PATH="$HOME/development/flutter/bin:$PATH"
export PATH="$PATH:$HOME/go/bin"

# Set Python-related paths
export PATH="/usr/bin:$HOME/.local/bin:$PATH"
export PYTHONPATH="/usr/lib/python3.11/site-packages:$PYTHONPATH"

# -------------------------- Conda Initialization --------------------------
# Conda initialization block, will only run when 'active-conda' is set.
conda_initialize() {
    # Initialize Conda for the shell
    __conda_setup="$('$HOME/miniconda/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
    if [ $? -eq 0 ]; then
        eval "$__conda_setup"
    else
        if [ -f "$HOME/miniconda/etc/profile.d/conda.sh" ]; then
            . "$HOME/miniconda/etc/profile.d/conda.sh"
        else
            export PATH="$HOME/miniconda/bin:$PATH"
        fi
    fi
    unset __conda_setup
}

# Aliases to activate and deactivate Conda
#

# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:$HOME/.local/bin:/usr/local/bin:$PATH

# Path to your Oh My Zsh installation.
export ZSH="$HOME/.oh-my-zsh"

plugins=(git)

source $ZSH/oh-my-zsh.sh


# Set the default editor to Neovim
export EDITOR="nvim"

# Initialize NVM for Node.js version management
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# ------------------------------ Monitor Brightness Control ----------------------
# Function to control monitor brightness
# Usage: m 1 50 (sets laptop brightness to 50%)
#        m 2 70 (sets HDMI-A-1 monitor brightness to 70%)
#        m 1 50 2 70 (sets laptop to 50% and HDMI-A-1 to 70%)

# Function to set monitor brightness
m() {
  # Check for dual monitor setup (4 arguments)
  if [[ $# -eq 4 ]]; then
    local display1=$1
    local brightness1=$2
    local display2=$3
    local brightness2=$4
    
    # Validate first display
    if ! [[ "$display1" =~ ^[1-2]$ ]]; then
      echo "Error: First display must be 1 (laptop) or 2 (HDMI-A-1)"
      return 1
    fi
    
    # Validate second display
    if ! [[ "$display2" =~ ^[1-2]$ ]]; then
      echo "Error: Second display must be 1 (laptop) or 2 (HDMI-A-1)"
      return 1
    fi
    
    # Validate first brightness
    if ! [[ "$brightness1" =~ ^[0-9]+$ ]] || [ "$brightness1" -lt 1 ] || [ "$brightness1" -gt 100 ]; then
      echo "Error: First brightness must be a number between 1 and 100"
      return 1
    fi
    
    # Validate second brightness
    if ! [[ "$brightness2" =~ ^[0-9]+$ ]] || [ "$brightness2" -lt 1 ] || [ "$brightness2" -gt 100 ]; then
      echo "Error: Second brightness must be a number between 1 and 100"
      return 1
    fi
    
    # Set both displays
    # First, set display1
    if [ "$display1" -eq 1 ]; then
      echo "Setting laptop screen brightness to $brightness1"
      brightnessctl set "${brightness1}%"
      
      if [ $? -eq 0 ]; then
        echo "✓ Laptop brightness successfully set to $brightness1"
      else
        echo "✗ Failed to set laptop brightness"
      fi
    else
      echo "Setting HDMI-A-1 monitor brightness to $brightness1"
      sudo ddcutil setvcp 10 "$brightness1" --display 1
      
      if [ $? -eq 0 ]; then
        echo "✓ HDMI-A-1 monitor brightness successfully set to $brightness1"
      else
        echo "✗ Failed to set HDMI-A-1 monitor brightness"
      fi
    fi
    
    # Then, set display2
    if [ "$display2" -eq 1 ]; then
      echo "Setting laptop screen brightness to $brightness2"
      brightnessctl set "${brightness2}%"
      
      if [ $? -eq 0 ]; then
        echo "✓ Laptop brightness successfully set to $brightness2"
      else
        echo "✗ Failed to set laptop brightness"
      fi
    else
      echo "Setting HDMI-A-1 monitor brightness to $brightness2"
      sudo ddcutil setvcp 10 "$brightness2" --display 1
      
      if [ $? -eq 0 ]; then
        echo "✓ HDMI-A-1 monitor brightness successfully set to $brightness2"
      else
        echo "✗ Failed to set HDMI-A-1 monitor brightness"
      fi
    fi
    
    return 0
  # Original functionality (2 arguments)
  elif [[ $# -eq 2 ]]; then
    local display=$1
    local brightness=$2
    
    # Validate display is either 1 or 2
    if ! [[ "$display" =~ ^[1-2]$ ]]; then
      echo "Error: Display must be 1 (laptop) or 2 (HDMI-A-1)"
      return 1
    fi
    
    # Validate brightness is a number between 1-100
    if ! [[ "$brightness" =~ ^[0-9]+$ ]] || [ "$brightness" -lt 1 ] || [ "$brightness" -gt 100 ]; then
      echo "Error: Brightness must be a number between 1 and 100"
      return 1
    fi
    
    if [ "$display" -eq 1 ]; then
      # Display 1 - Laptop screen using brightnessctl
      echo "Setting laptop screen brightness to $brightness"
      brightnessctl set "${brightness}%"
      
      if [ $? -eq 0 ]; then
        echo "✓ Laptop brightness successfully set to $brightness"
      else
        echo "✗ Failed to set laptop brightness"
      fi
    else
      # Display 2 - HDMI-A-1 monitor using ddcutil
      echo "Setting HDMI-A-1 monitor brightness to $brightness"
      sudo ddcutil setvcp 10 "$brightness" --display 1
      
      if [ $? -eq 0 ]; then
        echo "✓ HDMI-A-1 monitor brightness successfully set to $brightness"
      else
        echo "✗ Failed to set HDMI-A-1 monitor brightness"
      fi
    fi
  # Invalid number of arguments
  else
    echo "Usage: m <display-number> <brightness-value>"
    echo "       m <display1-number> <brightness1-value> <display2-number> <brightness2-value>"
    echo "Example: m 1 50 (laptop screen)"
    echo "         m 2 70 (HDMI-A-1 monitor)"
    echo "         m 1 50 2 70 (sets laptop to 50% and HDMI-A-1 to 70%)"
    return 1
  fi
}

# Function to set laptop brightness
m1() {
  local brightness=$1
  
  # Validate brightness is a number between 1-100
  if ! [[ "$brightness" =~ ^[0-9]+$ ]] || [ "$brightness" -lt 1 ] || [ "$brightness" -gt 100 ]; then
    echo "Error: Brightness must be a number between 1 and 100"
    return 1
  fi
  
  # Set laptop screen brightness using brightnessctl
  echo "Setting laptop screen brightness to $brightness"
  brightnessctl set "${brightness}%"
  
  if [ $? -eq 0 ]; then
    echo "✓ Laptop brightness successfully set to $brightness"
  else
    echo "✗ Failed to set laptop brightness"
  fi
}

# Function to set external monitor brightness
m2() {
  local brightness=$1
  
  # Validate brightness is a number between 1-100
  if ! [[ "$brightness" =~ ^[0-9]+$ ]] || [ "$brightness" -lt 1 ] || [ "$brightness" -gt 100 ]; then
    echo "Error: Brightness must be a number between 1 and 100"
    return 1
  fi
  
  # Set HDMI-A-1 monitor brightness using ddcutil
  echo "Setting HDMI-A-1 monitor brightness to $brightness"
  sudo ddcutil setvcp 10 "$brightness" --display 1
  
  if [ $? -eq 0 ]; then
    echo "✓ HDMI-A-1 monitor brightness successfully set to $brightness"
  else
    echo "✗ Failed to set HDMI-A-1 monitor brightness"
  fi
}

# ---------------------------------------------------------------------------

# ------------------------------- Aliases -------------------------------

alias code='code'
alias ls="ls --color"
alias mnt-drive="~/dotfile/mntdrive/mntntfs.sh"
alias mysql="/usr/local/mysql-8.4.4/bin/mysql -u root -p -P 3307 -h 127.0.0.1"

# ---------------------------------------------------------------------------

# Monitor brightness aliases are removed in favor of the 'm' command

# ------------------------------- Github Aliases -------------------------------

alias gs="git status"
alias gd="git diff"

alias ga="git add"
alias gc="git commit"

alias gu="git pull"
alias gp"git push"

alias gl="git log"
alias gb"git branch"

alias gi="git init"
alias gcl"git clone"

# ------------------------------------------------------------------------------

# ----------------------------- Zinit Setup -------------------------------
# Zinit plugin manager setup for advanced plugin management
if [[ ! -f $HOME/.local/share/zinit/zinit.git/zinit.zsh ]]; then
    print -P "%F{33} %F{220} Installing ZDHARMA-CONTINUUM Plugin Manager (zinit)...%f"
    command mkdir -p "$HOME/.local/share/zinit" && command chmod g-rwX "$HOME/.local/share/zinit"
    command git clone https://github.com/zdharma-continuum/zinit "$HOME/.local/share/zinit/zinit.git" && \
        print -P "%F{33} %F{34} Installation successful.%f%b" || \
        print -P "%F{160} The clone has failed.%f%b"
fi

ZINIT_HOME="$HOME/.local/share/zinit/zinit.git"
source "${ZINIT_HOME}/zinit.zsh"

# --------------------------- Zinit Plugins -------------------------------
# Load commonly used Zsh plugins
zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions
zinit light Aloxaf/fzf-tab
# ---------------------------------------------------------------------------


# --------------------------- Keybindings -------------------------------
bindkey -e
bindkey '^p' history-search-backward
bindkey '^n' history-search-forward
# ---------------------------------------------------------------------------


# -------------------------- History Settings -----------------------------
# Configure history behavior for shared history and size
HISTSIZE=5000
HISTFILE=~/.zsh_history
SAVEHIST=$HISTSIZE
HISTDUP=erase
setopt appendhistory sharehistory hist_ignore_space hist_ignore_all_dups hist_save_no_dups hist_ignore_dups hist_find_no_dups
# ---------------------------------------------------------------------------


# ------------------------- Completion Settings ----------------------------
# Customize completion styles and fzf-tab integration
zstyle ':completion:*' matcher-llist 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' menu no
zstyle 'fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'
# ---------------------------------------------------------------------------


# --------------------------- Zoxide & fzf Integration -------------------
# Zoxide integration for faster directory navigation
eval "$(zoxide init zsh)"

# fzf integration for fuzzy search and file selection
eval "$(fzf --zsh)"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit
# ---------------------------------------------------------------------------


# --------------------------- Tmuxifier Integration ----------------------
# Initialize tmuxifier for enhanced tmux usage
eval "$(tmuxifier init -)"
# ---------------------------------------------------------------------------

# ------------------------- Pomodoro Timer Function ----------------------
# Configurable work and break sessions
declare -A pomo_options
pomo_options["work"]="25"
pomo_options["break"]="10"

# Function to display progress bar
show_progress_bar() {
  local duration=$1
  local total_seconds=$(( duration * 60 ))
  local elapsed=0

  while [[ $elapsed -le $total_seconds ]]; do
    local percentage=$(( (elapsed * 100) / total_seconds ))
    local remaining=$(( total_seconds - elapsed ))
    local time_left=$(date -u -d @${remaining} +%M:%S)

    clear
    echo -e "\n\033[1;32m we are working 🎅\033[0m"
    echo -e "\033[1;34m$(date +%I:%M%p) - ${time_left}\033[0m"
    
    # Progress bar
    printf "["
    for ((i = 0; i < percentage / 5; i++)); do printf "▉"; done
    for ((i = percentage / 5; i < 20; i++)); do printf " "; done
    printf "] %d%%\n" "$percentage"

    sleep 1
    ((elapsed++))
  done
}

pomodoro () {
  local session=$1
  local duration=${2:-${pomo_options["$session"]}}

  if [[ -n "$session" && -n "$duration" ]]; then
    # Announce the start of the session
    spd-say "'$session' session started"
    
    show_progress_bar "$duration"

    # Announce the end of the session
    spd-say "'$session' session done"
    swaync-client -s -t "Pomodoro Timer" -b "'$session' session done! 🎉"
  else
    echo "Session '$session' not found."
  fi
}

# Aliases for Pomodoro work and break sessions
alias wo="pomodoro 'work'"
alias br="pomodoro 'break'"

# Pomodoro Loop: Work → Break → Repeat
pomodoro_loop () {
  while true; do
    pomodoro "work"
    pomodoro "break"
  done
}
# ---------------------------------------------------------------------------
# Aliases for Pomodoro work and break sessions
alias wo="pomodoro 'work'"
alias br="pomodoro 'break'"
# ---------------------------------------------------------------------------


# ------------------------------ PostgreSQL Aliases ----------------------
# Alias for starting PostgreSQL service
alias pgstart="sudo systemctl start postgresql"
# ---------------------------------------------------------------------------


# ------------------------------ PostgreSQL Aliases ----------------------
# Alias for starting PostgreSQL service
alias pgstart="sudo systemctl start postgresql"
# ---------------------------------------------------------------------------


# --------------------------- Zinit Annexes ------------------------------
# Load additional Zinit annexes for enhanced functionality
zinit light-mode for \
    zdharma-continuum/zinit-annex-as-monitor \
    zdharma-continuum/zinit-annex-bin-gem-node \
    zdharma-continuum/zinit-annex-patch-dl \
    zdharma-continuum/zinit-annex-rust
# ---------------------------------------------------------------------------

# ------------------------------ Nerdfetch -----------------------------------
nerdfetch
# ----------------------------------------------------------------------------

# Aliases to activate and deactivate Conda
alias active-conda='conda_initialize'
alias deactive-conda='conda deactivate'

# Conda initialization will only run if active-conda is called

