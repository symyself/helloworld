
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
