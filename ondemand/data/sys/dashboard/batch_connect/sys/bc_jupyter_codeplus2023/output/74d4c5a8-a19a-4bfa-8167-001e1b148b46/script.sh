#!/usr/bin/env bash

#Command Tracing
set -x

# Benchmark info
echo "TIMING - Starting main script at: $(date)"

# Detect and Setup Cuda Devices
if [ -n "$CUDA_VISIBLE_DEVICES" ]; then
  export SINGULARITYENV_CUDA_VISIBLE_DEVICES="$CUDA_VISIBLE_DEVICES"
fi

# Ensure We have a TMPDIR
if [ -z "$TMPDIR" ] || [ "$TMPDIR" == "/tmp" ]; then
  TMPDIR="$(mktemp -d)"
  export TMPDIR
fi

# Set working directory to home directory
cd "${HOME}"

# Set group directory
export GROUPDIR="/hpc/group/borsuklab"
echo "GROUPDIR is ${GROUPDIR}"

# Setup Bind Mounts
BPath="$TMPDIR:/tmp"
BPath+=",/work:/work"
BPath+=",${GROUPDIR}:${GROUPDIR}"
BPath+=",/opt/apps/models:/opt/apps/models"
echo "$BPath"

#
# Start Jupyter Lab Server
#

# Benchmark info
echo "TIMING - Starting jupyter at: $(date)"

if [ "$gpu_job" == "no" ]; then
  singularity -vvv exec --bind="$BPath" "$JUPYTERLAB_IMAGE" jupyter lab --config="${CONFIG_FILE}" 
else
  singularity -vvv exec --nv --bind="$BPath" "$JUPYTERLAB_IMAGE" jupyter lab --config="${CONFIG_FILE}" 
fi
