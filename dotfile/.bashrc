if [[ -z $DISPLAY ]] || [[ $(tty) = /dev/tty2 ]];then
	startx
fi
[[ -n "$TMUX" ]] && PROMPT_COMMAND='echo -n -e "\e]2;${PWD/${HOME}/~}\e\\"'
set -o vi
bind -m vi-insert 'Control-l: clear-screen'
bind -m vi-insert 'Control-a: beginning-of-line'
bind -m vi-insert 'Control-e: end-of-line'
bind -m vi-insert 'Control-w: backward-kill-word'
export PATH=/usr/local/bin:$PATH
export EDITOR=nvim
export LANG=en_US.UTF-8
#export TERM=xterm-256color
export JAVA_HOME='/usr/lib/jvm/java-17-openjdk/'
export PATH=$JAVA_HOME/bin:$JAVA_HOME/jre/bin:$PATH:$HOME/bin
shopt -s autocd
alias ..='cd ..'
alias gs="git status"
alias rm='trash-put'
alias duck='du -cks * | sort -n -r | head -n 20'
alias duak='du -ak | sort -n -r | head -n 20'
alias l='ls -A -S -CF --color=auto'
alias ll='ls -A -n -LSh --color=always'
alias ls='ls -A -n -ltr --color=always'
alias vi='nvim'
PS1="\[\e[0;31m\]\u@\[\e[m\e[0;34m\]\h\[\e[m \e[0;32m\]\W \$ \[\e[m\]"
