#!/usr/bin/env bash
# Zend Server 6.3 PHP 5.5
export DEBIAN_FRONTEND=noninteractive

NEW_SERVER_TZ=America/Chicago
echo $NEW_SERVER_TZ | tee /etc/timezone
dpkg-reconfigure tzdata

printf "\ndeb http://repos.zend.com/zend-server/6.3/deb_ssl1.0 server non-free\n" >> /etc/apt/sources.list
wget http://repos.zend.com/zend.key -O- |apt-key add -
aptitude update

aptitude -y install zend-server-php-5.5

chmod o+x /var/log/apache2/
chmod o+r /var/log/apache2/access.log /var/log/apache2/error.log /var/log/apache2/other_vhosts_access.log

# Bootstrap Zend Server ONLY if not joining it to a cluster.
/usr/local/zend/bin/zs-manage bootstrap-single-server -p admin -a True -d dev > /vagrant/bootstrap.out 2> /vagrant/bootstrap.err
sleep 6
NEW_ZS_WEBAPI_KEY=$(grep -F admin /vagrant/bootstrap.out | cut -c 7-70)
/usr/local/zend/bin/zs-manage restart -N admin -K $NEW_ZS_WEBAPI_KEY  >> /vagrant/bootstrap.out 2>> /vagrant/bootstrap.err
sleep 6

# set default timezone
/usr/local/zend/bin/zs-manage store-directive -d date.timezone -v $NEW_SERVER_TZ -N admin -K $NEW_ZS_WEBAPI_KEY  >> /vagrant/bootstrap.out 2>> /vagrant/bootstrap.err
sleep 6
/usr/local/zend/bin/zs-manage restart -N admin -K $NEW_ZS_WEBAPI_KEY  >> /vagrant/bootstrap.out 2>> /vagrant/bootstrap.err

