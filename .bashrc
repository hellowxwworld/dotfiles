# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# don't put duplicate lines in the history. See bash(1) for more options
# ... or force ignoredups and ignorespace
HISTCONTROL=ignoredups:ignorespace

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000000
HISTFILESIZE=2000000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "$debian_chroot" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

alias cl="clear"

alias wine='env LANG=en_US wine'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
    . /etc/bash_completion
fi
#export PATH=${PATH}:/home/xiaowu/maxwit/toolchain/usr/bin

setterm -regtabs 4

alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

# screen # {{{
alias email='screen -t email mutt'
alias irc='screen -t irc irssi'
alias news='screen -t news newsbeuter'
alias music='screen -t music ncmpc'
alias log='screen -t log sudo cat /var/log/everything.log | tail'
# }}}

# colorize the man-pages#{{{
export LESS_TERMCAP_mb=$'\E[01;31m'
export LESS_TERMCAP_md=$'\E[01;31m'
export LESS_TERMCAP_me=$'\E[0m'
export LESS_TERMCAP_se=$'\E[0m'
export LESS_TERMCAP_so=$'\E[01;44;33m'
export LESS_TERMCAP_ue=$'\E[0m'
export LESS_TERMCAP_us=$'\E[01;32m'
#}}}

#export PATH=${PATH}:/maxwit/toolchain/arm/usr/bin
#export PATH=${PATH}:/usr/local/arm/4.2.2-eabi/usr/bin
#export PATH=${PATH}:/work/cross_compile/arm-2010q1/bin
export PATH=${PATH}:/opt/android-sdk-linux/tools
export PATH=${PATH}:/opt/android-sdk-linux/platforms-tools

export JAVA_HOME=/opt/jdk1.6.0_32
export JRE_HOME=/opt/jdk1.6.0_32/jre
export CLASSPATH=$CLASSPATH:$JAVA_HOME/lib:$JAVA_HOME/jre/lib
export PATH=$JAVA_HOME/bin:$JAVA_HOME/jre/bin:$PATH:$HOME/bin

UBOOT_CROSS_COMPILE=/usr/local/arm/arm-2010q1/bin
#UBOOT_CROSS_COMPILE=/usr/local/arm/gcc-linaro-arm-linux-gnueabihf-2012.05-20120523_linux/bin
#export PATH=$UBOOT_CROSS_COMPILE:$PATH
#UBOOT_CROSS_COMPILE=/meizu/JellyBean/trunk/prebuilt/linux-x86/toolchain/arm-eabi-4.4.3/bin
#export PATH=$UBOOT_CROSS_COMPILE:$PATH
#UBOOT_CROSS_COMPILE=/meizu/JellyBean/trunk/prebuilts/gcc/linux-x86/host/x86_64-linux-glibc2.7-4.6/bin
export PATH=$UBOOT_CROSS_COMPILE:$PATH

export SVN_EDITOR=/usr/bin/vim

##################################################
# new bash cmd
##################################################
# some more ls aliases
alias ll='ls -alF --color=auto'
alias la='ls -A --color=auto'
alias l='ls -CF --color=auto'
alias gvim='UBUNTU_MENOPROXY= gvim'
alias g='UBUNTU_MENOPROXY= gvim'
alias ggit='gvim ~/tmp/gitcommit.log'
alias gvimdiff='gvimdiff -c "call MaximizeWindow()"'
#alias gvim='gvim -c "call MaximizeWindow()"'

function ..5() { cd ../../../.. ; }
function ..4() { cd ../../../.. ; }
function ..3() { cd ../../.. ; }
function ..2() { cd ../.. ; }
function ..() { cd .. ; }
function m9w() {
	cd /work/m9w/linux-3.0.8-m9;
	pwd;
}
function m30() {
	cd /work/m30;
	pwd;
}
function m32() {
	cd /work/m32;
	pwd;
}
function m31() {
	cd /work/m31
	pwd;
}
function m40() {
	cd /work/m40
	pwd;
}
function ics() {
	cd /meizu/IceCreamSandwich/trunk
	pwd;

}
function icsout() {
	cd /meizu/IceCreamSandwich/trunk/out/target/product/
	pwd;

}
function jl() {
	cd /meizu/JellyBean/trunk
	pwd;

}
function jlout() {
	cd /meizu/JellyBean/trunk/out/target/product/
	pwd;

}
function gin() {
	cd /meizu/gin/trunk;
	pwd;
}
function ginout() {
	cd /meizu/gin/trunk/out/target/product;
	pwd;
}
function kfb() {
	cd /opt/99/kfb/
	pwd;
}
function kfbggwjj() {
	cd /opt/99/kfbggwjj/
	pwd;
}
function z() {
	sudo dnw arch/arm/boot/zImage;
	pwd;
}
function re() {
	sudo dnw recovery-uboot.img;
	pwd;
}
function ram() {
	sudo dnw ramdisk-uboot.img;
	pwd;
}
function s() {
	sudo dnw system.img;
	pwd;
}

function slog() {
	svn log | less;
}
function sdiff() {
	svn diff | less;
}

function mz() {
	export PATH=/usr/local/arm/arm-2010q1/bin:$PATH
	make zImage -j9 CROSS_COMPILE=arm-linux-
}

# for fcitx
export XMODIFIERS="@im=fcitx"
export GTK_IM_MODULE=xim
export QT_IM_MODULE=xim

#export PS1="\e[1;32m\[\e[40m${debian_chroot:+($debian_chroot)}\u@$(tput setaf 5)w: $(tput setaf 4)\w\a$\] \e[m"

source /home/w/.rvm/scripts/rvm
PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting
