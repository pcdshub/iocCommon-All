#!/bin/bash

# Setup the environment needed for consistent launching of soft IOC's
export EPICS_SITE_TOP=/reg/g/pcds/package/epics/3.14
export IOC_DATA=/reg/d/iocData/
export PROCSERV_EXE=/reg/g/pcds/package/epics/3.14/extensions/R3.14.12/bin/linux-x86_64/procServ 
export PROCSERV="$PROCSERV_EXE --allow --ignore ^D^C --logstamp"
export IOC_HOST=`hostname -s`
export CA_BIN=/reg/g/pcds/package/epics/3.14/base/current/bin/linux-x86_64
export IOC_USER=mecioc
export INSTR_GROUP=ps-mec

# Run processes as the correct IOC userid
export RUNUSER="/sbin/runuser $IOC_USER -s /bin/bash --preserve-environment -c"

if [ "$IOC" != "" ]; then
source /reg/d/iocCommon/All/setup_iocdata.sh
fi
