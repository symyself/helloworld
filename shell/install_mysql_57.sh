wget http://dev.mysql.com/get/mysql57-community-release-el6-8.noarch.rpm
yum localinstall mysql57-community-release-el6-8.noarch.rpm 
yum install mysql mysql-community-server

###其实想要重置 5.7 的密码很简单，就一层窗户纸：
###1、修改 /etc/my.cnf，在 [mysqld] 小节下添加一行：skip-grant-tables=1
###这一行配置让 mysqld 启动时不对密码进行验证
###2、重启 mysqld 服务：systemctl restart mysqld
###3、使用 root 用户登录到 mysql：mysql -u root 
###4、切换到mysql数据库，更新 user 表：
###update user set authentication_string = password('root'), password_expired = 'N', password_last_changed = now() where user = 'root';
###在之前的版本中，密码字段的字段名是 password，5.7版本改为了 authentication_string
###5、退出 mysql，编辑 /etc/my.cnf 文件，删除 skip-grant-tables=1 的内容
###6、重启 mysqld 服务，再用新密码登录即可
#change password
update user set authentication_string = password('optest'), password_expired = 'N', password_last_changed = now() where user =  'root';
update user set authentication_string = password('optest'), password_expired = 'N', password_last_changed = now() where user = 'mysql.sys';
