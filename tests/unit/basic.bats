#!/usr/bin/env bats

load ../setup

setup() {
    setup_temp_dir
    mock_ddev
}

teardown() {
    cleanup_temp_dir
}

@test "Version command outputs correct version" {
    run run_dev --version
    [ "$status" -eq 0 ]
    [[ "$output" == *"dev-cli-tools"* ]]
}

@test "Help command displays usage information" {
    run run_dev --help
    [ "$status" -eq 0 ]
    [[ "$output" == *"USAGE:"* ]]
    [[ "$output" == *"OPTIONS:"* ]]
    [[ "$output" == *"Examples:"* ]]
}

@test "Project start command executes ddev start" {
    # Ensure log file exists
    touch "${TEMP_TEST_DIR}/ddev_calls.log"

    run run_dev u
    echo "Status: $status"
    echo "Output: $output"
    [ "$status" -eq 0 ]

    # Check if ddev was called with correct parameters
    run cat "${TEMP_TEST_DIR}/ddev_calls.log"
    echo "Log content: $output"
    [[ "$output" == *"ddev start"* ]]
}

@test "Project stop command executes ddev stop" {
    # Ensure log file exists
    touch "${TEMP_TEST_DIR}/ddev_calls.log"

    run run_dev d
    echo "Status: $status"
    echo "Output: $output"
    [ "$status" -eq 0 ]

    # Check if ddev was called with correct parameters
    run cat "${TEMP_TEST_DIR}/ddev_calls.log"
    echo "Log content: $output"
    [[ "$output" == *"ddev stop"* ]]
}

@test "Database export command executes ddev export-db" {
    # Ensure log file exists
    touch "${TEMP_TEST_DIR}/ddev_calls.log"

    export_file="${TEMP_TEST_DIR}/test-export.sql.gz"
    run run_dev e "$export_file"
    echo "Status: $status"
    echo "Output: $output"
    [ "$status" -eq 0 ]

    # Check if ddev was called with correct parameters
    run cat "${TEMP_TEST_DIR}/ddev_calls.log"
    echo "Log content: $output"
    [[ "$output" == *"ddev export-db"* ]]
    [[ "$output" == *"$export_file"* ]]
}

@test "Composer command executes ddev composer" {
    # Ensure log file exists
    touch "${TEMP_TEST_DIR}/ddev_calls.log"

    run run_dev com update
    echo "Status: $status"
    echo "Output: $output"
    [ "$status" -eq 0 ]

    # Check if ddev was called with correct parameters
    run cat "${TEMP_TEST_DIR}/ddev_calls.log"
    echo "Log content: $output"
    [[ "$output" == *"ddev composer update"* ]]
}