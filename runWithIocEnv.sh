#!/bin/sh

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

# Setup iocManager env so we can find procServ, procmgrd, and caRepeater
# Also sets up required PS1 prompt
source /reg/d/iocCommon/All/iocManager_env.sh

#echo runWithIocEnv.sh: exec $*
exec $*
