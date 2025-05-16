#!/usr/bin/env bash

# Get the directory where this setup script is located
TEST_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# Path to the main dev script
export DEV_SCRIPT="${TEST_DIR}/../src/dev"

# Ensure the script is executable
chmod +x "${DEV_SCRIPT}"

# Create a temporary directory for test files
setup_temp_dir() {
    TEMP_TEST_DIR=$(mktemp -d)
    export TEMP_TEST_DIR
    echo "Created temp directory: $TEMP_TEST_DIR"
}

# Clean up the temporary directory
cleanup_temp_dir() {
    if [[ -d "$TEMP_TEST_DIR" ]]; then
        rm -rf "$TEMP_TEST_DIR"
        echo "Removed temp directory: $TEMP_TEST_DIR"
    fi
}

# Mock ddev command for testing without actual ddev installation
mock_ddev() {
    PATH="${TEST_DIR}/mocks:$PATH"
    export PATH
}

# Helper to run the dev script with specific parameters
run_dev() {
    "${DEV_SCRIPT}" "$@"
} 