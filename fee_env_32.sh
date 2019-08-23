#!/bin/bash

# Setup the environment needed for consistent launching of soft IOC's
export EPICS_SITE_TOP=/reg/g/pcds/package/epics/3.14
export IOC_DATA=/reg/d/iocData/
export PROCSERV_EXE=/reg/g/pcds/package/procServ-2.4.0/procServ 
export PROCSERV="$PROCSERV_EXE --allow --ignore ^D^C"
export IOC_HOST=`hostname -s`
export CA_BIN=/reg/g/pcds/package/epics/3.14/base/current/bin/linux-x86
export PATH=$PATH:${CA_BIN}
export IOC_USER=feeioc
export INSTR_GROUP=ps-fee

# Run processes as the correct IOC userid
export RUNUSER="/sbin/runuser $IOC_USER -s /bin/bash --preserve-environment -c"

if [ "$IOC" != "" ]; then
source /reg/d/iocCommon/All/setup_iocdata.sh
fi
