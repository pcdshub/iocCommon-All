#!/bin/bash
# Setup the environment needed for consistent launching of soft IOC's

# Set the common directory env variables
if   [ -f  /usr/local/lcls/epics/config/common_dirs.sh ]; then
	source /usr/local/lcls/epics/config/common_dirs.sh 
elif [ -f  /reg/g/pcds/pyps/config/common_dirs.sh ]; then
	source /reg/g/pcds/pyps/config/common_dirs.sh
elif [ -f  /afs/slac/g/lcls/epics/config/common_dirs.sh ]; then
	source /afs/slac/g/lcls/epics/config/common_dirs.sh
fi

# Setup EPICS env
if [ `uname -m` = "armv7l" ]; then
	source $SETUP_SITE_TOP/epicsenv-3.15.5-apalis-2.0.sh
else
	source $SETUP_SITE_TOP/epicsenv-cur.sh
fi

PROCSERV_VERSION=${PROCSERV_VERSION=2.8.0-1.0.0}
if [ "$EPICS_HOST_ARCH" == "linux-arm-apalis" ]; then
	PROCSERV_VERSION=2.7.0-1.3.0
	CROSS_ARCH=arm-cortexa9_neon-linux-gnueabihf
	pathmunge $PACKAGE_SITE_TOP/procServ/procServ-$PROCSERV_VERSION/install/$CROSS_ARCH/bin
	PYTHON_VERSION=${PYTHON_VERSION=2.7.13}
	pathmunge       $PACKAGE_SITE_TOP/python/python$PYTHON_VERSION/install/$CROSS_ARCH/bin
	ldpathmunge     $PACKAGE_SITE_TOP/python/python$PYTHON_VERSION/install/$CROSS_ARCH/lib
	pythonpathmunge $PACKAGE_SITE_TOP/python/python$PYTHON_VERSION/install/$CROSS_ARCH/lib/python2.7/site-packages
elif [ -e $PSPKG_ROOT/release/procServ/$PROCSERV_VERSION/$EPICS_HOST_ARCH/bin/procServ ]; then
	pathmunge $PSPKG_ROOT/release/procServ/$PROCSERV_VERSION/$EPICS_HOST_ARCH/bin
fi
export PROCSERV_EXE=`which procServ`
if [ -n "$PROCSERV_EXE" ]; then
	export PROCSERV="$PROCSERV_EXE --allow --ignore ^D^C --logstamp"
else
	echo "Warning: procServ path not found!"
fi
export IOC_HOST=`hostname -s`

# Get the creation time
export CREATE_TIME=`date '+%m%d%Y_%H%M%S'`

if [ "$IOC_USER" == "" ]; then
	echo Warning: Set IOC_USER env variable in your startup.cmd file before running common_env.sh
else
	# Run processes as the correct IOC userid
	if [ "$IOC_USER" == "$USER" ]; then
	    export RUNUSER="/bin/bash -c"
	elif [ -f /sbin/runuser ]; then
	    export RUNUSER="/sbin/runuser $IOC_USER -s /bin/bash --preserve-environment -c"
	else
	    export RUNUSER="su $IOC_USER -c"
	fi

	# Make sure the host iocData directory exists for the caRepeater log
	if [ ! -d $IOC_DATA/$IOC_HOST ]; then
		$RUNUSER "mkdir $IOC_DATA/$IOC_HOST"
		$RUNUSER "setfacl -d -m group:ps-ioc:rwx $IOC_DATA/$IOC_HOST"
		$RUNUSER "setfacl    -m group:ps-ioc:rwx $IOC_DATA/$IOC_HOST"
		$RUNUSER "mkdir -p $IOC_DATA/$IOC_HOST/iocInfo"
		$RUNUSER "mkdir -p $IOC_DATA/$IOC_HOST/logs"
	fi

	# Make sure the soft ioc iocData directories exist and have the right permissions
	if [ "$IOC" == "" ]; then
		echo Warning: Set IOC env variable in your startup.cmd file before running common_env.sh
	elif [ ! -d $IOC_DATA/$IOC ]; then
		$RUNUSER "mkdir $IOC_DATA/$IOC"
		$RUNUSER "setfacl -d -m group:ps-ioc:rwx $IOC_DATA/$IOC"
		$RUNUSER "setfacl    -m group:ps-ioc:rwx $IOC_DATA/$IOC"
		$RUNUSER "mkdir -p $IOC_DATA/$IOC/autosave"
		$RUNUSER "mkdir -p $IOC_DATA/$IOC/archive"
		$RUNUSER "mkdir -p $IOC_DATA/$IOC/iocInfo"
		$RUNUSER "mkdir -p $IOC_DATA/$IOC/logs"
		$RUNUSER "chgrp ps-ioc -R $IOC_DATA/$IOC"
		$RUNUSER "chmod ug+rws -R $IOC_DATA/$IOC"
	fi
fi
