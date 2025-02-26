#!/bin/bash

# First set your IOC user
export IOC_USER=tstioc
cfguser=tstioc

# Setup the environment needed for consistent launching of soft IOC's
source /reg/d/iocCommon/All/common_env.sh

ulimit -c unlimited
