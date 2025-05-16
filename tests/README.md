# Testing Framework for dev-cli-tools

This directory contains test files for the dev-cli-tools using the [Bats](https://github.com/bats-core/bats-core) testing framework.

## Structure

- `setup.bash`: Common setup code for all tests
- `mocks/`: Mock commands used during testing
- `unit/`: Unit tests for individual functions
- `integration/`: Integration tests for workflows

## Running Tests

To run all tests:

```bash
bats tests/unit tests/integration
```

To run a specific test file:

```bash
bats tests/unit/basic.bats
```

## Requirements

To run these tests locally, you need:

1. [Bats](https://github.com/bats-core/bats-core) - Bash Automated Testing System

   ```bash
   # Installation on macOS
   brew install bats-core
   
   # Installation on Linux
   git clone https://github.com/bats-core/bats-core.git
   cd bats-core
   ./install.sh /usr/local
   ```

## Writing Tests

Each test file should:

1. Load the setup file: `load ../setup`
2. Use the `setup()` and `teardown()` functions
3. Include test cases with `@test` annotations

Example:

```bash
#!/usr/bin/env bats

load ../setup

setup() {
    setup_temp_dir
    mock_ddev
}

teardown() {
    cleanup_temp_dir
}

@test "My test description" {
    run run_dev command arg
    [ "$status" -eq 0 ]
    [[ "$output" == *"expected output"* ]]
}
```

## Mock Commands

The `mocks/` directory contains mock versions of external commands used by the script.
These mocks allow testing without installing actual dependencies like DDEV.

To create a new mock:

1. Add a script to `mocks/`
2. Make it executable: `chmod +x mocks/command-name`
3. Implement appropriate responses for test cases 