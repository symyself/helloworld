#!/bin/sh
#psql -U root -d $database -h $host -p $port -c"$sql"
do_p()
{
    echo "$(date +'%F %T')|$*"
}

load_file()
{
    ls testfile 2>/dev/null
    return_code=$?
    retry_times=0
    while [ $return_code -ne 0 ]
    do
        #psql -U root -d $database -h $host -p $port -c"$sql"
        ls testfile${retry_times} 2>/dev/null
        return_code=$?
        retry_times=$((retry_times+1))
        do_p [RETRY] load retry ${retry_times}
        [ $retry_times -eq 5 ] && break
    done
    if [ $return_code == 0 ]; then
        do_p [INFO] load $fileName to redshift success
    else
        do_p [ERROR] load $fileName to redshift failed
    fi
}

load_file
