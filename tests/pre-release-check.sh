#!/usr/bin/env bash

# Pre-Release Version Consistency Check
# This script checks that all version numbers are consistent across all relevant files
# Author: Andre Witte

set -e

# Colors for outpu
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Test counters
TESTS_PASSED=0
TESTS_FAILED=0
WARNINGS=0

# Helper functions
print_header() {
    echo -e "\n${BLUE}=== $1 ===${NC}"
}

print_success() {
    echo -e "${GREEN}✓${NC} $1"
    ((TESTS_PASSED++))
}

print_error() {
    echo -e "${RED}✗${NC} $1"
    ((TESTS_FAILED++))
}

print_warning() {
    echo -e "${YELLOW}⚠${NC} $1"
    ((WARNINGS++))
}

print_info() {
    echo -e "${BLUE}ℹ${NC} $1"
}

# Get version from main scrip
get_main_version() {
    grep '^VERSION=' src/dev | cut -d'"' -f2
}

# Check if file exists
check_file_exists() {
    local file="$1"
    if [[ ! -f "$file" ]]; then
        print_error "File not found: $file"
        return 1
    fi
    return 0
}

# Check version in specific file with pattern
check_version_in_file() {
    local file="$1"
    local pattern="$2"
    local expected_version="$3"
    local description="$4"

    if ! check_file_exists "$file"; then
        return 0  # Don't fail the whole script if file doesn't exis
    fi

    local found_version=""
    if found_version=$(grep -E "$pattern" "$file" | head -n1 | grep -oE '[0-9]+\.[0-9]+\.[0-9]+' || echo ""); then
        if [[ "$found_version" == "$expected_version" ]]; then
            print_success "$description: $found_version"
        elif [[ -n "$found_version" ]]; then
            print_error "$description: Expected $expected_version, found $found_version"
        else
            print_error "$description: Version not found in $file"
        fi
    else
        print_error "$description: Version not found in $file"
    fi
}

# Check changelog has entry for version
check_changelog_entry() {
    local version="$1"
    local changelog_file="CHANGELOG.md"

    if ! check_file_exists "$changelog_file"; then
        return 0
    fi

    if grep -q "## \[$version\]" "$changelog_file"; then
        print_success "Changelog entry exists for version $version"
    else
        print_error "Changelog entry missing for version $version"
    fi

    # Check if it's the first entry (most recent)
    local first_version=""
    first_version=$(grep -E "^## \[[0-9]+\.[0-9]+\.[0-9]+\]" "$changelog_file" | head -n1 | grep -oE '[0-9]+\.[0-9]+\.[0-9]+' || echo "")
    if [[ -n "$first_version" ]]; then
        if [[ "$first_version" == "$version" ]]; then
            print_success "Version $version is the latest entry in changelog"
        else
            print_warning "Version $version is not the latest entry in changelog (latest: $first_version)"
        fi
    fi
}

# Check if version follows semantic versioning
check_semantic_versioning() {
    local version="$1"

    if [[ $version =~ ^[0-9]+\.[0-9]+\.[0-9]+$ ]]; then
        print_success "Version follows semantic versioning: $version"
    else
        print_error "Version does not follow semantic versioning: $version"
    fi
}

# Check git tag consistency
check_git_tags() {
    local version="$1"

    # Check if tag already exists
    if git tag -l | grep -q "^v$version$"; then
        print_warning "Git tag v$version already exists"
    else
        print_info "Git tag v$version does not exist yet (will be created during release)"
    fi

    # Check if we're on a clean git state
    if [[ -n "$(git status --porcelain)" ]]; then
        print_warning "Git working directory is not clean"
    else
        print_success "Git working directory is clean"
    fi
}

# Check that documentation files exis
check_documentation_files() {
    local required_files=("README.md" "CHANGELOG.md" "CONTRIBUTING.md" "LICENSE")

    for file in "${required_files[@]}"; do
        if [[ -f "$file" ]]; then
            print_success "Documentation file exists: $file"
        else
            print_error "Documentation file missing: $file"
        fi
    done
}

# Main execution
main() {
    print_header "Pre-Release Version Consistency Check"

    # Get the main version from the scrip
    local main_version=""
    main_version=$(get_main_version)

    if [[ -z "$main_version" ]]; then
        print_error "Could not determine version from src/dev"
        exit 1
    fi

    print_info "Checking consistency for version: $main_version"

    print_header "Version Format Validation"
    check_semantic_versioning "$main_version"

    print_header "Core Script Version Checks"
    # Check both version declarations in the main scrip
    check_version_in_file "src/dev" "^# Version:" "$main_version" "Script header version"
    check_version_in_file "src/dev" '^VERSION=' "$main_version" "Script VERSION variable"

    print_header "Documentation Version Checks"
    check_version_in_file "README.md" "version-[0-9]+\.[0-9]+\.[0-9]+" "$main_version" "README.md version badge"

    print_header "Changelog Validation"
    check_changelog_entry "$main_version"

    print_header "Documentation Files"
    check_documentation_files

    print_header "Git Repository State"
    check_git_tags "$main_version"

    print_header "Release Readiness Summary"
    echo -e "\n${BLUE}Test Results:${NC}"
    echo -e "  ${GREEN}Passed: $TESTS_PASSED${NC}"
    echo -e "  ${RED}Failed: $TESTS_FAILED${NC}"
    echo -e "  ${YELLOW}Warnings: $WARNINGS${NC}"

    if [[ $TESTS_FAILED -eq 0 ]]; then
        echo -e "\n${GREEN}✓ Release check PASSED - Ready for release!${NC}"
        if [[ $WARNINGS -gt 0 ]]; then
            echo -e "${YELLOW}⚠ Please review warnings before proceeding${NC}"
        fi
        exit 0
    else
        echo -e "\n${RED}✗ Release check FAILED - Please fix issues before release${NC}"

        echo -e "\n${BLUE}Required Actions:${NC}"
        if grep -q "README.md version badge" <<< "$(cat /tmp/release_errors 2>/dev/null || echo "")"; then
            echo -e "  - Update README.md version badge to $main_version"
        fi
        if grep -q "Changelog entry missing" <<< "$(cat /tmp/release_errors 2>/dev/null || echo "")"; then
            echo -e "  - Add changelog entry for version $main_version"
        fi

        exit 1
    fi
}

# Run the checks
main "$@"