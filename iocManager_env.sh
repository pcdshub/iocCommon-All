#!/bin/sh
# Setup the environment needed for iocManager

# Set the common directory env variables
if   [ -f  /usr/local/lcls/epics/config/common_dirs.sh ]; then
	source /usr/local/lcls/epics/config/common_dirs.sh 
elif [ -f  /reg/g/pcds/pyps/config/common_dirs.sh ]; then
	source /reg/g/pcds/pyps/config/common_dirs.sh
elif [ -f  /afs/slac/g/lcls/epics/config/common_dirs.sh ]; then
	source /afs/slac/g/lcls/epics/config/common_dirs.sh
fi

# Setup EPICS env
EPICS_HOST_ARCH=`$EPICS_SITE_TOP/base/R3.15.5-2.0/startup/EpicsHostArch`
if [ "$EPICS_HOST_ARCH" == "linux-arm-apalis" ]; then
	source $SETUP_SITE_TOP/epicsenv-3.15.5-apalis-2.0.sh;
else
	source $SETUP_SITE_TOP/epicsenv-cur.sh;
fi

echo Adding SLAC procServ to PATH
PROCSERV_VERSION=${PROCSERV_VERSION=2.8.0-1.0.0}
if [ "$EPICS_HOST_ARCH" == "linux-arm-apalis" ]; then
	PROCSERV_VERSION=2.7.0-1.3.0
	CROSS_ARCH=arm-cortexa9_neon-linux-gnueabihf
	pathmunge $PACKAGE_SITE_TOP/procServ/procServ-$PROCSERV_VERSION/install/$CROSS_ARCH/bin
elif [ -e $PSPKG_ROOT/release/procServ/$PROCSERV_VERSION/$EPICS_HOST_ARCH/bin/procServ ]; then
	pathmunge $PSPKG_ROOT/release/procServ/$PROCSERV_VERSION/$EPICS_HOST_ARCH/bin
fi

echo Adding SLAC python to PATH
PYTHON_VERSION=${PYTHON_VERSION=2.7.13}
if [ "$EPICS_HOST_ARCH" == "linux-arm-apalis" ]; then
	pathmunge       $PACKAGE_SITE_TOP/python/python$PYTHON_VERSION/install/$CROSS_ARCH/bin
	ldpathmunge     $PACKAGE_SITE_TOP/python/python$PYTHON_VERSION/install/$CROSS_ARCH/lib
	pythonpathmunge $PACKAGE_SITE_TOP/python/python$PYTHON_VERSION/install/$CROSS_ARCH/lib/python2.7/site-packages
else
	source $PSPKG_ROOT/etc/add_env_pkg.sh python/$PYTHON_VERSION
fi

export TZ=PST8PDT

export PS1="> "
