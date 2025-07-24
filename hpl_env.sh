#!/bin/bash

# First set your IOC user
IOC_USER=hplioc
export IOC_USER=hplioc

# Setup the environment needed for consistent launching of soft IOC's
THIS_DIR="$(dirname "$(readlink -f "${BASH_SOURCE[0]}")")"
source "${THIS_DIR}"/common_env.sh
