# Changelog

All notable changes to the Development CLI Tools will be documented in this file.

## [1.3.2] - 2024-05-24

### Added
- Added GitHub Actions workflow for automated code quality checks
- Added comprehensive TESTING.md documentation for testing strategy
- Implemented ShellCheck, syntax check, and formatting verification in CI
- Added Git Hooks for pre-commit and pre-push to enforce tests locally
- Implemented automated version consistency checks in Git Hooks

### Changed
- Improved testing approach with separate CI quality checks and local functional tests
- Enhanced developer workflow with automatic checks before commits and pushes

## [1.3.1] - 2024-05-24

### Fixed
- Fixed build commands (bs/build:storefront, ba/build:administration, etc.) still causing unnecessary container restarts
- Updated all command handlers to use the new optimized container check function
- Consistently implemented container detection across all tool commands
- Fixed shellcheck warnings related to masking return values and quoting
- Fixed automated tests by properly handling test mode in container check function

### Changed
- Refactored duplicate container check code in all command handlers
- Improved debug output for container status detection
- Consolidated container verification logic to use a single approach throughout the codebase

## [1.3.0] - 2024-05-23

### Added
- Implemented a robust multi-layered container status detection system
- Added support for JSON-based status checks with ddev describe --json-output
- Incorporated fallback mechanisms for more reliable status detection

### Fixed
- Resolved persistent container detection issues with a more reliable approach
- Fixed empty status issue with ddev describe command
- Improved reliability of container status detection across different environments

## [1.2.9] - 2024-05-23

### Fixed
- Fixed critical issue with DDEV status detection parsing
- Replaced `ddev list` with `ddev describe` for more reliable project status checking
- Added support for all variants of "running" status in DDEV (OK, Running, running)

## [1.2.8] - 2024-05-23

### Fixed
- Fixed critical issue with container detection that was still causing unnecessary restarts
- Replaced `docker ps` with `ddev list` for more reliable container status checking
- Corrected function return value handling for helper functions

### Changed
- Added enhanced debugging output to troubleshoot container status
- Improved error messaging for container startup issues

## [1.2.7] - 2024-05-23

### Fixed
- Improved container restart prevention logic for all DDEV commands, not just cache:clear
- Refactored container state checking to use direct Docker container checks
- Consolidated all project checks to follow the same pattern

### Changed
- Created centralized `check_and_ensure_running_container` function to handle all container checks consistently
- Enhanced debugging output to focus on container runtime state
- Updated error messages to be more specific about container status
- Removed redundant check_ddev_project() function calls in favor of direct Docker container inspection

## [1.2.6] - 2024-05-22

### Fixed
- Fixed container restart issue when running cache:clear command
- Improved DDEV project checking to completely bypass ensure_ddev_project when container is already running
- Added detailed debugging information to troubleshoot container status

## [1.2.5] - 2024-05-22

### Added
- Automatic version check on every run to notify about available updates
- Daily cache to avoid frequent update checks
- Improved upgrade process with clearer user feedback

### Changed
- Enhanced upgrade command to first check if an update is necessary
- Better error handling during the upgrade process

## [1.2.4] - 2024-05-22

### Fixed
- Fixed container auto-restart issue when running commands in a project that is already running
- Fixed syntax errors in shell expressions that caused problems in some environments
- Fixed unreliable container status detection with a more robust implementation
- Fixed handling of directories with DDEV projects in subdirectories

### Changed
- Improved error messages when no DDEV project is found in current directory
- Removed unnecessary auto-start configuration in favor of simpler, more predictable behavior
- Enhanced Docker/DDEV environment checks to be more reliable and fail gracefully
- Simplified project detection logic using direct filesystem checks

### Improved
- Resolved inconsistencies between README and CHANGELOG
- Updated "Future Plans" to reflect current implementation status

## [1.2.3] - 2024-05-22

### Added
- Added configuration for project auto-start behavior
- Added `--no-autostart` flag to disable automatic project start
- Added setup wizard option to configure auto-start preference

### Changed
- Project auto-start is now configurable and can be disabled
- Updated help documentation with new options

## [1.2.2] - 2024-05-21

### Fixed
- Fixed setup wizard appearing unexpectedly during automated testing
- Added test mode to ensure CI compatibility
- Improved command execution order to prioritize version/help commands
- Fixed shellcheck warnings in configuration tools

## [1.2.1] - 2024-05-21

### Added
- Added configuration system with setup wizard and user preferences
- Added project auto-detection and startup for all DDEV commands
- Added PREFERRED_EDITOR setting to customize editor choice

### Changed
- Improved Docker/OrbStack detection with status-based caching
- Enhanced project auto-start behavior for all operations
- Changed --no-deprecations to use environment variables instead of command flags
- Reduced unnecessary Docker checks with intelligent status tracking

### Fixed
- Fixed critical issue with OrbStack detection not reliably starting containers
- Fixed problem with commands failing when DDEV project wasn't started
- Fixed invalid --no-deprecations flag usage with Symfony Console

## [1.2.0] - 2024-05-21

### Added
- Added default `--no-deprecations` flag for all Shopware console commands
- Improved OrbStack/Docker detection and initialization

### Changed
- Enhanced Docker service detection to verify operational status not just process existence
- Added additional waiting time for Docker/OrbStack to fully stabilize
- Improved error handling for service startup failures
- Better error messages when services appear to be running but aren't fully initialized

