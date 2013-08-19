#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

#add bin folder to path
PATH=~/bin:$PATH

#some aliasses --from ArchWiki
alias diff='colordiff'              # requires colordiff package
alias grep='grep --color=auto'
alias more='less'
alias df='df -h'
alias du='du -c -h'
alias mkdir='mkdir -p -v'
alias nano='nano -w'
alias ..='cd ..'

# ls
alias ls='ls -hF --color=auto'
alias lr='ls -R'                    # recursive ls
alias ll='ls -l'
alias la='ll -A'
alias lx='ll -BX'                   # sort by extension
alias lz='ll -rS'                   # sort by size
alias lt='ll -rt'                   # sort by date
alias lm='la | more'

# IPython like history access
bind '"\e[A": history-search-backward'
bind '"\e[B": history-search-forward'

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize


source /usr/share/doc/pkgfile/command-not-found.bash
source ~/.scripts/git-prompt.sh

################
# PS1 
# * wrapped in a function to hide vars in sessions.
# (you@host) [workingdir GITINFO] $
#
# PS1='[\u@\h \W]\$ '  #default Arch
#

bash_prompt() {
    BLUE="\[\033[0;34m\]"
    CYAN="\[\e[36m\]"
    GREY="\[\e[1;30m\]"
    YELLOW="\[\033[0;33m\]" 
    END="\[\e[0m\]"

    #Git related commands for PS1
    GIT_PS1_SHOWDIRTYSTATE=1
    GIT='$(__git_ps1 " '$YELLOW'@'$END'%s")'
    PS1="$GREY($END\u@\H$GREY)$END $GREY[$END\W"$GIT"$GREY]$END $CYAN\$$END "
    #PS1="bla $(__git_ps1 "(%s)") $CYAN\$$END "
}
bash_prompt
unset bash_prompt
