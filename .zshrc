# Executes commands at the start of any interactive session.
# Shell options, functions, and aliases go here!
# Environment variables do *not* go here. They go in .zprofile.
#

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# no ding!
ZBEEP=""

# allow variables in PS1
setopt PROMPT_SUBST

setopt EXTENDED_HISTORY          # Write the history file in the ":start:elapsed;command" format.
setopt SHARE_HISTORY             # Share history between all sessions.
setopt HIST_EXPIRE_DUPS_FIRST    # Expire duplicate entries first when trimming history.
setopt HIST_IGNORE_ALL_DUPS      # Delete old recorded entry if new entry is a duplicate.
setopt HIST_FIND_NO_DUPS         # Do not display a line previously found.
setopt HIST_SAVE_NO_DUPS         # Don't write duplicate entries in the history file.
setopt COMPLETE_IN_WORD          # tab in the middle of a word works correctly!
setopt ALWAYS_TO_END
setopt INTERACTIVE_COMMENTS      # sometimes I copy-paste comments
setopt NOMATCH                   # refuse to use ambiguous globs
setopt CHASE_DOTS                # resolve ".." paths textually, not physically
setopt AUTO_CD                   # using a directory as a command implies "cd"

unsetopt EXTENDED_GLOB           # weird zsh-specific globbing
unsetopt BEEP                    # no, thanks
unsetopt NOTIFY                  # background jobs' status waits for prompt

HISTFILE="$HOME/.zsh_history"
if [[ $TMUX_PANE ]]; then
    HISTFILE="$HOME/.zsh_history_${TMUX_PANE:1}"
fi

function history() {
  if [[ "$#" -eq 0 ]] ; then
    # Modify default options.
    set -- -LDi -n
  fi
  builtin history "$@"
}

# enable advanced command completion: fpath must be set before "compinit"
fpath+=(
  ~/.zsh_completion
  "$HOMEBREW_PREFIX"/completions/zsh
  "$HOMEBREW_PREFIX"/share/zsh/site-functions
)
autoload -Uz compinit
compinit
zstyle ':completion:*' insert-unambiguous yes
zstyle ':completion:*' verbose yes
zstyle ':completion:*' select yes
## this causes ambiguous completions:
#zstyle ':completion:*' menu yes

