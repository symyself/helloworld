cat > /etc/yum.repos.d/remi.repo << 'END'
[remi-php56]
name=Les RPM de remi de PHP 5.6 pour Enterprise Linux 6 - $basearch
#baseurl=http://rpms.famillecollet.com/enterprise/6/php56/$basearch/
mirrorlist=http://rpms.famillecollet.com/enterprise/6/php56/mirror
# WARNING: If you enable this repository, you must also enable "remi"
enabled=1
gpgcheck=1
gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-remi
END

