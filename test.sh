#!/bin/bash

HOME_ROCKY="/home/rocky"

# set log file location
LOGFILE="/var/log/setup-terraform.log"

# redirect stdout & stderr to logfile
exec >"$LOGFILE" 2>&1

# install vim
echo "Installing vim"
dnf install vim -y

# set vim config file
echo "setting vim config"
cat <<'EOF' >$HOME_ROCKY/.vimrc
:colorscheme elflord
filetype plugin indent on
" show existing tab with 4 spaces width

set tabstop=4

" when indenting with '>', use 4 spaces width
set shiftwidth=4
" On pressing tab, insert 4 spaces
set expandtab
set ignorecase      " Do case insensitive matching
set smartcase       " Do smart case matching
set incsearch       " Incremental search
set smartindent
set autoindent
set backspace=indent,eol,start
set shiftround
set pastetoggle=<F2>
EOF

# set bash config file
echo "setting bash config"
cat <<'EOF' >$HOME_ROCKY/.bashrc
alias cdl='cd /var/log/'
alias cp='cp -i'
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'
alias grep='grep --color=auto'
alias hg='history | grep '
alias l.='ls -d .* --color=auto'

alias ll='ls -l --color=auto'

alias ls='ls --color=auto'
alias lt='ll -th'
alias mv='mv -i'
alias rech='grep -rwn ./ -e '
alias rm='rm -i'
alias tf='tail -f -n 50 '
alias xzegrep='xzegrep --color=auto'
alias xzfgrep='xzfgrep --color=auto'
alias xzgrep='xzgrep --color=auto'
alias zegrep='zegrep --color=auto'
alias zfgrep='zfgrep --color=auto'

alias zgrep='zgrep --color=auto'
EOF

# set timezone to France
TIMEZONE="Europe/Paris"
echo "setting timezone to ${TIMEZONE}"
timedatectl set-timezone "${TIMEZONE}"

# creating cron job
echo "creating cronjob"
CRONJOB='0 */4 * * * sleep $((RANDOM % 300)); dnf -y update >/dev/null 2>&1; dnf clean all >/dev/null 2>&1'

crontab - <<EOF
MAILTO=""

$CRONJOB
EOF

# set hostname
HOSTNAME="osv-asc-o2int"
echo "setting hostname to ${HOSTNAME}"
hostnamectl set-hostname osv-asc-o2int
echo "127.0.0.1 osv-asc-o2int" >>/etc/hosts

# installing Java
echo "installing Java"
dnf install java-21-openjdk -y

# installing nginx
echo "installing nginx"
dnf install nginx -y
