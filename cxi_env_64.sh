#!/bin/bash

# First set your IOC user and group
export IOC_USER=cxiioc

# Setup the environment needed for consistent launching of soft IOC's
THIS_DIR="$(dirname "$(readlink -f "${BASH_SOURCE[0]}")")"
source "${THIS_DIR}"/common_env.sh
