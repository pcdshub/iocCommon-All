#!/bin/sh

# Set the target architecture
export T_A=linux-arm-apalis

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

# Figure out the hutch configuration: fee, amo, sxr, xpp, ...
cfg=`$IOC_COMMON/All/hostname_to_cfg.sh`
echo Using configuration $cfg.

#if [ -z "$IOC" ]; then
#	IOC=$IOC_HOST
#fi

# Setup our path, so we can find our python, procServ, and procmgrd!
echo source iocManager_env.sh ...
source $IOC_COMMON/All/iocManager_env.sh
#echo source ${cfg}_env.cmd ...
#source $IOC_COMMON/All/${cfg}_env.sh

export SCRIPTROOT=$CONFIG_SITE_TOP/$cfg/iocmanager

# Inlined $SCRIPTROOT/initIOC.hutch
BASEPORT=39050
PROCMGRD_ROOT=procmgrd

IOC_USER=${cfg}ioc
if [ "$IOC_USER" != "$USER" ]; then
    echo procmrgd: Warning, USER=$USER
fi
export IOC_USER

IOC_HOST=`$IOC_COMMON/All/get_hostname.sh | tail -1`

IOC_MGR_LOG_DIR=$IOC_DATA/$IOC_HOST/logs
mkdir -p    $IOC_MGR_LOG_DIR
chmod g+rwx $IOC_MGR_LOG_DIR

# Allow control connections from anywhere
# ignore ^D so procmgrd doesn't terminate on ^D
# No max on coresize
# Start child processes from /tmp
PROCMGRD_ARGS="--allow --ignore '^D' --logstamp --coresize 0 -c /tmp"

# Disable procmgrd readline and filename expansion
PROCMGRD_SHELL="/bin/sh --noediting --rcfile $IOC_COMMON/All/iocManager_env.sh -i"

launchProcMgrD()
{
	echo Launching $2 ...
	cfgduser=$1
    PROCMGRD=$2
    ctrlport=$3
    logport=$(( ctrlport + 1 ))
	PROCMGRD_LOGFILE=$IOC_MGR_LOG_DIR/$2.log
    echo $IOC_COMMON/All/runWithIocEnv.sh $PROCMGRD $PROCMGRD_ARGS -l $logport --logfile $PROCMGRD_LOGFILE $ctrlport $PROCMGRD_SHELL
    $IOC_COMMON/All/runWithIocEnv.sh $PROCMGRD $PROCMGRD_ARGS -l $logport --logfile $PROCMGRD_LOGFILE $ctrlport $PROCMGRD_SHELL
}

# Start up the procmgrd for the hutch IOC_USER.
launchProcMgrD $IOC_USER procmgrd0 $(( BASEPORT ))

# Start caRepeater.
CAREPEATER=`which caRepeater`
PROCSERV=`which procServ`
echo Launching caRepeater via procServ ...
$PROCSERV --logfile $IOC_MGR_LOG_DIR/caRepeater.log --name caRepeater 30000 $CAREPEATER

# Start all of our processes.
echo Launching $IOC_HOST IOCs via procServ ...
python $SCRIPTROOT/startAll.py $cfg $IOC_HOST
