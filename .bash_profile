#!.bash_profile

# * Chef DK
eval "$(chef shell-init bash)"

# * Bash history management with peco
#   - Required: Bash 4.x (You must upgrade if you're using MacOS)
#   - Replace Ctrl+r to peco-select-history
export HISTSIZE=2000
export HISTFILESIZE=10000
export HISTTIMEFORMAT='%Y/%m/%d %H:%M:%S '
export HISTCONTROL=ignorespace:ignoredups
export HISTIGNORE=rm:history
peco-select-history() {
  local HISTTIMEFORMAT=
  local l=$(\history | tac | perl -ne '/^\s*\d+\s+(.+)$/;if(!$h{$1}++){print "$1\n"};' |\
            peco --query "$READLINE_LINE" --prompt "[BACKLOG]" | head -n1)
  if [ -n "$l" ]; then
    READLINE_LINE="$l"
    READLINE_POINT=${#l}
  fi
}
bind -x '"\C-r": peco-select-history'

if [ -f ~/autologin/install_autologin.sh ]; then
  source ~/autologin/install_autologin.sh -q --encrypt-proxy
  if [ -n "$AUTOLOGIN_DIR" ]; then
    alias autologin='autologin -C'
    type complete >/dev/null 2>&1 && source ${AUTOLOGIN_DIR}/autologin_completion
  fi
fi

# * Macros and aliases
hash tac >/dev/null 2>&1 || alias tac="tail -r "
alias ll="ls -l "
alias la="ls -a "
alias au="autologin "
export PATH="$HOME/bin:$PATH"
