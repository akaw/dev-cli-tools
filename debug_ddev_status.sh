#!/bin/bash

# Test DDEV status detection
echo "=== DDEV Status Debug Test ==="

# Check if we are in a DDEV project
if [ -f .ddev/config.yaml ]; then
    echo "✓ Found DDEV project"
    project_name=$(grep "^name:" .ddev/config.yaml | cut -d: -f2 | tr -d " ")
    echo "Project name: $project_name"
else
    echo "✗ No DDEV project found in current directory"
    exit 1
fi

echo ""
echo "=== Docker Container Check ==="
container_name="ddev-${project_name}-web"
echo "Checking container: $container_name"

if docker container inspect "$container_name" --format "{{.State.Status}}" 2>/dev/null; then
    status=$(docker container inspect "$container_name" --format "{{.State.Status}}" 2>/dev/null)
    echo "Container status: $status"
    if echo "$status" | grep -q "running"; then
        echo "✓ Docker reports container as running"
    else
        echo "✗ Docker reports container as NOT running"
    fi
else
    echo "✗ Container not found or docker command failed"
fi

echo ""
echo "=== DDEV JSON API Check ==="
echo "Running: ddev describe --json-output"
if json_output=$(timeout 5 ddev describe --json-output 2>/dev/null); then
    echo "✓ DDEV JSON output received"
    echo "JSON output:"
    echo "$json_output" | head -5
    
    if command -v jq >/dev/null 2>&1; then
        status=$(echo "$json_output" | jq -r ".[0].status" 2>/dev/null)
        echo "Status via jq: $status"
        if [[ "$status" =~ ^[Rr]unning$ ]]; then
            echo "✓ DDEV reports project as running (via jq)"
        else
            echo "✗ DDEV reports project as NOT running (via jq)"
        fi
    else
        echo "jq not available, using grep"
        if echo "$json_output" | grep -q "\"status\":\"[Rr]unning\""; then
            echo "✓ DDEV reports project as running (via grep)"
        else
            echo "✗ DDEV reports project as NOT running (via grep)"
        fi
    fi
else
    echo "✗ Failed to get DDEV JSON output"
fi

echo ""
echo "=== DDEV Status Command Check ==="
echo "Running: ddev status"
ddev status

