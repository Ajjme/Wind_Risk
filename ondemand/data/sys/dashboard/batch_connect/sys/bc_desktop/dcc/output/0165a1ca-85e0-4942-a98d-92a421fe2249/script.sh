#!/usr/bin/env bash

# Change working directory to user's home directory
cd "${HOME}"

# Reset module environment (may require login shell for some HPC clusters)
module purge && module restore

# Ensure that the user's configured login shell is used
export SHELL="$(getent passwd $USER | cut -d: -f7)"

# Start up desktop
echo "Launching desktop 'xfce'..."
source "/hpc/home/ajj54/ondemand/data/sys/dashboard/batch_connect/sys/bc_desktop/dcc/output/0165a1ca-85e0-4942-a98d-92a421fe2249/desktops/xfce.sh"
echo "Desktop 'xfce' ended with $? status..."
