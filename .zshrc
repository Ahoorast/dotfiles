# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
# just in case setxkbmap -layout "us,ir" -option "grp:alt_shift_toggle" 
# make displays the same thing
# xrandr --output HDMI-1 --same-as eDP-1    

if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
#ZSH_THEME="robbyrussell"
ZSH_THEME="powerlevel10k/powerlevel10k"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment one of the following lines to change the auto-update behavior
# zstyle ':omz:update' mode disabled  # disable automatic updates
# zstyle ':omz:update' mode auto      # update automatically without asking
# zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# Uncomment the following line to change how often to auto-update (in days).
# zstyle ':omz:update' frequency 13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# You can also set it to another string to have that shown instead of the default red dots.
# e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
# COMPLETION_WAITING_DOTS="true"

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

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
# plugins=(git zsh-autosuggestions zsh-syntax-highlighting fast-syntax-highlighting zsh-autocomplete)
plugins=(git zsh-autosuggestions zsh-syntax-highlighting fast-syntax-highlighting )

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# whatever the fuck
if [ "$0" = "/usr/sbin/lightdm-session" -a "$DESKTOP_SESSION" = "i3" ]; then
      export $(gnome-keyring-daemon -s)
fi
# my aliases
alias ovpn="sudo openvpn --config /home/ahoora/.ialiastheseappimageorclistothingstotypeinterminal/pf-primary-TCP4-11977-config.ovpn --auth-nocache"


alias FUCK="/usr/libexec/xdg-desktop-portal -r"

# copy
alias copy="xclip -selection clipboard"

# apps
alias cf="/home/ahoora/.ialiastheseappimageorclistothingstotypeinterminal/cf_v1.0.0_linux_64/cf"
alias nv="/home/ahoora/.ialiastheseappimageorclistothingstotypeinterminal/nvim-linux-x86_64/bin/nvim"
alias nekoray="/home/ahoora/.ialiastheseappimageorclistothingstotypeinterminal/nekoray-3.24-2023-10-28-linux64/nekoray/launcher"
alias discord="/home/ahoora/.ialiastheseappimageorclistothingstotypeinterminal/Discord/Discord"
alias obsidian="/home/ahoora/.ialiastheseappimageorclistothingstotypeinterminal/Obsidian/Obsidian-1.6.5.AppImage"
alias tvmode="xset -dpms; xset s off;"
alias jel="/home/ahoora/.ialiastheseappimageorclistothingstotypeinterminal/ideaIU-2024.3.1.1/idea-IU-243.22562.218/bin/idea"
alias jmeter="/home/ahoora/Downloads/apache-jmeter-5.6.3/bin/jmeter"
alias docker="sudo docker"
alias lazydocker="sudo /home/linuxbrew/.linuxbrew/bin/lazydocker"
alias languages="setxkbmap -layout \"us,ir\" -option \"grp:alt_shift_toggle"
#
export PATH="$PATH:/opt/nvim-linux-x86_64/bin"

#
#
# tmux aliases
alias tms="tmux new -s"
alias tmps="source ~/.scripts/initTmuxPath.sh"
alias tma="source ~/.scripts/tmuxer.sh"
alias wifishare="bash ~/.scripts/wifishare/run.sh"
alias sesh="source ~/.scripts/sesh.sh"

#navigation
alias gof="source ~/.scripts/navigation.sh"
# alias the command cd $(find . -type d -print | fzf) to gof

# bun completions
[ -s "/home/ahoora/.bun/_bun" ] && source "/home/ahoora/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

# gopath goroot go
export GOROOT=/usr/lib/golang
export GOPATH=$HOME/go
export PATH=$PATH:$GOROOT/bin
export PATH=$PATH:/opt/gradle/gradle-8.10/bin


export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion


export PATH=$PATH:~/.cargo/bin/
# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
unsetopt autocd
bindkey -v
# End of lines configured by zsh-newuser-install

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"
___MY_VMOPTIONS_SHELL_FILE="${HOME}/.jetbrains.vmoptions.sh"; if [ -f "${___MY_VMOPTIONS_SHELL_FILE}" ]; then . "${___MY_VMOPTIONS_SHELL_FILE}"; fi

[[ -s "/home/ahoora/.gvm/scripts/gvm" ]] && source "/home/ahoora/.gvm/scripts/gvm"

eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
alias x="echo hi"
