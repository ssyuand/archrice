if [[ -z $DISPLAY ]] || [[ $(tty) = /dev/tty2 ]];then
	startx
fi
parse_git_branch() {
     git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}
set -o vi
bind -m vi-insert 'Control-l: clear-screen'
bind -m vi-insert 'Control-a: beginning-of-line'
bind -m vi-insert 'Control-e: end-of-line'
bind -m vi-insert 'Control-w: backward-kill-word'
export EDITOR=nvim
export LANG=en_US.UTF-8
export TERM=xterm-256color
export JAVA_HOME='/usr/lib/jvm/java-17-openjdk/'
export PATH=$JAVA_HOME/bin:$JAVA_HOME/jre/bin:$PATH:$HOME/bin
shopt -s autocd
alias ..='cd ..'
alias gs="git status"
alias rm='trash-put'
alias ducks='du -cks * | sort -n -r | head -n 10'
alias l='ls -A -CF --color=auto'
alias ls='ls -A -CF --color=auto'
alias ll='ls -lh --color=auto'
alias vi='nvim'
PS1="\[\e[0;31m\]\u@\[\e[m\e[0;34m\]\h\[\e[m \e[0;32m\]\W\$(parse_git_branch) \$ \[\e[m\]"
