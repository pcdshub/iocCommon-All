#!/bin/bash

# Setup the environment needed for consistent launching of soft IOC's
export IOC_USER=tstioc

# Setup the environment needed for consistent launching of soft IOC's
PROCSERV_VERSION=${PROCSERV_VERSION:=2.8.0-1.1.0}
source /reg/d/iocCommon/All/common_env.sh
#export PROCSERV_EXE=/reg/g/pcds/epics-dev/bhill/extensions/procServ-git/procServ
#export PROCSERV="$PROCSERV_EXE --allow --ignore ^D^C --logstamp"
#pathmunge /reg/g/pcds/epics-dev/bhill/extensions/procServ-git

ulimit -c unlimited

