# Turn off all beeps
setopt nobeep

# Enable command completion
autoload -Uz compinit promptinit
compinit
promptinit

# MacOS doesn't use GNU ls, activate colours for commands
export TERM="xterm-256color" CLICOLOR=1

# Custom aliases
source ~/.zsh_aliases

# Set 1Password's SSH agent enviroment variable
export SSH_AUTH_SOCK=~/.1password/agent.sock

# Use homebrew's curl (more up to date)
export PATH="/opt/homebrew/opt/curl/bin:$PATH"

# Rust - Add cargo to $PATH
$HOME/.cargo/bin
