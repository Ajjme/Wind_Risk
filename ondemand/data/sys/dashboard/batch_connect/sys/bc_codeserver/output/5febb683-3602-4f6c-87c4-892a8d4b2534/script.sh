#!/usr/bin/bash -l


CODE_SERVER_DATAROOT="$HOME/.local/share/code-server"
mkdir -p "$CODE_SERVER_DATAROOT/extensions"

# Expose the password to the server.
export PASSWORD="$password"

# Print compute node.
echo "$(date): Running on compute node ${compute_node}:$port"

# VSCode complains that system git is too old.
#module load project/ondemand git app_code_server/4.90.2
module load code-server/4.90.2

CPP_FILE="/hpc/home/ajj54/.vscode/c_cpp_properties.json"

if [[ -f "$CPP_FILE" ]]; then
    CPP_DIR="${TMPDIR:=/tmp/$USER}/cpp-vscode"
    mkdir -p "$CPP_DIR"
    chmod 700 "$CPP_DIR"

    # if the file is empty, let's initialize it
    [ -s "$CPP_FILE" ] || echo '{"configurations": [{ "name": "Linux", "browse": { "databaseFilename": null }}], "version": 4}' > "$CPP_FILE"

    jq --arg dbfile "$CPP_DIR/cpp-vscode.db" \
      '.configurations[0].browse.databaseFilename = $dbfile' \
      "$CPP_FILE" > "$CPP_FILE".new

    mv "$CPP_FILE".new "$CPP_FILE"
  fi

#
# Start Code Server.
#
echo "$(date): Started code-server"
echo ""

code-server \
    --auth="none" \
    --bind-addr="0.0.0.0:${port}" \
    --disable-telemetry \
    --extensions-dir="$CODE_SERVER_DATAROOT/extensions" \
    --user-data-dir="$CODE_SERVER_DATAROOT" \
    --log debug \
    "/hpc/home/ajj54"
