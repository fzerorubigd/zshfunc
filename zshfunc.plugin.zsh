#!/usr/bin/env zsh

# Some systemd related stuff
alias _start='sudo systemctl start'
alias _stop='sudo systemctl stop'
alias _restart='sudo systemctl restart'
alias _status='sudo systemctl status'
alias _enable='sudo systemctl enable'
alias _disable='sudo systemctl disable'
alias _reload='sudo systemctl daemon-reload'

# Switch keyboard if needed
alias fa='setxkbmap -option grp:switch,grp:alt_shift_toggle,grp_led:scroll us,ir'

alias listener='sudo lsof -Pnl +M -i4'

function gi() { curl http://www.gitignore.io/api/$@ ;}
transfer() { curl --progress-bar --upload-file $1 https://transfer.sh/$(basename $1); }
alias transfer=transfer

# A simple command not found handler for running command in persian :))
# disabled in favor of thefuck
____command_not_found_handler() {
  persian=( ؛ ، × ٪ ﷼ ٫ ٬ ! ۰ ۹ ۸ ۷ ۶ ۵ ۴ ۳ ۲ ۱ و پ د ذ ر ز ط ظ گ ک م ن ت ا ل ب ی س ش چ ج ح خ ه ع غ ف ق ث ص ض )
  english=( q w e r t y u i o p \[ \] a s d f g h j k l \; \' z x c v b n m , 1 2 3 4 5 6 7 8 9 0 ! @ \# \$ % \^ \& \" )
  len=`echo ${#english[*]}`
  arg=$@
  prog=$1
  arg=${arg/$prog/}
  for ((i=1 ; i < $len ; i++)) do
    arg=${arg//${persian[$i]}/${english[$i]}}
    prog=${prog//${persian[$i]}/${english[$i]}}
  done

  type "$prog" &> /dev/null
  if [ "$?" = "0" ];then
        echo -e "Try to run $prog$arg \n"
        `echo $prog$arg`
     return 0
  else
      return 127
  fi
}

uncaps() {
  setxkbmap -option compose:menu
  xmodmap -e "remove Lock = Caps_Lock" # Remove Caps Lock
  xmodmap -e "keycode 66 = Multi_key" # Make the key into multykey
}

 if type history-substring-search-up > /dev/null; then  
	# bind UP and DOWN arrow keys
	zmodload zsh/terminfo
	bindkey "$terminfo[kcuu1]" history-substring-search-up
	bindkey "$terminfo[kcud1]" history-substring-search-down

	# bind UP and DOWN arrow keys (compatibility fallback
	# for Ubuntu 12.04, Fedora 21, and MacOSX 10.9 users)
	bindkey '^[[A' history-substring-search-up
	bindkey '^[[B' history-substring-search-down

	# bind P and N for EMACS mode
	bindkey -M emacs '^P' history-substring-search-up
	bindkey -M emacs '^N' history-substring-search-down

	# bind k and j for VI mode
	bindkey -M vicmd 'k' history-substring-search-up
	bindkey -M vicmd 'j' history-substring-search-down
fi;
