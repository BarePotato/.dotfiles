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
alias las="la --sort date"
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
function twitchyf
	cd ~/code/bin/twitchy
	./twitchy_front
end
alias todo="nvim ~/code/bin/twitchy/twitchy.todo"
# nvim
alias nm="nvim src/main.rs"
alias nr="nvim src/**/*.rs"
alias n="nvim"
# bat
alias cat bat
# procs
alias ps procs
# dust
alias du dust
# fend
alias calc fend
# config webcam defaults
alias c920 "v4l2-ctl -d /dev/video-c920 -c white_balance_temperature_auto=0 -c gain=128 -c white_balance_temperature=4225 -c sharpness=165 -c exposure_auto=1 -c exposure_absolute=200 -c focus_auto=0 -c exposure_auto_priority=0 -c saturation=200"
# web stuff
alias web "firefox & disown"
alias email "thunderbird & disown"
alias tor "qbittorrent & disown"

# //----------[ feh ]
alias wall "do_feh -r --randomize --bg-scale ~/Downloads/wallpapers/"
alias show "do_feh --randomize -z -D 4"
function do_feh
	feh -.Z -B "#080808" $argv & disown
end

# //----------[ VLC Media Library Stuff ]
function tv
	switch (string lower $argv)
		case "g" or "get"
			cp ~/mnt/C/Users/barek/AppData/Roaming/vlc/ml.xspf ~/.local/share/vlc/
			cp ~/mnt/C/Users/barek/AppData/Roaming/vlc/ml.xspf ~/mnt/C/Users/barek/AppData/Roaming/vlc/ml.xspf.backup
			sed -i 's/D:\//home\/bare\/mnt\/D\//g' ~/.local/share/vlc/ml.xspf
			sed -i 's/C:\//home\/bare\/mnt\/C\//g' ~/.local/share/vlc/ml.xspf
		case "p" or "put" or "s" or "set"
			cp ~/.local/share/vlc/ml.xspf  ~/mnt/C/Users/barek/AppData/Roaming/vlc/
			sed -i 's/home\/bare\/mnt\/D\//D:\//g' ~/mnt/C/Users/barek/AppData/Roaming/vlc/ml.xspf
			sed -i 's/home\/bare\/mnt\/C\//C:\//g' ~/mnt/C/Users/barek/AppData/Roaming/vlc/ml.xspf
		case "c" or "clean"
			rm -v ~/mnt/D/TV/**/*.exe ~/mnt/D/TV/**/*.txt ~/mnt/D/TV/**/*.nfo
	end
end

#//----------[ TYPER ]
function typer
	cd ~/code/rust/toggle_cool_cow_says_type
	cargo r -- -w 8 ./src
end

# //----------[ Break ]
function Break
	afk "Break" -m 3 -c purple
end

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

#//----------[ VARS ]
set -x XDG_CONFIG_HOME ~/.config
set -x QT_QPA_PLATFORMTHEME 'qt5ct'

#//----------[ PATH ]
set -x PATH ~/.cargo/bin ~/.local/bin $PATH ~/.zls/x86_64-linux ~/code/bin/

#//----------[ STARSHIP ]
starship init fish | source

#//----------[ STARTX ]
if status is-login
	if test -z "$DISPLAY" -a "$XDG_VTNR" = 1
		startx
	end
end

