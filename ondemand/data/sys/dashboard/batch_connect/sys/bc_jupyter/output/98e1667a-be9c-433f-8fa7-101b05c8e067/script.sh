#!/usr/bin/env bash

# Benchmark info
echo "TIMING - Starting main script at: $(date)"

# Set working directory to home directory
cd "${HOME}"

#
# Start Jupyter Lab Server
#

module purge
module load Anaconda3/2021.05
module list


# Benchmark info
echo "TIMING - Starting jupyter at: $(date)"

# Launch the Jupyter Lab Server
set -x
jupyter lab --config="${CONFIG_FILE}" 
