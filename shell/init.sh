#!/bin/sh
#
# init Centos6.4
function stop_useless_service()
{
	for srv in ip6tables netfs postfix
	do
		service $srv stop
		chkconfig $srv off
	done
}
function disable_selinux()
{
	sed -i '/^SELINUX=/s/^.*/SELINUX=disabled/' /etc/sysconfig/selinux
	sed -i '/^SELINUX=/s/^.*/SELINUX=disabled/' /etc/selinux/config
	/usr/sbin/setenforce 0
}
function set_yum()
{
	mkdir /etc/yum.repos.d/bak
	mv /etc/yum.repos.d/*.repo /etc/yum.repos.d/bak/
	curl -o /etc/yum.repos.d/Centos-6.repo  http://mirrors.aliyun.com/repo/Centos-6.repo
	#epel
	#curl -o epel-release-latest-6.noarch.rpm http://mirrors.aliyun.com/epel/epel-release-latest-6.noarch.rpm
	#rpm -ivh epel-release-latest-6.noarch.rpm

	##nginx
	cat > /etc/yum.repos.d/nginx.repo <<'eof'
[nginx]
name=nginx repo
baseurl=http://nginx.org/packages/centos/6/$basearch/
gpgcheck=0
enabled=0
eof
	#remi.repo for mysql server
	cat > /etc/yum.repos.d/remi.repo <<'eof'
[remi]
name=Les RPM de remi pour Enterprise Linux 6 - $basearch
baseurl=http://rpms.famillecollet.com/enterprise/6/remi/$basearch/
#mirrorlist=http://rpms.famillecollet.com/enterprise/6/remi/mirror
enabled=0
gpgcheck=0
gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-remi

[remi-test]
name=Les RPM de remi en test pour Enterprise Linux 6 - $basearch
baseurl=http://rpms.famillecollet.com/enterprise/6/test/$basearch/
#mirrorlist=http://rpms.famillecollet.com/enterprise/6/test/mirror
enabled=0
gpgcheck=0
gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-remi

[remi-debuginfo]
name=Les RPM de remi pour Enterprise Linux 6 - $basearch - debuginfo
baseurl=http://rpms.famillecollet.com/enterprise/6/debug-remi/$basearch/
enabled=0
gpgcheck=0
gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-remi

[remi-test-debuginfo]
name=Les RPM de remi en test pour Enterprise Linux 6 - $basearch - debuginfo
baseurl=http://rpms.famillecollet.com/enterprise/6/debug-test/$basearch/
enabled=0
gpgcheck=0
gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-remi
eof
	yum clean all
	yum makecache
}
function install_usefull_tools()
{
	yum install -y vim wget telnet man gcc gdb make cmake tree lrzsz openssh-clients sysstat zip uizip lsof rsync git
}
function install_nginx()
{
	yum --disablerepo=* --enablerepo=nginx -y install nginx
	sed -i "/^user/s/^user .*;$/user ${web_user};/" /etc/nginx/nginx.conf
	chkconfig nginx on
	/etc/init.d/nginx start
}
function install_php()
{
	yum -y --disablerepo=* --enablerepo=base install php*
	sed -i "/^user/s/^user.*$/user = ${web_user}/" /etc/php-fpm.d/www.conf
	sed -i "/^group/s/^group.*$/group = ${web_user}/" /etc/php-fpm.d/www.conf
	chkconfig php-fpm on
	/etc/init.d/php-fpm start
}
function install_mysql()
{
	###yum install mysql mysql-server  --enablerepo=remi  -y
	yum install perl-DBD-MySQL libaio --disablerepo=* --enablerepo=base -y
	#yum install mysql mysql-server  --disablerepo=* --enablerepo=Custom-Rpmforge  -y
	yum install mysql mysql-server mysql-devel --disablerepo=* --enablerepo=remi  -y
	service mysqld  stop
	[ -d ${mysql_data_dir} ] && rm -rf ${mysql_data_dir}

	# 复制mysql数据文件
	/bin/cp  -ra /var/lib/mysql  ${mysql_data_dir}
	cat >/etc/my.cnf<<eof
[mysqld]
datadir=${mysql_data_dir}
socket=/var/lib/mysql/mysql.sock

symbolic-links=0

user=mysql
character-set-client-handshake = FALSE
character-set-server = utf8mb4
collation-server = utf8mb4_unicode_ci
init_connect='SET NAMES utf8mb4'


max_connections = 3000
max_connect_errors = 30
table_open_cache = 4096
#external-locking #默认没有开启
max_allowed_packet = 32M
max_heap_table_size = 128M

# *** global cache ***
read_buffer_size = 8M
read_rnd_buffer_size = 64M
sort_buffer_size = 16M
join_buffer_size = 16M

# *** thread ***
thread_cache_size = 16
thread_concurrency = 8
thread_stack = 512K

# *** query  cache ***
query_cache_size = 128M
query_cache_limit = 4M

#*** MyISAM Specific options
key_buffer_size = 128M
bulk_insert_buffer_size = 256M
myisam_sort_buffer_size = 256M
myisam_max_sort_file_size = 10G
myisam_repair_threads = 1

[mysqld_safe]
log-error=/var/log/mysqld.log
pid-file=/var/run/mysqld/mysqld.pid

[client]
default-character-set = utf8mb4
socket=/var/lib/mysql/mysql.sock

[mysql]
default-character-set = utf8mb4
eof
	/etc/init.d/mysqld start
	chkconfig mysqld on
    mysql -e 'delete from mysql.user where user="";update mysql.user set password=password("initpasswordis123");flush privileges;'
}
function install_python27()
{
	cd ${download_dir}
	wget ${python27_url}
	tar zxf $(basename ${python27_url})
	yum install openssl gcc openssl-devel python-devel sqlite-devel readline readline-devel patch mlocate -y
	cd Python-2.7*
	./configure
	make
	make install

    #    wget https://bootstrap.pypa.io/ez_setup.py -O - | python
	cd ${download_dir}
	wget ${ez_setup_url}
	wget ${pip_url}
	/bin/env python2.7 ez_setup.py
	/bin/env python2.7 get-pip.py
	/bin/env pip2.7 install uwsgi
	/bin/env pip2.7 install ipython
	/bin/env pip2.7 install virtualenv
}
function set_vim()
{
	cat >> /root/.vimrc <<'eof'
" add by songyang
set nu          "显示行号
set autoindent  "自动缩进
"set nonu       "不显示行号


"use 4 space for indent
set ts=4        "tabstop 修改tab==4空格长度
set et      "expandtab,将tab键展开成空格
"set sta     "smartab,在行首按TAB将加入sw个空格
set sw=4    "shiftwidth,自动缩进插入的空格数
set sts=4   "softabstop,使用<Tab>或<BS>自动插入或删除相应的空格数
"use 4 space for indent

"自动生成tags
set autochdir
set tags=tags
eof
}
function extract()
{
    if [ -f $1 ]
    then
        case $1 in
            *.tar.gz)           tar xzf $1 && cd ${1%.tar.gz};;
            *.tgz)              tar xzf $1 && cd ${1%.tgz};;
            *.zip)              unzip $1 && cd ${1%.zip};;
            *)                  echo "'$1' cannot be extracted via extract()" ;;
        esac
    else
        echo "'$1' is not a valid file"
    fi
}
function install_redis()
{
    # redis doc http://redis.io/download
    yum install tcl -y
    cd ${download_dir}
    wget ${redis_url}
    extract $(basename ${redis_url})
    make
    make test && make install
    cp redis.conf /etc/redis.conf.default
}
function set_alias_and_func()
{
    cd ${download_dir}
    wget ${aliases_url}
    cp /etc/bashrc /etc/bashrc_bk
    cat $(basename ${aliases_url}) >> /etc/bashrc
}
function confirm()
{
	download_dir=/data/tools/init
	[ -d ${download_dir} ] || mkdir -p ${download_dir}
	base_dir=$(cd $(dirname $0);pwd)
	web_user=www
    id ${web_user}
    [ $? -eq 0 ] || useradd -s /sbin/nologin ${web_user}
	mysql_data_dir=/data/mysql

	#python27
	python27_url=http://192.168.0.165:9999/python/Python-2.7.10.tgz
	ez_setup_url=http://192.168.0.165:9999/python/ez_setup.py
	pip_url=http://192.168.0.165:9999/python/get-pip.py

    #redis
    #redis_url=http://download.redis.io/releases/redis-2.6.17.tar.gz
    redis_url=http://download.redis.io/releases/redis-3.0.5.tar.gz
    #aliase
    aliases_url=http://192.168.0.165:9999/specific_aliases_and_functions.sh
}
function main()
{
	confirm
	###stop_useless_service
	disable_selinux
	###set_yum
	###install_usefull_tools
	####set_vim
    #set_alias_and_func

	#注意 必须先安装mysql,在安装php
	#install_mysql
	#install_php
	#install_nginx
	#install_python27
	#install_redis
}
main
