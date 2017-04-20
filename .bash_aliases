alias cls=clear
alias cdh="cd /mnt/c/Users/AlexFSmirnov"
cs() {
    cd $1
    ls
}

gcpp() {
    g++ -O2 -std=c++11 -Wall -Wextra -DLOCAL $1 -o ${1%%.*}
}

