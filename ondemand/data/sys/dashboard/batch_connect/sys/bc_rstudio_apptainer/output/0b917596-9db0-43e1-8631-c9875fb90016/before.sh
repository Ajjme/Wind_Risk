#!/usr/bin/env bash

# Export the module function if it exists
[[ $(type -t module) == "function" ]] && export -f module

# Find available port to run server on
port=$(find_port ${host})

# Define a password and export it for RStudio authentication
password="$(create_passwd 16)"
export RSTUDIO_PASSWORD="${password}"

# Gerate CSRF Token
export csrftoken="06b1116f-77c5-4c02-9b17-46e7f97b861e"

# Set Singularity Image
export RSTUDIO_SERVER_IMAGE=/opt/apps/containers/oit/rstudio/ondemand_bioconductor.sif

# Is GPU Job?
export gpu_job="no"
