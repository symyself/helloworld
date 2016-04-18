#!/bin/sh
# 拼凑 /data/helloworld/ 目录下的指定文件的下载路径
# 参数可以多个
document_dir=/data/helloworld/
base_url=http://optest219/
for f in "$@"
do
    if [ -e $f ]
    then
        fabs_path="$( cd $(dirname $f);pwd;)/$(basename $f)"
        if echo ${fabs_path} | /bin/grep -q "^${document_dir}"
        then
            echo ${fabs_path} | sed "s#^${document_dir}#${base_url}#"
        else
            echo "  error: ${fabs_path} no in dir ${document_dir}"
        fi  
    else
        echo "$f not exist"
    fi  
done
