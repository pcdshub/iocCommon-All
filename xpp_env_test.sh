#!/bin/bash

# Setup the environment needed for consistent launching of soft IOC's
export EPICS_SITE_TOP=/reg/g/pcds/package/epics/3.14
export IOC_DATA=/reg/d/iocData/xpp
export PROCSERV_EXE=/reg/g/pcds/package/procServ-2.4.0/procServ 
export PROCSERV="$PROCSERV_EXE --allow --ignore ^D^C"
export IOC_HOST=`hostname -s`
export CA_BIN=/reg/g/pcds/package/epics/3.14/base/current/bin/linux-x86_64

# Run processes as the correct IOC userid
export RUNUSER="/sbin/runuser xppioc -s /bin/bash --preserve-environment -c"

