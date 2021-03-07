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
alias ll="exa -lF --no-user --group-directories-first"
alias la="exa -lFa --no-user --group-directories-first"
# exit
alias x="exit"
# clear screen
alias cls="clear"
# poweroff
alias die="poweroff"
# git dotfiles
alias doot="/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME"
# twitchy
function twitchy
	cd ~/code/bin/twitchy
	./twitchy
end
alias todo="nvim ~/code/bin/twitchy/twitchy.todo"
# nvim
alias nmain="nvim src/main.rs"
alias nall="nvim src/*"

#//----------[ FZF ]
begin
	set --local FZF_PATH /usr/share/fish/vendor_functions.d/fzf_key_bindings.fish
	if test -e $FZF_PATH
		set -x FZF_DEFAULT_COMMAND 'rg --files --hidden --follow --glob "!.git/*"'
		fzf_key_bindings
	end
end

#//----------[ AUTOJUMP-RS ]
source /usr/share/autojump/autojump.fish

#//----------[ GETTING JIGGY WITH OUR TERMINALS ]
function prompt --on-event fish_prompt
	echo $PWD > ~/.local/tmp/whereami
end
function pwd_i3-sensible-terminal
	i3-sensible-terminal --working-directory (cat ~/.local/tmp/whereami) &
end

#//----------[ PATH ]
set -x PATH ~/.cargo/bin ~/.local/bin $PATH ~/.zls/x86_64-linux

#//----------[ STARSHIP ]
starship init fish | source

#//----------[ STARTX ]
#if status is-login
#if test -z "$DISPLAY" -a "$XDG_VTNR" = 1
#startx -- -keeptty
#end
#end

