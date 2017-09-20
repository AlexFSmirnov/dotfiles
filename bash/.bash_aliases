alias cls=clear
alias cdh="cd /mnt/c/Users/AlexFSmirnov"
cs() {
    cd $1
    ls
}

gcpp() {
    g++ -O2 -std=c++11 -Wall -Wextra -DLOCAL $1 -o ${1%%.*}
}

alias ip3="python3 -i"

alias susp="systemctl suspend"
alias xcopy="xclip -selection clipboard"

export ALARM_SOUND=/usr/share/sounds/ubuntu/ringtones/Alarm\\\ clock.ogg
alias alarm="paplay $ALARM_SOUND"

transfer() { if [ $# -eq 0 ]; then echo -e "No arguments specified. Usage:\necho transfer /tmp/test.md\ncat /tmp/test.md | transfer test.md"; return 1; fi
tmpfile=$( mktemp -t transferXXX ); if tty -s; then basefile=$(basename "$1" | sed -e 's/[^a-zA-Z0-9._-]/-/g'); curl --progress-bar --upload-file "$1" "https://transfer.sh/$basefile" >> $tmpfile; else curl --progress-bar --upload-file "-" "https://transfer.sh/$1" >> $tmpfile ; fi; cat $tmpfile; rm -f $tmpfile; } 

eval $(thefuck --alias)
