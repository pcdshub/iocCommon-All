#!/bin/sh

# Extract the hutch configuration characters from the hostname: ioc-xxx-yyyyy => xxx
_host=`hostname -s`
_cfg=`echo $_host | cut -d- -f2`

# If hutch configuration directory doesn't exist, try $CONFIG_SITE_TOP/hosts.byIP
if [ ! -d $CONFIG_SITE_TOP/$_cfg ]; then
	if [ -e /reg/common/tools/bin/netconfig ]; then
		IOC_HOST_IP=`netconfig view $IOC_HOST | egrep "IP:" | sed -e "s/\s*IP:\s*\(\S\+\)\s*/\1/"`
	else
		IOC_HOST_IP=`/sbin/ifconfig | /bin/grep -w inet | head -n1 | sed -e 's/ *inet[^0-9]*\([0-9.]*\) .*/\1/'`
	fi
	_host=`awk /$IOC_HOST_IP/'{print $2;}'  $CONFIG_SITE_TOP/hosts.byIP`
	#echo "Testing: IOC_HOST_IP=$IOC_HOST_IP, _host=$_host"
fi

echo $_host
