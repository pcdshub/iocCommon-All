#!/bin/bash


# First set your IOC user
export IOC_USER=feeioc
export INSTR_GROUP=ps-ued

# Setup the environment needed for consistent launching of soft IOC's
source /reg/d/iocCommon/All/common_env.sh

export EPICS_CA_SERVER_PORT=5058
export EPICS_CA_REPEATER_PORT=5059
