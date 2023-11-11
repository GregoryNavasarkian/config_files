# Source global definitions
if [ -f /etc/bashrc ]; then
        . /etc/bashrc
fi

# Enable bash programmable completion features in interactive shells
if [ -f /usr/share/bash-completion/bash_completion ]; then
        . /usr/share/bash-completion/bash_completion
elif [ -f /etc/bash_completion ]; then
        . /etc/bash_completion
fi

#######################################################
# EXPORTS
#######################################################

# Disable the bell
if [[ $iatest -gt 0 ]]; then bind "set bell-style visible"; fi

# To have colors for ls and all grep commands such as grep, egrep and zgrep
export CLICOLOR=1
export LS_COLORS='no=00:fi=00:di=00;34:ln=01;36:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=40;31;01:ex=01;32:*.tar=01;31:*.tgz=01;31:*.arj=01;31:*.taz=01;31:*.lzh=01;31:*.zip=01;31:*.z=01;31:*.Z=01;31:*.gz=01;31:*.bz2=01;31:*.deb=01;31:*.rpm=01;31:*.jar=01;31:*.jpg=01;35:*.jpeg=01;35:*.gif=01;35:*.bmp=01;35:*.pbm=01;35:*.pgm=01;35:*.ppm=01;35:*.tga=01;35:*.xbm=01;35:*.xpm=01;35:*.tif=01;35:*.tiff=01;35:*.png=01;35:*.mov=01;35:*.mpg=01;35:*.mpeg=01;35:*.avi=01;35:*.fli=01;35:*.gl=01;35:*.dl=01;35:*.xcf=01;35:*.xwd=01;35:*.ogg=01;35:*.mp3=01;35:*.wav=01;35:*.xml=00;31:'
#export GREP_OPTIONS='--color=auto' #deprecated
alias grep="/usr/bin/grep $GREP_OPTIONS"
unset GREP_OPTIONS

# Color for manpages in less makes manpages a little easier to read
export LESS_TERMCAP_mb=$'\E[01;31m'
export LESS_TERMCAP_md=$'\E[01;31m'
export LESS_TERMCAP_me=$'\E[0m'
export LESS_TERMCAP_se=$'\E[0m'
export LESS_TERMCAP_so=$'\E[01;44;33m'
export LESS_TERMCAP_ue=$'\E[0m'
export LESS_TERMCAP_us=$'\E[01;32m'

alias ebrc='nvim ~/.bashrc'

alias cp='cp -i'
alias mv='mv -i'
alias rm='rm -rf'
alias cls='clear'
alias vide='neovide'
alias edit='gedit'
alias cd..='cd ..'
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'

# Alias's for multiple directory listing commands
alias la='ls -Alh'               # show hidden files
alias ls='ls -Fh --color=always' # add colors and file type extensions
alias lx='ls -lXBh'              # sort by extension
alias lk='ls -lSrh'              # sort by size
alias lc='ls -lcrh'              # sort by change time
alias lu='ls -lurh'              # sort by access time
alias lr='ls -lRh'               # recursive ls
alias lt='ls -ltrh'              # sort by date
alias lm='ls -alh |more'         # pipe through 'more'
alias lw='ls -xAh'               # wide listing format
alias ll='ls -Fls'               # long listing format
alias labc='ls -lap'             #alphabetical sort
alias ldir="ls -l | egrep '^d'"  # directories only

# alias chmod commands
alias mx='chmod a+x'
alias 000='chmod -R 000'
alias 644='chmod -R 644'
alias 666='chmod -R 666'
alias 755='chmod -R 755'
alias 777='chmod -R 777'

# Copy file with a progress bar
cpp() {
        set -e
        strace -q -ewrite cp -- "${1}" "${2}" 2>&1 |
                awk '{
        count += $NF
        if (count % 10 == 0) {
                percent = count / total_size * 100
                printf "%3d%% [", percent
                for (i=0;i<=percent;i++)
                        printf "="
                        printf ">"
                        for (i=percent;i<100;i++)
                                printf " "
                                printf "]\r"
                        }
                }
        END { print "" }' total_size="$(stat -c '%s' "${1}")" count=0
}

# Copy and go to the directory
cpg() {
        if [ -d "$2" ]; then
                cp "$1" "$2" && cd "$2"
        else
                cp "$1" "$2"
        fi
}

# Move and go to the directory
mvg() {
        if [ -d "$2" ]; then
                mv "$1" "$2" && cd "$2"
        else
                mv "$1" "$2"
        fi
}

# Create and go to the directory
mcd() {
        mkdir "$1"
        cd "$1"
}

commit() {
        git add .
        git commit -m "$1"
}

alias nixconf='sudo nvim /etc/nixos/configuration.nix'
alias nixupdate='nix-channel --update'
alias nixupgrade='sudo nixos-rebuild switch --upgrade'
alias nixrebuild='sudo nixos-rebuild switch'

eval "$(starship init bash)"
