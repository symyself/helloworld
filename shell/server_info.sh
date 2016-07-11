#!/bin/bash
# add new hadoop datanode
# songy
# 2015-08-24

function server_info()
{
    __hostname=$(hostname)
    __addr=$(ifconfig | /bin/grep -Po "(?<=addr:)[0-9.]*" | grep -v 127.0.0)
    __cpu_number=$(grep -c process /proc/cpuinfo)
    __cpu_vcores=$(/bin/grep -Po '(?<=cpu cores\t: )[0-9]*' /proc/cpuinfo | awk '{ total+=$1} END {print total}')
    __total_memory=$(head -1 /proc/meminfo  | /bin/grep -o '[0-9]*' | awk '{print $1/1024/1024"\tG"}')
    __df=$(df -h | /bin/grep ^/dev/ | /bin/grep -v boot | awk '{print $6"\t"$2}')
    __user=$(/bin/grep -Eo '^www|^hadoop' /etc/passwd)
    __hadoop_jps=$(su - hadoop -c 'jps' | cut -d' ' -f2 | /bin/grep -v Jps)
    __program=''
    [ -d /usr/local/hadoop ] && __program="/usr/local/hadoop $__program"
    [ -d /usr/local/hive ] && __program="/usr/local/hive $__program"
    [ -d /usr/local/zookeeper ] && __program="/usr/local/zookeeper $__program"

    echo "__hostname:"     $__hostname
    echo "__addr:"   $__addr
    echo "__cpu_number:"   $__cpu_number
    echo "__cpu_vcores:"   $__cpu_vcores
    echo "__total_memory:" $__total_memory
    echo "__df:" $__df
    echo "__user:" $__user
    echo "__hadoop_jps:" $__hadoop_jps
    echo "__program:" $__program
}
###(awk 'NR==1' RS= info.txt | cut -d: -f1;cut -nd: -f2 info.txt | awk 'NR%7') | paste -d';' - - - - - -
server_info
