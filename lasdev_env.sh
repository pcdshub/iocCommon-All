#!/bin/bash

# First set your IOC user
export IOC_USER=lasioc

# Setup the environment needed for consistent launching of soft IOC's
THIS_DIR="$(dirname "$(realpath "${BASH_SOURCE[0]}")")"
source "${THIS_DIR}"/common_env.sh
