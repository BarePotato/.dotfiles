#//----------[ Title ]
function fish_title
	echo $_ ' '
	pwd
end

#//----------[ Greeting ]
function fish_greeting
	printf  '\e[90m%s\n%s\n%s\n%s\n' "                 |               !!!           |\"|      " "     ,,,         |.===.       \  _ _  /       _|_|_     " "    (o o)        {}o o{}     -  (OXO)  -      (o o)     " "ooO--(_)--Ooo-ooO--(_)--Ooo-ooO--(_)--Ooo-ooO--(_)--Ooo-"
end

#//----------[ Alias ]
# list aliases for Exa
alias l="exa -Fx --group-directories-first"
alias lh="exa -Fax --group-directories-first"
alias ll="exa -lF --group-directories-first"
alias la="exa -lFa --group-directories-first"
# exit
alias x="exit"
# clear screen
alias cls="clear"
# poweroff
alias die="poweroff"
# git dotfiles
alias config="/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME"

#//----------[ PATH ]
set -gx PATH ~/.cargo/bin $PATH

#//----------[ STARSHIP ]
starship init fish | source

#//----------[ STARTX ]
#if status is-login
#if test -z "$DISPLAY" -a "$XDG_VTNR" = 1
#startx -- -keeptty
#end
#end

