# System-wide .bashrc file for interactive bash(1) shells.

# To enable the settings / commands in this file for login shells as well,
# this file has to be sourced in /etc/profile.

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "$debian_chroot" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, overwrite the one in /etc/profile)
PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '

# Commented out, don't overwrite xterm -T "title" -n "icontitle" by default.
# If this is an xterm set the title to user@host:dir
#case "$TERM" in
#xterm*|rxvt*)
#    PROMPT_COMMAND='echo -ne "\033]0;${USER}@${HOSTNAME}: ${PWD}\007"'
#    ;;
#*)
#    ;;
#esac

# enable bash completion in interactive shells
#if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
#    . /etc/bash_completion
#fi

# sudo hint
if [ ! -e "$HOME/.sudo_as_admin_successful" ]; then
    case " $(groups) " in *\ admin\ *)
    if [ -x /usr/bin/sudo ]; then
	cat <<-EOF
	To run a command as administrator (user "root"), use "sudo <command>".
	See "man sudo_root" for details.

	EOF
    fi
    esac
fi

# if the command-not-found package is installed, use it
if [ -x /usr/lib/command-not-found -o -x /usr/share/command-not-found ]; then
	function command_not_found_handle {
	        # check because c-n-f could've been removed in the meantime
                if [ -x /usr/lib/command-not-found ]; then
		   /usr/bin/python /usr/lib/command-not-found -- $1
                   return $?
                elif [ -x /usr/share/command-not-found ]; then
		   /usr/bin/python /usr/share/command-not-found -- $1
                   return $?
		else
		   return 127
		fi
	}
fi

# some more ls aliases
alias ll='ls -alF --color=auto'
alias la='ls -A --color=auto'
alias l='ls -CF --color=auto'
alias gvim='UBUNTU_MENOPROXY= gvim'
alias g='UBUNTU_MENOPROXY= gvim'
alias ggit='UBUNTU_MENOPROXY gvim ~/tmp/gitcommit.log'
alias gvimdiff='gvimdiff -c "call MaximizeWindow()"'
alias rm='rm -i'
alias mv='mv -i'

export JAVA_HOME=/opt/jdk1.6.0_32
export JRE_HOME=/opt/jdk1.6.0_32/jre
export CLASSPATH=$CLASSPATH:$JAVA_HOME/lib:$JAVA_HOME/jre/lib:/home/w/.vim/autoload/
export PATH=$JAVA_HOME/bin:$JAVA_HOME/jre/bin:$PATH:$HOME/bin

export PATH=${PATH}:/opt/android-studio/bin
export PATH=${PATH}:/opt/android-sdk-linux/tools
export PATH=${PATH}:/opt/android-sdk-linux/platform-tools
export PATH=${PATH}:/meizu/JellyBean-4.2.1/trunk/prebuilts/gcc/linux-x86/arm/arm-eabi-4.6/bin
export SVN_EDITOR=/usr/bin/vim

export PATH=${PATH}:/opt/adt-bundle-linux-x86_64-20130729/eclipse

#call Maximize_Window() to maximize gvim window when started
#Set the screen title
case $TERM in
    screen*)
        # This is the escape sequence ESC k \w ESC \
        # Use path as title
        PATHTITLE='\[\ek\W\]\[\e\\\]'
        # Use program name as title
        PROGRAMTITLE='\[\ek\]\[\e\\\]'
        PS1="${PROGRAMTITLE}${PATHTITLE}${PS1}"
        ;;
    *)
        ;;
esac
