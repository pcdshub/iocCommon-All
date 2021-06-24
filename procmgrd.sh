#!/bin/sh
# Must be run as hutch specific IOC username after NFS mounts,
# multi-user.target and boot-complete.target.

# =============================================================
# Setup the common directory env variables
# Set the common directory env variables
if   [ -f  /usr/local/lcls/epics/config/common_dirs.sh ]; then
	source /usr/local/lcls/epics/config/common_dirs.sh 
elif [ -f  /reg/g/pcds/pyps/config/common_dirs.sh ]; then
	source /reg/g/pcds/pyps/config/common_dirs.sh
elif [ -f  /afs/slac/g/lcls/epics/config/common_dirs.sh ]; then
	source /afs/slac/g/lcls/epics/config/common_dirs.sh
fi
if [ -z $IOC_COMMON ]; then
	IOC_COMMON=/reg/d/iocCommon
fi

# Setup our path, so we can find our python, procServ, and procmgrd!
echo source iocManager_env.sh ...
source $IOC_COMMON/All/iocManager_env.sh

# Inlined $SCRIPTROOT/initIOC.hutch
BASEPORT=39050
PROCMGRD_ROOT=procmgrd

IOC_HOST=`$IOC_COMMON/All/get_hostname.sh | tail -1`

IOC_MGR_LOG_DIR=$IOC_DATA/$IOC_HOST/logs
mkdir -p    $IOC_MGR_LOG_DIR
if [ `uname -m` = "armv7l" ]; then
	$RUNUSER "chmod 0775  $IOC_MGR_LOG_DIR"
else
	$RUNUSER "chmod g+rwx $IOC_MGR_LOG_DIR"
fi

# Allow control connections from anywhere
# ignore ^D so procmgrd doesn't terminate on ^D
# No max on coresize
# Start child processes from /tmp
PROCMGRD_ARGS="--allow --ignore '^D' --logstamp --coresize 0 -c /tmp"

# Disable procmgrd readline and filename expansion
PROCMGRD_SHELL="/bin/sh --noediting --rcfile $IOC_COMMON/All/iocManager_env.sh -i"

launchProcMgrd()
{
    PROCMGRD=$1
    ctrlport=$2
    logport=$(( ctrlport + 1 ))
	PROCMGRD_LOGFILE=$IOC_MGR_LOG_DIR/$1.log
    PROCMGRD_PID=$(ps -C $PROCMGRD -o pid=)
	if [ -z $PROCMGR_PID ]; then
		echo Launching $1 ...
    	$IOC_COMMON/All/runWithIocEnv.sh $PROCMGRD $PROCMGRD_ARGS -l $logport --logfile $PROCMGRD_LOGFILE $ctrlport $PROCMGRD_SHELL
	else
		echo $i already running
	fi
}

# Start up the procmgrd
launchProcMgrd procmgrd0 $(( BASEPORT ))

# Start caRepeater.
CAREPEATER=`which caRepeater`
PROCSERV_EXE=`which procServ`
echo Launching caRepeater via procServ ...
$PROCSERV_EXE --logfile $IOC_MGR_LOG_DIR/caRepeater.log --name caRepeater 30000 $CAREPEATER

# Figure out the hutch configuration: fee, amo, sxr, xpp, ...
cfg=`$IOC_COMMON/All/hostname_to_cfg.sh`
echo Using configuration $cfg.

# Start all of our processes.
echo Launching $IOC_HOST IOCs via procServ ...
python $CONFIG_SITE_TOP/$cfg/iocmanager/startAll.py $cfg $IOC_HOST
