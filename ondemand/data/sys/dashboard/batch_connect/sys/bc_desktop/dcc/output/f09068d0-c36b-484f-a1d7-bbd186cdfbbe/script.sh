#!/usr/bin/env bash

# Change working directory to user's home directory
cd "${HOME}"

# Reset module environment (may require login shell for some HPC clusters)
module purge && module restore

# Ensure that the user's configured login shell is used
export SHELL="$(getent passwd $USER | cut -d: -f7)"

# Start up desktop
echo "Launching desktop 'xfce'..."
source "/hpc/home/ajj54/ondemand/data/sys/dashboard/batch_connect/sys/bc_desktop/dcc/output/f09068d0-c36b-484f-a1d7-bbd186cdfbbe/desktops/xfce.sh"
echo "Desktop 'xfce' ended with $? status..."