### Fixed
- Fixed critical issue with OrbStack detection not checking for actual Docker operability

## [1.1.9] - 2024-05-20

### Added
- Added `--no-deprecations` flag to suppress deprecation warnings in Shopware console commands
- Added `-vv` / `--verbose` flag for verbose output in console commands

### Changed
- Improved console command execution with flexible flag support
- Updated documentation with new command-line options

## [1.1.8] - 2025-05-16

### Fixed
- Critical bug: Docker environment (OrbStack/Docker) wasn't automatically started when running specific commands
- The `start_docker_environment` function is now called before any DDEV operations
- Added a delay after starting Docker/OrbStack to ensure it's fully initialized

## [1.1.7] - 2025-05-16

### Added
- Comprehensive test suite using Bats testing framework
- Unit tests for core functionality
- Integration tests for workflows
- Test mocks for DDEV commands
- GitHub Actions workflow updates for automated testing

### Changed
- Updated README with testing information
- Added test documentation

## [1.1.6] - 2025-05-15

### Added
- Restored all command shortcuts from v1.0.0
- Added more detailed build commands (ba, bs, bj)
- Added watch commands for specific components (wa, ws)
- Added extended plugin management commands (plin, plun, plup)
- Added database migration command with --all option
- Added debug router command (dr, debug:router)
- Added messenger consume command (mc, messenger:consume)

### Changed
- Improved command parsing with enhanced debug output
- Enhanced error handling in execute_commands
- Simplified package management process
- Updated usage information to show command variants

### Fixed
- Fixed shellcheck warning in backup file creation
- Fixed command conflict between ssh and start commands
- Improved parameter handling in parse_params

## [1.1.5] - 2025-05-14

### Added
- Enhanced project creation with automatic configuration
- Added support for Symfony 6.4 projects
- Added standardized project structure creation
- Added automatic build tool setup for both Symfony and Shopware
- Added automatic update check on script start
- Added `check-update` command for manual update checks

### Changed
- Switched project language to English
- Improved error messages and documentation
- Added language note to README.md
- Moved German documentation to READMEDE.md
- Enhanced project initialization process
- Improved Docker environment detection
- Added better error handling for service startup

### Fixed
- Fixed project creation in empty directories
- Improved error messages for missing dependencies
- Fixed build script permissions

## [1.1.4] - 2025-05-14

### Changed
- Removed `config.env` file in favor of environment variables
- Simplified configuration management
- Enhanced environment variable handling
- Improved code maintainability

## [1.1.3] - 2025-05-14

### Added
- Enhanced logging system with color-coded output for different log levels
- Added specific logging functions for debug, info, warn, and error levels
- Improved timestamp formatting in log messages
- Added file logging with proper formatting

## [1.1.2] - 2025-05-14

### Changed
- Improved project structure: Moved main script to `src/` directory
- Integrated configuration directly into main script
- Removed separate configuration files (config.env and VERSION)
- Simplified installation with self-contained script
- Enhanced documentation with flexible installation options

## [1.1.1] - 2025-05-14

### Changed
- Improved documentation of command shortcuts in README files
- Enhanced command reference for single-letter commands
- Better organization of command groups in documentation

## [1.1.0] - 2025-05-13

### Added
- Enhanced logging system with colored output and timestamps
- Improved error handling and shellcheck compliance
- Added pre-commit hook for shell script validation
- Improved documentation with German translation (READMEDE.md)

### Changed
- Refactored code structure for better maintainability
- Enhanced Docker environment detection and startup
- Improved variable handling and quoting
- Updated build process for Shopware components

### Fixed
- Fixed various shellcheck warnings
- Improved error messages and logging
- Fixed file path handling in various commands

## [1.0.0] - 2024-01-14

### Initial Release

- Basic project structure
- Core functionality for DDEV commands
- Support for Shopware and Symfony projects
- Database management features
- Development tools integration

### Added Features

- Project management (up, down, restart)
- Database operations (import, export)
- Composer command shortcuts
- Shopware specific commands
- Development tools (xdebug, logs)
- Configuration system
- Logging system
- Color output support

### Technical Details

- Bash script architecture
- Modular command structure
- Configuration via config.env
- Logging with different levels
- Support for macOS and Linux
- OrbStack and Docker Desktop support

### Development Process

1. Initial Proof of Concept
   - Basic shell script for common DDEV commands
   - Minimal functionality testing
   - Core command structure

2. AI-Assisted Development
   - Iterative improvements using GitHub Copilot
   - Code structure optimization
   - Command pattern refinement
   - Error handling enhancement

3. Feature Expansion
   - Integration of additional tools
   - Enhanced logging system
   - Configuration management
   - Documentation improvements

4. Refinement Iterations
   - Code quality improvements
   - Command organization
   - User experience optimization
   - Performance tuning

5. Testing and Documentation
   - Usage examples
   - Error scenarios
   - Installation guide
   - Contributing guidelines

Each iteration was guided by AI assistance while maintaining focus on:
- Code quality
- User experience
- Maintainability
- Documentation
- Error handling

## Future Plans

- [x] Test coverage
- [ ] More Symfony specific commands
- [x] Enhanced error handling
- [ ] Project templates
