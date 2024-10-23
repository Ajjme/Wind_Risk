#!/usr/bin/env bash

# Export the module function if it exists
[[ $(type -t module) == "function" ]] && export -f module

# Find available port to run server on
port=$(find_port ${host})

# Define a password and export it for RStudio authentication
password="$(create_passwd 16)"
export RSTUDIO_PASSWORD="${password}"

# Gerate CSRF Token
export csrftoken="5867ced7-ed76-4f77-aac5-bab9d82375fd"

# Set ENV Variables for script.sh
export RSTUDIO_SERVER_IMAGE=/opt/apps/community/od_chsi_rstudio/hiv_r25_rstudio.sif
export GROUPDIR="/hpc/group/borsuklab"

# Is GPU Job?
export gpu_job="no"
