#!/bin/sh

# Figure out the hutch configuration: fee, amo, sxr, xpp, ...
IOC_HOST=`$IOC_COMMON/All/get_hostname.sh | tail -1`
cfg=`awk /$IOC_HOST/'{print $2;}'  $CONFIG_SITE_TOP/hosts.special`
if [ "${cfg}X" == "X" ]; then
    cfg=`echo $IOC_HOST | awk '{print substr($0,5,3);}' -`
fi

# If directory doesn't exist, fall back to using subnet from IP address
if [ ! -d $CONFIG_SITE_TOP/$cfg ]; then
	if [ -e /reg/common/tools/bin/netconfig ]; then
		IOC_HOST_IP=`netconfig view $IOC_HOST | egrep "IP:" | sed -e "s/\s*IP:\s*\(\S\+\)\s*/\1/"`
	else
		IOC_HOST_IP=`/sbin/ifconfig | /bin/grep -w inet | head -n1 | sed -e 's/ *inet[^0-9]*\([0-9.]*\) .*/\1/'`
	fi
	IOC_SUBNET=`echo $IOC_HOST_IP | cut -d. -f3`
	case $IOC_SUBNET in
		37) cfg=amo; ;;
		35) cfg=las; ;;
		68) cfg=cxi; ;;
		58) cfg=det; ;;
		36) cfg=fee; ;;
		64) cfg=hpl; ;;
		45) cfg=mec; ;;
		62) cfg=mfx; ;;
		39) cfg=sxr; ;;
		57) cfg=thz; ;;
		42) cfg=tst; ;;
		43) cfg=xcs; ;;
		38) cfg=xpp; ;;
	esac
fi
echo $cfg
