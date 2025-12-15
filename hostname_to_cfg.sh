#!/bin/sh
if [ -z $IOC_COMMON ]; then
	IOC_COMMON=/reg/d/iocCommon
fi
if [ -z $CONFIG_SITE_TOP ]; then
	CONFIG_SITE_TOP=/reg/g/pcds/pyps/config
fi

# Figure out the hutch configuration: fee, amo, sxr, xpp, ...
IOC_HOST=`$IOC_COMMON/All/get_hostname.sh | tail -1`
cfg=`awk /$IOC_HOST/'{print $2;}'  $CONFIG_SITE_TOP/hosts.special`
if [ "${cfg}X" == "X" ]; then
    cfg=`echo $IOC_HOST | awk '{print substr($0,5,3);}' -`
fi

# If directory doesn't exist, fall back to using subnet from IP address
if [ ! -d $CONFIG_SITE_TOP/$cfg ]; then
	IOC_HOST_IP=`/sbin/ifconfig | /bin/grep -w inet | head -n1 | sed -e 's/ *inet[^0-9]*\([0-9.]*\) .*/\1/'`
	IOC_SUBNET=`echo $IOC_HOST_IP | cut -d. -f3`
	case $IOC_SUBNET in
		36) cfg=ued; ;;
		57) cfg=thz; ;;
		58) cfg=det; ;;
		68|69|70) cfg=cxi; ;;
		72|73|74) cfg=mfx; ;;
		76|77|78) cfg=mec; ;;
		80|81|82) cfg=xcs; ;;
		84|85|86) cfg=xpp; ;;
		88|89|90) cfg=lfe; ;;
		92|93|94) cfg=kfe; ;;
		132|133|134) cfg=tmo; ;;
		136|137|138) cfg=txi; ;;
		140|141|142) cfg=rix; ;;
		148|149|150) cfg=tst; ;;
		160|161|162) cfg=las; ;;
	esac
fi
echo $cfg
