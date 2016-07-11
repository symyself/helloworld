#!/bin/sh

##打印终端颜色
function _red()
{
#red
    msg=$*
    echo -e "\033[0;31;1m${msg}\033[0m"
}
function _green()
{
#green
    msg=$*
    echo -e "\033[0;32;1m${msg}\033[0m"
}
function _yellow()
{
#_yellow
    msg=$*
    echo -e "\033[0;33;1m${msg}\033[0m"
}
function _w()
{
    msg=$*
    _red $msg
    _green $msg
    _yellow $msg
}


####搜集服务器信息
function _ip_addr()
{
    /sbin/ifconfig  | /bin/grep -Po "(?<=addr:)[0-9.]*" | /bin/grep -v '127.0.0.1'
}
function _cpu_info()
{
    cpu_number=$(/bin/grep 'physical id' /proc/cpuinfo  | sort | uniq | wc -l)
    core_number=$(/bin/grep processor /proc/cpuinfo  | sort | uniq | wc -l)
    model_name=$(cat /proc/cpuinfo|/bin/grep 'model name'|sort|uniq|awk -F: '{print $2}')
    echo "cpu_number:${cpu_number}"
    echo "core_number:${core_number}"
    echo "model_name:${model_name}"
}
function _mem_info()
{
    mem_total=$(dmidecode -t 17 | /bin/grep Size.*B | /bin/grep -o '[0-9]*' | uniq -c |awk '{print $1"X"$2/1024"G"}')
    swap_total=$(cat /proc/meminfo | awk -F':|k' '/SwapTotal/{printf("%d%s\n", $2/1024/1024,"G")}')
    echo "mem_total:${mem_total}"
    echo "swap_total:${swap_total}"
}
function _disk_info()
{
    if [ -x /usr/local/nagios/libexec/check_openmanage ]
    then
        disk_info=$(/usr/local/nagios/libexec/check_openmanage --only storage -d | /bin/grep  -Eo '/dev/.*RAID.*B' | sed "s#' \[#,#")
    else
        disk_info=$(fdisk -l| /bin/grep -o "/dev.*B")
    fi
    echo "${disk_info}"
}
function _product_name()
{
    Product_Name=$(dmidecode -t 1 | sed -n '/Product Name/s/^.*Product Name: //p')
    echo "Product_Name:${Product_Name}"
}
function _serial_number()
{
    Serial_Number=$(dmidecode -t 1 | sed -n '/Serial Number/s/^.*Serial Number: //p')
    echo "Serial_Number:${Serial_Number}"
}
function _hadware_info()
{
    _ip_addr | tr '\n' ',' | sed 's/,$/\n/'
    _product_name | cut -d':' -f2
    _serial_number | cut -d':' -f2
    _cpu_info | cut -d':' -f2
    _mem_info | cut -d':' -f2
    _disk_info | tr '\n' ',' | sed 's/,$/\n/'
    _mac_addr | tr '\n' ',' | sed 's/,$/\n/'
}

function _mac_addr()
{
    mac_addr=$(/sbin/ifconfig  | /bin/grep -Po '(?<=HWaddr ).*' | sort | uniq)
    echo "${mac_addr}"
}
#_hadware_info | tr '\n' '#'
_ip_addr
_mem_info
_disk_info
_mac_addr
