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
    run run_dev u
    [ "$status" -eq 0 ]
    
    # Check if ddev was called with correct parameters
    run cat "${TEMP_TEST_DIR}/ddev_calls.log"
    [[ "$output" == *"ddev start"* ]]
}

@test "Project stop command executes ddev stop" {
    run run_dev d
    [ "$status" -eq 0 ]
    
    # Check if ddev was called with correct parameters
    run cat "${TEMP_TEST_DIR}/ddev_calls.log"
    [[ "$output" == *"ddev stop"* ]]
}

@test "Database export command executes ddev export-db" {
    export_file="${TEMP_TEST_DIR}/test-export.sql.gz"
    run run_dev e "$export_file"
    [ "$status" -eq 0 ]
    
    # Check if ddev was called with correct parameters
    run cat "${TEMP_TEST_DIR}/ddev_calls.log"
    [[ "$output" == *"ddev export-db"* ]]
    [[ "$output" == *"$export_file"* ]]
}

@test "Composer command executes ddev composer" {
    run run_dev com update
    [ "$status" -eq 0 ]
    
    # Check if ddev was called with correct parameters
    run cat "${TEMP_TEST_DIR}/ddev_calls.log"
    [[ "$output" == *"ddev composer update"* ]]
} 