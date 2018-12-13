#!/bin/bash

# Setup the environment needed for consistent launching of soft IOC's
export EPICS_SITE_TOP=/reg/g/pcds/package/epics/3.14
export IOC_DATA=/reg/d/iocData
if [ X`which perl` == X ]; then
    # We're cheating for linuxRT.
    export EPICS_HOST_ARCH=rhel6-x86_64
    export EPICS_VERSION=R3.14.12-0.4.0
else
    export EPICS_HOST_ARCH=$(${EPICS_SITE_TOP}/base/R3.14.12-0.4.0/startup/EpicsHostArch)
    export EPICS_VERSION=R3.14.12-0.4.0
fi
# export PROCSERV="/reg/g/pcds/package/epics/3.14/extensions/R3.14.12/bin/$EPICS_HOST_ARCH/procServ --allow --ignore ^D^C --logstamp"
export PROCSERV="/reg/g/pcds/pkg_mgr/release/procServ/2.7.0-1.2.0/$EPICS_HOST_ARCH/bin/procServ --allow --ignore ^D^C --logstamp"
export IOC_HOST=`hostname -s`
export CA_BIN=/reg/g/pcds/package/epics/3.14/base/$EPICS_VERSION/bin/$EPICS_HOST_ARCH

# Get the creation time
export CREATE_TIME=`date '+%m%d%Y_%H%M%S'`

if [ "$IOC_USER" == "" ]; then
	echo Warning: Set IOC_USER env variable in your startup.cmd file before running common_env.sh
else
	# Run processes as the correct IOC userid
        if [ -f /sbin/runuser ]; then
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
		$RUNUSER "chmod ug+w -R $IOC_DATA/$IOC"
	fi
fi
