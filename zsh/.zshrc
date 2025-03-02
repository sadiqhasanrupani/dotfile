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
export PATH="/opt/flutter/bin:$PATH"
export PATH="$PATH:$HOME/go/bin"

# Set Python-related paths
export PATH="/usr/bin:$HOME/.local/bin:$PATH"
export PYTHONPATH="/usr/lib/python3.11/site-packages:$PYTHONPATH"

# -------------------------- Conda Initialization --------------------------
# Conda initialization block, will only run when 'active-conda' is set.
conda_initialize() {
    # Initialize Conda for the shell
    __conda_setup="$('/mnt/D/anaconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
    if [ $? -eq 0 ]; then
        eval "$__conda_setup"
    else
        if [ -f "/mnt/D/anaconda3/etc/profile.d/conda.sh" ]; then
            . "/mnt/D/anaconda3/etc/profile.d/conda.sh"
        else
            export PATH="/mnt/D/anaconda3/bin:$PATH"
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


# -------------------------- Conda Initialization --------------------------
# Conda initialization block, will only run when 'active-conda' is set.
conda_initialize() {
    # Initialize Conda for the shell
    __conda_setup="$('/mnt/D/anaconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
    if [ $? -eq 0 ]; then
        eval "$__conda_setup"
    else
        if [ -f "/mnt/D/anaconda3/etc/profile.d/conda.sh" ]; then
            . "/mnt/D/anaconda3/etc/profile.d/conda.sh"
        else
            export PATH="/mnt/D/anaconda3/bin:$PATH"
        fi
    fi
    unset __conda_setup
}

# Aliases to activate and deactivate Conda
alias active-conda="conda_initialize"
alias deactive-conda="unset CONDA_EXE; unset _CONDA_ROOT; unset CONDA_DEFAULT_ENV; unset CONDA_PREFIX; unset CONDA_SHLVL; unset conda; unset __conda_setup"

# Conda initialization will only run if active-conda is called
if [[ -n "$CONDA_EXE" ]]; then
    conda_initialize
fi
# ---------------------------------------------------------------------------


# ----------------------------- User Configuration -------------------------
# Set the default editor to Neovim
export EDITOR="nvim"

# Initialize NVM for Node.js version management
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# ------------------------------- Aliases -------------------------------
alias code='code'
alias ls="ls --color"
alias mnt-drive="~/dotfile/mntdrive/mntntfs.sh"

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
