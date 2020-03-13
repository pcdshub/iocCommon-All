#!/bin/bash

# Setup the environment needed for consistent launching of soft IOC's
export IOC_USER=tstioc

# Setup the environment needed for consistent launching of soft IOC's
PROCSERV_VERSION=${PROCSERV_VERSION:=2.8.0-1.0.0}
source /reg/d/iocCommon/All/common_env.sh

ulimit -c unlimited

