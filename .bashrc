# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
# force_color_prompt=yes

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
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u\[\033[00m\]:\[\033[01;34m\]\W\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\W\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \W\a\]$PS1"
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

# colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

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
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

# my other customisation goes here

ll=$(last -1 -R | head -1 | cut -c 20-)
NC='\033[0m' # No Color
RED='\033[0;31m'
LIGHTPURPLE='\033[1;35m'
LIGHTBLUE='\033[1;34m'
LIGHTPURPLE='\033[1;35m'
LIGHTCYAN='\033[1;96m'
WHITE='\033[1;97m'
CYAN='\033[0;36m'
PURPLE='\033[0;35m'
BROWNORANGE='\033[0;33m'
GREEN='\033[0;92m'
PURPLE='\033[0;35m'


export NVM_DIR="/home/hitman/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm


PROMPT_COMMAND='echo -en "\033]0;$(basename $(pwd))\a"'


# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# don't put duplicate lines in the history.
# ... or force ignoredups and ignorespace
HISTCONTROL=ignoredups:ignorespace

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

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

	color_prompt=yes
    else
	color_prompt=
    fi
fi

git_branch() {
    git branch --no-color 2>/dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1/'
}

git_status() {
    # Outputs a series of indicators based on the status of the
    # working directory:
    # + changes are staged and ready to commit
    # ! unstaged changes are present
    # ? untracked files are present
    # S changes have been stashed
    # P local commits need to be pushed to the remote
    local status="$(git status --porcelain 2>/dev/null)"
    local output=''
    [[ -n $(egrep '^[MADRC]' <<<"$status") ]] && output="$output+"
    [[ -n $(egrep '^.[MD]' <<<"$status") ]] && output="$output!"
    [[ -n $(egrep '^\?\?' <<<"$status") ]] && output="$output?"
    [[ -n $(git stash list) ]] && output="${output}S"
    [[ -n $(git log --branches --not --remotes) ]] && output="${output}P"
    [[ -n $output ]] && output="|$output"  # separate from branch name
    echo $output
}

git_color() {
    local staged=$([[ $1 =~ \+ ]] && echo yes)
    local dirty=$([[ $1 =~ [!\?] ]] && echo yes)
    local needs_push=$([[ $1 =~ P ]] && echo yes)
    if [[ -n $staged ]] && [[ -n $dirty ]]; then
        echo -e '\033[1;33m'  # bold yellow
    elif [[ -n $staged ]]; then
        echo -e '\033[1;32m'  # bold green
    elif [[ -n $dirty ]]; then
        echo -e '\033[1;31m'  # bold red
    elif [[ -n $needs_push ]]; then
        echo -e '\033[1;34m' # bold blue
    else
        echo -e '\033[1;37m'  # bold white
    fi
}

git_prompt() {
    # First, get the branch name...
    local branch=$(git_branch)
    # Empty output? Then we're not in a Git repository, so bypass the rest
    # of the function, producing no output
    if [[ -n $branch ]]; then
        local state=$(git_status)
        local color=$(git_color $state)
        # Now output the actual code to insert the branch and status
        echo -e "\x01$color\x02 ($branch$state)\x01\033[00m\x02"  # last bit resets color
    fi
}

if [ "$color_prompt" = yes ]; then
    PS1="\[\033[0;31m\]\342\224\214\342\224\200\$([[ \$? != 0 ]] && echo \"[\[\033[0;31m\]\342\234\227\[\033[0;37m\]]\342\224\200\")[$(if [[ ${EUID} == 0 ]]; then echo '\[\033[01;31m\]root\[\033[01;33m\]@\[\033[01;96m\]\h'; else echo '\[\033[0;39m\]\u\[\033[01;33m\]@\[\033[01;96m\]\h'; fi)\[\033[0;31m\]]\342\224\200[\[\033[0;32m\]\w\[\033[0;31m\]]\$(git_prompt)\n\[\033[0;31m\]\342\224\224\342\224\200\342\224\200\342\225\274 \[\033[0m\]\[\e[01;33m\]\\$\[\e[0m\]"
    #PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1="\[\033[0;31m\]\342\224\214\342\224\200\$([[ \$? != 0 ]] && echo \"[\[\033[0;31m\]\342\234\227\[\033[0;37m\]]\342\224\200\")[$(if [[ ${EUID} == 0 ]]; then echo '\[\033[01;31m\]root\[\033[01;33m\]@\[\033[01;96m\]\h'; else echo '\[\033[0;39m\]\u\[\033[01;33m\]@\[\033[01;96m\]\h'; fi)\[\033[0;31m\]]\342\224\200[\[\033[0;32m\]\w\[\033[0;31m\]]\$(git_prompt)\n\[\033[0;31m\]\342\224\224\342\224\200\342\224\200\342\225\274 \[\033[0m\]\[\e[01;33m\]\\$\[\e[0m\]"
    #PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\033[0;31m\]\342\224\214\342\224\200\$([[ \$? != 0 ]] && echo \"[\[\033[0;31m\]\342\234\227\[\033[0;37m\]]\342\224\200\")[$(if [[ ${EUID} == 0 ]]; then echo '\[\033[01;31m\]root\[\033[01;33m\]@\[\033[01;96m\]\h'; else echo '\[\033[0;39m\]\u\[\033[01;33m\]@\[\033[01;96m\]\h'; fi)\[\033[0;31m\]]\342\224\200[\[\033[0;32m\]\w\[\033[0;31m\]]\$(git_prompt)\n\[\033[0;31m\]\342\224\224\342\224\200\342\224\200\342\225\274 \[\033[0m\]\[\e[01;33m\]\\$\[\e[0m\]"
    #PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
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


display=( z y a b c d e f g h i j k l m n )

c0="\033[0m" # Reset Text
bold="\033[1m" # Bold Text
underline="\033[4m" # Underline Text

colorize () {
  printf "\033[38;5;$1m"
}

getColor() {
  tmp_color=${1,,}

  case "${tmp_color}" in
    'light grey')   color_ret='\033[0m\033[37m';;
    'light green')  color_ret='\033[0m\033[1;32m';;
    'light red')	color_ret='\033[0m\033[1;31m';;
    'orange')       color_ret="$(colorize '202')";;
    'yellow')       color_ret='\033[0m\033[1;33m';;
    'cyan')         color_ret='\033[0;36m';;
  esac
  echo "${color_ret}"
}

