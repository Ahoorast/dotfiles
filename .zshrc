# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=10000
SAVEHIST=10000
ZSH_THEME="powerlevel10k/powerlevel10k"
bindkey -e
# 
bindkey -e
bindkey "^[[1;5C" forward-word
bindkey "^[[1;5D" backward-word
# End of lines configured by zsh-newuser-install

export PATH="$HOME/.local/bin:$PATH"

# ---------------------------------------------------------------------------
# History behaviour
# ---------------------------------------------------------------------------
setopt HIST_IGNORE_ALL_DUPS      # don't keep duplicate commands in history
setopt HIST_IGNORE_SPACE         # commands starting with a space aren't saved
setopt HIST_REDUCE_BLANKS        # trim superfluous whitespace
setopt HIST_VERIFY               # expand !! etc. into the line instead of running
setopt SHARE_HISTORY             # share history live between running shells
setopt EXTENDED_HISTORY          # record timestamps

# ---------------------------------------------------------------------------
# Prefix-based history search on the arrow keys
#   type the start of a command, press Up/Down to cycle matching history
# ---------------------------------------------------------------------------
autoload -Uz up-line-or-beginning-search down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search

bindkey '^[[A' up-line-or-beginning-search      # Up
bindkey '^[[B' down-line-or-beginning-search    # Down
bindkey '^P'   up-line-or-beginning-search      # Ctrl-P
bindkey '^N'   down-line-or-beginning-search    # Ctrl-N

# terminfo variants (application keypad mode, tmux, etc.)
[[ -n ${terminfo[kcuu1]} ]] && bindkey "${terminfo[kcuu1]}" up-line-or-beginning-search
[[ -n ${terminfo[kcud1]} ]] && bindkey "${terminfo[kcud1]}" down-line-or-beginning-search

# incremental history search: Ctrl-R / Ctrl-S
bindkey '^R' history-incremental-search-backward
bindkey '^S' history-incremental-search-forward

# ---------------------------------------------------------------------------
# Completion system
# ---------------------------------------------------------------------------
autoload -Uz compinit && compinit
zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'   # case-insensitive

# ---------------------------------------------------------------------------
# fish-style inline autosuggestions from history (optional plugin)
# ---------------------------------------------------------------------------
if [[ -r /usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh ]]; then
  source /usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh
  ZSH_AUTOSUGGEST_STRATEGY=(history completion)
fi
if [[ -r /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ]]; then
  source /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
fi

eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv zsh)"

# clipboard: Wayland session needs wl-copy; xclip only writes the (X)Wayland
# clipboard which native apps do not read. Falls back to xclip on plain X.
if [[ "$XDG_SESSION_TYPE" == "wayland" ]] && (( $+commands[wl-copy] )); then
  alias copy="wl-copy"
  alias paste="wl-paste"
else
  alias copy="xclip -selection clipboard"
  alias paste="xclip -selection clipboard -o"
fi
alias kubectl="kubecolor"
alias nv="nvim"
alias ovpn="sudo openvpn --config ~/.ovpn/pf-primary-TCP4-11977-config.ovpn --auth-user-pass ~/.ovpn/auth.txt"

# bun completions
[ -s "/home/tapsell/.bun/_bun" ] && source "/home/tapsell/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"
export PATH="/opt/nvim/bin:$PATH"
export PATH=$PATH:/usr/local/go/bin:$HOME/go/bin
source ~/powerlevel10k/powerlevel10k.zsh-theme

mklog-all() {
  if (( $# == 0 )); then
    print -u2 'Usage: mklog-all <app-name> [kubectl logs options]'
    return 2
  fi
  local app_name="$1" pod_count
  shift
  pod_count=$(kubectl -n metrix get pods -l "app=$app_name" -o go-template='{{len .items}}') || return $?
  if (( pod_count == 0 )); then
    print -u2 "No pods found for app=$app_name in namespace metrix."
    return 1
  fi
  setopt localoptions pipefail
  kubectl --context prod -n metrix logs -f --tail=200 -l "app=$app_name" --max-log-requests="$pod_count" --prefix "$@" |
    perl -pe '
      BEGIN {
        $| = 1;
        $green = -t STDOUT ? "\e[38;5;65m" : "";
        $white = -t STDOUT ? "\e[37m" : "";
        $reset = -t STDOUT ? "\e[0m" : "";
      }
      if (s{^\[pod/([^/]+-([^/-]+)/[^]]+)\] ?}{}) {
        my ($source, $suffix) = ($1, $2);
        my ($pod) = split m{/}, $source, 2;
        my $plain = $_;
        $plain =~ s/\e\[[0-9;:]*m//g;
        # Recognize Logback message headers, with optional kubectl timestamps.
        if ($plain =~ /^(?:\d{4}-\d{2}-\d{2}T\S+ )?\d{2}:\d{2}:\d{2}\.\d{3} \| (?:TRACE|DEBUG|INFO|WARN|ERROR) +\| /) {
          my $number = $pod_ids{$pod} //= ++$next_id;
          $_ = $green . $number . $white . " | " .
               $green . $suffix . $white . " |" . $reset . " " . $_;
        }
      }
    '
}


# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
___MY_VMOPTIONS_SHELL_FILE="${HOME}/.jetbrains.vmoptions.sh"; if [ -f "${___MY_VMOPTIONS_SHELL_FILE}" ]; then . "${___MY_VMOPTIONS_SHELL_FILE}"; fi
