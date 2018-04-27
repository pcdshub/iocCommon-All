#!/bin/bash

# Setup the environment needed for consistent launching of soft IOC's
export EPICS_SITE_TOP=/reg/g/pcds/package/epics/3.14
export IOC_DATA=/reg/d/iocData/fee
export PROCSERV="/reg/g/pcds/package/procServ-2.4.0/procServ --allow --ignore ^D^C"
export IOC_HOST=`hostname -s`
export CA_BIN=/reg/g/pcds/package/epics/3.14/base/current/bin/linux-x86
export PATH=$PATH:${CA_BIN}

# Run processes as the correct IOC userid
export RUNUSER="/sbin/runuser feeioc -s /bin/bash --preserve-environment -c"

