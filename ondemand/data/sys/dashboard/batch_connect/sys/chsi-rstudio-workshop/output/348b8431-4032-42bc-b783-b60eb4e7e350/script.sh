#!/usr/bin/env bash

#Command Tracing
set -x

# Benchmark info
echo "TIMING - Starting main script at: $(date)"

# Clean up the modules in working environment
module purge

# Detect and Setup Cuda Devices
if [ -n "$CUDA_VISIBLE_DEVICES" ]; then
	export SINGULARITYENV_CUDA_VISIBLE_DEVICES="$CUDA_VISIBLE_DEVICES"
fi

# Ensure We have a TMPDIR
if [ -z "$TMPDIR" ] || [ "$TMPDIR" == "/tmp" ]; then
	TMPDIR="$(mktemp -d)"
	export TMPDIR
fi

# Create Config File
cat <<-EOF >./rserver.conf
	server-user=$USER
	www-port=${port}
	auth-none=0
	auth-pam-helper-path=${PWD}/bin/auth
	auth-encrypt-password=0
	auth-timeout-minutes=0
	server-app-armor-enabled=0
EOF

# Create Session Config File
cat <<-EOF >./rsession.conf
	session-timeout-minutes=0
	session-save-action-default=no
EOF

# Create Log Config File (debug, info, warn, error)
cat <<-EOF >./logging.conf
	[*]
	log-level=info
	logger-type=file
	log-dir=$PWD/sessions
EOF

# Generate R Environment Site File
echo "Generate Modified R Environment Site File"
singularity -vvv exec --bind="$TMPDIR:/tmp" "$RSTUDIO_SERVER_IMAGE" bash ./genenv.sh
renv_path="$(cat ./Renviron.path)"

# Create RStudio Writable Directories and Helper Files
mkdir -p "$TMPDIR/rstudio-server/var/lib"
mkdir -p "$TMPDIR/rstudio-server/var/run"
uuidgen >"$TMPDIR/rstudio-server/secure-cookie-key"
chmod 600 "$TMPDIR/rstudio-server/secure-cookie-key"

# Setup Bind Mounts
BPath="$TMPDIR:/tmp"
BPath+=",$TMPDIR/rstudio-server/var/lib:/var/lib/rstudio-server"
BPath+=",$TMPDIR/rstudio-server/var/run:/var/run/rstudio-server"
BPath+=",logging.conf:/etc/rstudio/logging.conf"
BPath+=",rsession.conf:/etc/rstudio/rsession.conf"
BPath+=",rserver.conf:/etc/rstudio/rserver.conf"
BPath+=",Renviron.site:$renv_path"
BPath+=",sessions:${HOME}/.local/share/rstudio/sessions"
BPath+=",${GROUPDIR}:${GROUPDIR}"
BPath+=",/work:/work"
echo "$BPath"

# Launch the RStudio Server
echo "TIMING - Starting RStudio Server at: $(date)"
if [ "$gpu_job" == "no" ]; then
	singularity -vvv exec --bind="$BPath" "$RSTUDIO_SERVER_IMAGE" rserver
else
	singularity -vvv exec --nv --bind="$BPath" "$RSTUDIO_SERVER_IMAGE" rserver
fi
