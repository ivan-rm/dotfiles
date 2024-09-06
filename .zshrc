# Turn off all beeps
setopt nobeep

# Avoid duplicates in PATH
typeset -U PATH

# HISTORY
HISTSIZE=50000
SAVEHIST=50000

setopt INC_APPEND_HISTORY     # Immediately append to history file.
setopt EXTENDED_HISTORY       # Record timestamp in history.
setopt HIST_EXPIRE_DUPS_FIRST # Expire duplicate entries first when trimming history.
setopt HIST_IGNORE_DUPS       # Dont record an entry that was just recorded again.
setopt HIST_IGNORE_ALL_DUPS   # Delete old recorded entry if new entry is a duplicate.
setopt HIST_FIND_NO_DUPS      # Do not display a line previously found.
setopt HIST_IGNORE_SPACE      # Dont record an entry starting with a space.
setopt HIST_SAVE_NO_DUPS      # Dont write duplicate entries in the history file.
setopt SHARE_HISTORY          # Share history between all sessions.
unsetopt HIST_VERIFY          # Execute commands using history (e.g.: using !$) immediately

# COMPLETION
#
# Add completions installed through Homebrew packages
# See: https://docs.brew.sh/Shell-Completion
if type brew &>/dev/null
then
  FPATH="$(brew --prefix)/share/zsh/site-functions:${FPATH}"
fi

# Enable advanced tab-completion
autoload -Uz compinit && compinit
compinit
# Improve the default's completion appearance
zstyle ':completion:*:descriptions' format '%U%B%d%b%u'
zstyle ':completion:*:warnings' format '%BSorry, no matches for: %d%b'

# Command correction
setopt correctall

# Initialize advanced prompt support
autoload -U promptinit
promptinit

# Load the VCS into the prompt
autoload -Uz vcs_info
zstyle ':vcs_info:*' enable git

# Ensure git info is up to date
precmd() { vcs_info }
setopt PROMPT_SUBST

zstyle ':vcs_info:git:*' check-for-changes true
zstyle ':vcs_info:git:*' formats "%F{green}(%b)%f"
zstyle ':vcs_info:git:*' actionformats "%F{yellow}(%b|%a)%f"
zstyle ':vcs_info:git:*' stagedstr "%F{green}●%f"
zstyle ':vcs_info:git:*' unstagedstr "%F{yellow}●%f"
zstyle ':vcs_info:git:*' deletedstr "%F{red}●%f"

PROMPT='%(?.%F{green}⏺.%F{red}⏺ [%?]) %F{blue}%~%f $ '
RPROMPT='${vcs_info_msg_0_}${vcs_info_msg_1_}${vcs_info_msg_2_}${vcs_info_msg_3_} '
RPROMPT+='%F{magenta}%*%f'

# Set the terminal title
case $TERM in xterm*)
    precmd () {print -Pn "\e]0;%~\a"}
    ;;
esac

# MacOS doesn't use GNU ls, activate colours for commands
export TERM="xterm-256color" CLICOLOR=1

# Custom aliases
source ~/.aliases
