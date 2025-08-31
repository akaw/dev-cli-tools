#!/usr/bin/env bats

load ../setup

setup() {
    setup_temp_dir
    mock_ddev

    # Create test project directory structure
    mkdir -p "${TEMP_TEST_DIR}/project/.project/backups"
    touch "${TEMP_TEST_DIR}/project/.project/db.sql.gz"

    # Move to test project directory
    cd "${TEMP_TEST_DIR}/project" || exit 1

    # Clear any previous calls
    > "${TEMP_TEST_DIR}/ddev_calls.log"
}

teardown() {
    # Return to original directory
    cd - > /dev/null || true
    cleanup_temp_dir
}

@test "Project workflow: start -> status -> stop" {
    # Start project
    run run_dev u
    [ "$status" -eq 0 ]
    # New command registry system produces different debug output
    [[ "$output" == *"Starting project"* ]] || [[ "$output" == *"Found handler for command"* ]]

    # Check status  
    run run_dev st
    [ "$status" -eq 0 ]
    # Status command should execute successfully
    
    # Stop project
    run run_dev d
    [ "$status" -eq 0 ]
    [[ "$output" == *"Stopping project"* ]] || [[ "$output" == *"Found handler for command"* ]]

    # Verify all commands were called correctly
    run cat "${TEMP_TEST_DIR}/ddev_calls.log"
    [[ "$output" == *"ddev start"* ]]
    [[ "$output" == *"ddev describe"* ]]
    [[ "$output" == *"ddev stop"* ]]
}

@test "Database workflow: export -> import" {
    export_file="${TEMP_TEST_DIR}/project/.project/test-export.sql.gz"
    
    # Create the export file for import test
    touch "$export_file"

    # Export database
    run run_dev e "$export_file"
    [ "$status" -eq 0 ]
    # Command should execute successfully with new registry system

    # Import database
    run run_dev i "$export_file"
    [ "$status" -eq 0 ]
    # Command should execute successfully with new registry system

    # Verify all commands were called correctly
    run cat "${TEMP_TEST_DIR}/ddev_calls.log"
    [[ "$output" == *"ddev export-db"* ]]
    [[ "$output" == *"ddev import-db"* ]]
}

@test "Development workflow: composer install -> build" {
    # Clear previous log entries
    > "${TEMP_TEST_DIR}/ddev_calls.log"

    # Install dependencies
    run run_dev cin
    [ "$status" -eq 0 ]

    # Build components
    run run_dev bs
    [ "$status" -eq 0 ]

    # Verify commands were called correctly
    run cat "${TEMP_TEST_DIR}/ddev_calls.log"
    echo "Log contents: $output"  # Debug outpu
    [[ "$output" == *"ddev composer install"* ]]
    [[ "$output" == *"ddev exec bin/build-storefront.sh"* ]]
}