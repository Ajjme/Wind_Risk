#!/usr/bin/env bash

# Change working directory to user's home directory
cd "${HOME}"

# Reset module environment (may require login shell for some HPC clusters)
module purge && module restore

# Ensure that the user's configured login shell is used
export SHELL="$(getent passwd $USER | cut -d: -f7)"

# Start up desktop
echo "Launching desktop 'xfce'..."
source "/hpc/home/ajj54/ondemand/data/sys/dashboard/batch_connect/sys/bc_desktop/dcc/output/7fe2b2d2-4857-4ca4-bb3a-94c5baf87e3c/desktops/xfce.sh"
echo "Desktop 'xfce' ended with $? status..."