asciiText () {
    c1=$(getColor 'orange')
    c2=$(getColor 'light red')
    c3=$(getColor 'yellow')
    c4=$(getColor 'cyan')
    startline="0"
	fulloutput=("$c2                          ./+o+-       %s"
"$c1                  yyyyy- $c2-yyyyyy+     %s"
"$c1               $c1://+//////$c2-yyyyyyo     %s"
"$c3           .++ $c1.:/++++++/-$c2.+sss/\`     %s"
"$c3         .:++o:  $c1/++++++++/:--:/-     %s"
"$c3        o:+o+:++.$c1\`..\`\`\`.-/oo+++++/    %s"
"$c3       .:+o:+o/.$c4          $c1\`+sssoo+/   %s"
"$c1  .++/+:$c3+oo+o:\`$c4  .-. .-.   $c1 /sssooo.  %s"
"$c1 /+++//+:$c3\`oo+o$c4   |  \`| |     $c2/::--:.  %s"
"$c1 \+/+o+++$c3\`o++o$c4   | |\  |     $c2++////.  %s"
"$c1  .++.o+$c3++oo+:\`$c4  \`-\' \`-\'    $c2/dddhhh.  %s"
"$c3       .+.o+oo:.$c4          $c2\`oddhhhh+   %s"
"$c3        \+.++o+o\`\`-\`\`$c2\`\`.:ohdhhhhh+    %s"
"$c3         \`:o+++ $c2\`ohhhhhhhhyo++os:     %s"
"$c3           .o:$c2\`.syhhhhhhh/$c3.oo++o\`     %s"
"$c2               /osyyyyyyo$c3++ooo+++/    %s"
"$c2                   \`\`\`\`\` $c3+oo+++o\:    %s"
"$c3                          \`oo++.      %s")


    for ((i=0; i<${#fulloutput[*]}; i++)); do
        printf "${fulloutput[i]}$c0\n" "${out_array}"
        if [[ "$i" -ge "$startline" ]]; then
            unset out_array[0]
            out_array=( "${out_array[@]}" )
        fi
    done

}

infoDisplay () {
    display_index=0
    labelcolor=$(getColor 'light green')
	textcolor=$(getColor 'light grey')
    if [[ "${display[@]}" =~ "z" ]]; then
        z=$(echo -e "${labelcolor} ");
        out_array=( "${out_array[@]}" "$z" );
        ((display_index++));
    fi
    if [[ "${display[@]}" =~ "y" ]]; then
        y=$(echo -e "${labelcolor} ");
        out_array=( "${out_array[@]}" "$y" );
        ((display_index++));
    fi
    if [[ "${display[@]}" =~ "a" ]]; then
        a=$(echo -e "${labelcolor} | |        | | | | ");
        out_array=( "${out_array[@]}" "$a" );
        ((display_index++));
    fi
    if [[ "${display[@]}" =~ "b" ]]; then
        b=$(echo -e "$labelcolor | |__   ___| |_| |_ ___ _ __ ");
        out_array=( "${out_array[@]}" "$b" )
        ((display_index++))
    fi
    if [[ "${display[@]}" =~ "c" ]]; then
        c=$(echo -e "$labelcolor | '_ \ / _ | __| __/ _ | '__|");
        out_array=( "${out_array[@]}" "$c" );
        ((display_index++));
    fi
    if [[ "${display[@]}" =~ "d" ]]; then
        d=$(echo -e "$labelcolor | |_) |  __| |_| ||  __| | ");
        out_array=( "${out_array[@]}" "$d" )
        ((display_index++))
    fi
    if [[ "${display[@]}" =~ "e" ]]; then
        e=$(echo -e "$labelcolor |_.__/ \___|\__|\__\___|_| ");
        out_array=( "${out_array[@]}" "$e" )
        ((display_index++))
    fi
    if [[ "${display[@]}" =~ "f" ]]; then
        f=$(echo -e "$labelcolor | |               | |");
        out_array=( "${out_array[@]}" "$f" );
        ((display_index++));
    fi
    if [[ "${display[@]}" =~ "g" ]]; then
        g=$(echo -e "$labelcolor | |__  _   _ _ __ | | __ ");
        out_array=( "${out_array[@]}" "$g" );
        ((display_index++));
    fi
    if [[ "${display[@]}" =~ "h" ]]; then
        h=$(echo -e "$labelcolor | '_ \| | | | '_ \| |/ /  ");
        out_array=( "${out_array[@]}" "$h" );
        ((display_index++));
    fi
    if [[ "${display[@]}" =~ "i" ]]; then
        i=$(echo -e "$labelcolor | |_) | |_| | | | |   < ");
        out_array=( "${out_array[@]}" "$i" );
        ((display_index++));
    fi
    if [[ "${display[@]}" =~ "j" ]]; then
        j=$(echo -e "$labelcolor |_.__/ \__,_|_| |_|_|\_\ ");
        out_array=( "${out_array[@]}" "$j" );
        ((display_index++));
    fi
    if [[ "${display[@]}" =~ "k" ]]; then
        k=$(echo -e "$labelcolor   ___| | __ _ ___ ___     ");
        out_array=( "${out_array[@]}" "$k" );
        ((display_index++));
    fi
    if [[ "${display[@]}" =~ "l" ]]; then
        l=$(echo -e "$labelcolor  / __| |/ _`` / __/ __| ");
        out_array=( "${out_array[@]}" "$l" );
        ((display_index++));
    fi
    if [[ "${display[@]}" =~ "m" ]]; then
        m=$(echo -e "$labelcolor | (__| | (_| \__ \__ \   ");
        out_array=( "${out_array[@]}" "$m" );
        ((display_index++));
    fi
    if [[ "${display[@]}" =~ "n" ]]; then
        n=$(echo -e "$labelcolor  \___|_|\__,_|___|___/ ");
        out_array=( "${out_array[@]}" "$n" );
        ((display_index++));
    fi
    

    asciiText
}

for i in "${display[@]}"; do
    detect${i} 2>/dev/null
done

echo
infoDisplay
echo
