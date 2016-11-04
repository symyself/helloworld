#/bin/sh
#
echo -n 'enter commit comments:'
read comments

function push_github()
{
    git add *
    git ci -m "$(date +'%F %T') ${comments}"
    git push
}

cd /data/mydoc/
push_github

rsync -av --delete /data/mydoc/build/html/* /data/symyself.github.io/mydoc/

cd /data/symyself.github.io/
push_github
