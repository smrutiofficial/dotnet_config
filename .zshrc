
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

export ZSH="$HOME/.oh-my-zsh"


ZSH_THEME="powerlevel10k/powerlevel10k"
plugins=(git zsh-syntax-highlighting zsh-autosuggestions)


source $ZSH/oh-my-zsh.sh

[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
# Set up fzf key bindings and fuzzy completion
source <(fzf --zsh)
#alias code="flatpak run com.visualstudio.code"


alias tms='session=$(tmux ls | fzf | awk -F: '\''{print $1}'\''); tmux attach -t "$session"'
alias ll="ls -a"
alias mk="mkdir"
alias sinstall="sudo apt install"
alias sremove="sudo apt remove"
alias alupdate="sudo apt update && sudo apt upgrade"

alias convert="bash ~/dev/bashscript/file_conversion/convert.sh"
alias org="bash ~/dev/bashscript/file_organizer/org.sh"
alias gitpush="bash ~/gitpush.sh"
alias gitset="bash ~/dev/bashscript/git_setup/gitset.sh"
alias alclean="sudo apt autoclean && sudo apt autoremove"
alias cl="clear"
# flatpak
alias flapp="flatpak list --app --columns=name,application"
alias flrm="flatpak remove"
alias flcl="flatpak uninstall --unused"

alias startemu="cd Android/Sdk/emulator && ./emulator -avd Pixel_3a_API_33_x86_64"
export ANDROID_STUDIO_DIR=/var/lib/flatpak/app/com.google.AndroidStudio/current/active/files
export JAVA_HOME=/usr/lib/jvm/java-17-openjdk-amd64
export PATH=$PATH:$ANDROID_STUDIO_DIR/bin
export PATH=$PATH:$ANDROID_SDK_ROOT/tools
export PATH=$PATH:$ANDROID_SDK_ROOT/tools/bin
export PATH=$PATH:$ANDROID_SDK_ROOT/platform-tools
export PATH=$PATH:$JAVA_HOME/bins

export PATH="$PATH:/home/smruti/flutter-dev/flutter/bin"
tmux source-file ~/.tmux.conf
#tmux new-session -s smruti tmux at -t smruti
# Set GTK theme
export GTK_THEME=Everforest-Dark-BL-MOD

clear

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
