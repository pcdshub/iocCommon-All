#!/bin/sh

# First, make sure we have the right hostname by pending
# if the hostname matches one in $CONFIG_SITE_TOP/hosts.pend
# Typically this will be an embedded linux of some variant w/
# a vendor derived hostname which we'll update via DNS
function is_pend_host()
{
	fgrep -q $1 $CONFIG_SITE_TOP/hosts.pend 2>&1 > /dev/null
	if (( $? == 0 )); then
		echo pend;
	else
		echo OK;
	fi
}
#export IOC_HOST=`hostname -s`
#export _pend=`is_pend_host $IOC_HOST`
#while [ "$_pend" == "pend" ]; do
#	echo "hostname is $IOC_HOST, pending 5 sec ..."
#	sleep 5
#	export IOC_HOST=`hostname -s`
#	export _pend=`is_pend_host $IOC_HOST`
#done

# Extract the hutch configuration characters from the hostname: ioc-xxx-yyyyy => xxx
_host=`hostname -s`
_cfg=`echo $_host | cut -d- -f2`
#echo "Testing: _host=$_host, _cfg=$_cfg"
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
