# User specific aliases and functions

#alias bashrc='vim ~/.bashrc && source ~/.bashrc'
alias rm='rm -i'
alias mrm='rm -rf'
alias cp='cp -i'
alias mv='mv -i'
alias vi='vim'
alias cpr='cp -r'
alias grep='grep -nE --color'
alias g2u='iconv -f gbk -t utf-8'
alias u2g='iconv -f utf-8 -t gbk'
alias df='df -h'
alias du='du -h'
alias wc='wc -l'
alias pid='pidof'
alias pss='ps aux|grep'
alias c='clear'
alias n='netstat -lntp'
alias f='free -m'
alias tf='tail -f'
alias w1='watch -n1'
alias du0='du --max-depth=0'
alias du1='du --max-depth=1'
alias ll='ls -l'
alias lz='ls -lhrS'
alias lt='ls -lhrt'
alias lsd='find . -type d'
alias lsf='find . -type f'
alias chux='chmod u+x'
alias now='date +"%F %T"'
alias nows='date +"%Y%m%d%H%M%S"'
alias m='mysql -uroot -p'
alias reboot='echo disable reboot'
alias halt='echo disable halt'

cpbak(){
    cp -ar "${1%/}" ${1%/}_bak$(date +'%Y%m%d_%H%M%S')
	ls ${1%/}*
}

mvbak(){
    mv  "${1%/}" ${1%/}_bak$(date +'%Y%m%d_%H%M%S')
	ls ${1%/}*
}

mcd(){
    mkdir -pv "$@"
    cd "$@"
}

nt() {
    if [[ "$1" =~ "-h" ]];then
        echo "Usg: nt [port] [top number]"
    else
        case "$#" in
            1)
                netstat -ant|gawk -v port=$1 -F '([ ]*|:)' '(/^tcp/ && $5 ~ port){++a[$6]}END{for(i in a) print a[i],i}'|sort -nr ;;
            2)
                netstat -ant|gawk -v port=$1 -F '([ ]*|:)' '(/^tcp/ && $5 ~ port){++a[$6]}END{for(i in a) print a[i],i}'|sort -nr|head -n $2 ;;
            *)
                netstat -ant|awk '/^tcp/{stat[$NF]++}END{for(i in stat) print stat[i],i}';;
        esac
    fi
}


ch() {
  if [ -d $1 ]; then
    find $1 -type d -exec chmod 750 {} \;
    find $1 -type f -exec chmod 640 {} \;
    chown -R sxing:sxing $1
  else
    chown sxing:sxing $1
  fi
}

chweb() {
  if [ -d $1 ]; then
    find $1 -type d -exec chmod 755 {} \;
    find $1 -type f -exec chmod 644 {} \;
    chown -R apache:apache $1
  else
    chown apache:apache $1
  fi
}

mktar(){ tar -cf  "${1%%/}_$(date +'%Y%m%d_%H%M%S').tar"     "${1%%/}/"; }
mktgz(){ tar -czf "${1%%/}_$(date +'%Y%m%d_%H%M%S').tar.gz"  "${1%%/}/"; }
mktbz(){ tar -cjf "${1%%/}_$(date +'%Y%m%d_%H%M%S').tar.bz2" "${1%%/}/"; }

extract(){
if [ -f $1 ]; then
         case $1 in
             *.tar.bz2)   tar xjf $1 && cd ${1%.tar.bz2} ;;
             *.tar.gz)    tar xzf $1 && cd ${1%.tar.gz} ;;
             *.bz2)       bunzip2 $1 && cd ${1%.bz2} ;;
             *.rar)       unrar e $1 && cd ${1%.rar} ;;
             *.gz)        gunzip $1 && cd ${1%.gz} ;;
             *.tar)       tar xf $1 && cd ${1%.tar} ;;
             *.tbz2)      tar xjf $1 && cd ${1%.tbz2} ;;
             *.tgz)       tar xzf $1 && cd ${1%.tgz} ;;
             *.zip)       unzip $1 && cd ${1%.zip} ;;
             *.Z)         uncompress $1 && cd ${1%.Z} ;;
             *.7z)        7z x $1 && cd ${1%.7z};;
             *)           echo "'$1' cannot be extracted via extract()" ;;
         esac
else
         echo "'$1' is not a valid file"
fi
}

#######################################################tmux
function startmyself()
{
    cmd=$(which tmux)      # tmux path
    cmd="${cmd} -2"
    session='symyself'
    if [ -z $cmd ]; then
        echo "You need to install tmux."
        exit 1
    fi
    if ! $cmd ls | grep $session
    then
        $cmd new -d -n vim -s $session "vim /root/init.sh"
        #$cmd splitw -h -p 20 -t $session "bash"
        $cmd neww -n ipython -t $session "ipython"
        $cmd neww -n mysql -t $session "mysql -uroot -p'optest'"
        $cmd neww -n shell -t $session "bash"
        $cmd selectw -t $session:1
        $cmd att -t $session
    else
        echo 'tmux symyself session exists already!'
    fi
}
alias tomyself='tmux a -t symyself'
function stopmyself()
{
    ##tmux list-windows -a -F"#{session_name} #{window_name}" |
    ##awk '/symyself/{print $2}' |  xargs -I {} tmux killw -t {}
    tmux kill-session -t symyself
}
function startsongy()
{
    cmd=$(which tmux)      # tmux path
    cmd="${cmd} -2"
    session='songy'
    if [ -z $cmd ]; then
        echo "You need to install tmux."
        exit 1
    fi
    if ! $cmd ls | grep $session
    then
        $cmd new -d -n vim -s $session "bash"
        $cmd neww -n shell -t $session "bash"
        $cmd neww -n ipython -t $session "ipython"
        $cmd neww -n mysql -t $session "mysql -uroot -p'optest'"
        $cmd neww -n redis1 -t $session "redis-cli -n 1"
        $cmd neww -n redis2 -t $session "redis-cli -n 2"
        $cmd selectw -t $session:1
        $cmd att -t $session
    else
        echo 'tmux songy session exists already!'
    fi
}
alias tosongy='tmux a -t songy'
function stopsongy()
{
    ##tmux list-windows -a -F"#{session_name} #{window_name}" |
    ##awk '/songy/{print $2}' |  xargs -I {} tmux killw -t {}
    tmux kill-session -t songy
}
alias tmuxls='tmux ls;tmux list-windows -a -F"#{session_name} #{window_name} #{window_active}"'

#######################################################tmux
