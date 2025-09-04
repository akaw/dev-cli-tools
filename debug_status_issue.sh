#!/bin/bash

# Debug script for DDEV status detection issues
# Usage: Run this in a DDEV project directory where you experience the issue

echo "=== DDEV Status Detection Debug Tool ==="
echo "Version: 1.6.2"
echo "Date: $(date)"
echo ""

# Check if we are in a DDEV project
if [ ! -f .ddev/config.yaml ]; then
    echo "❌ ERROR: No DDEV project found in current directory"
    echo "Please run this script from within a DDEV project directory"
    exit 1
fi

echo "✅ Found DDEV project configuration"
project_name=$(grep "^name:" .ddev/config.yaml | cut -d: -f2 | tr -d " " | tr -d '"')
echo "📋 Project name: '$project_name'"
echo ""

# Test 1: Docker Container Check
echo "=== Test 1: Docker Container Status ==="
container_name="ddev-${project_name}-web"
echo "🔍 Checking container: $container_name"

if docker container inspect "$container_name" --format '{{.State.Status}}' 2>/dev/null >/dev/null; then
    status=$(docker container inspect "$container_name" --format '{{.State.Status}}' 2>/dev/null)
    echo "📊 Container status: '$status'"
    
    if echo "$status" | grep -q "running"; then
        echo "✅ Docker reports container as RUNNING"
        docker_running=true
    else
        echo "❌ Docker reports container as NOT RUNNING"
        docker_running=false
    fi
    
    # Additional container info
    echo "📋 Container details:"
    docker container inspect "$container_name" --format '{{.State.Status}} ({{.State.Health.Status}})' 2>/dev/null || echo "  No health status available"
else
    echo "❌ Container not found or docker command failed"
    docker_running=false
fi
echo ""

# Test 2: DDEV JSON API Check
echo "=== Test 2: DDEV JSON API Status ==="
echo "🔍 Running: ddev describe --json-output"

if json_output=$(timeout 10 ddev describe --json-output 2>/dev/null); then
    echo "✅ DDEV JSON output received"
    
    if command -v jq >/dev/null 2>&1; then
        echo "🔧 Using jq for JSON parsing"
        status=$(echo "$json_output" | jq -r '.[0].status' 2>/dev/null)
        echo "📊 Status via jq: '$status'"
        
        if [[ "$status" =~ ^[Rr]unning$ ]]; then
            echo "✅ DDEV JSON API reports project as RUNNING"
            ddev_json_running=true
        else
            echo "❌ DDEV JSON API reports project as NOT RUNNING"
            ddev_json_running=false
        fi
    else
        echo "🔧 Using grep for JSON parsing (jq not available)"
        if echo "$json_output" | grep -q '"status":"[Rr]unning"'; then
            echo "✅ DDEV JSON API reports project as RUNNING (via grep)"
            ddev_json_running=true
        else
            echo "❌ DDEV JSON API reports project as NOT RUNNING (via grep)"
            ddev_json_running=false
        fi
    fi
    
    echo "📋 Raw JSON output (first 200 chars):"
    echo "$json_output" | head -c 200
    echo "..."
else
    echo "❌ Failed to get DDEV JSON output (timeout or error)"
    ddev_json_running=false
fi
echo ""

# Test 3: DDEV Status Command
echo "=== Test 3: DDEV Status Command ==="
echo "🔍 Running: ddev status"

if ddev_status_output=$(timeout 10 ddev status 2>&1); then
    echo "✅ DDEV status command succeeded"
    
    if echo "$ddev_status_output" | grep -q "OK"; then
        echo "✅ DDEV status shows OK"
        ddev_status_running=true
    else
        echo "❌ DDEV status does not show OK"
        ddev_status_running=false
    fi
    
    echo "📋 DDEV status output:"
    echo "$ddev_status_output"
else
    echo "❌ DDEV status command failed or timed out"
    ddev_status_running=false
fi
echo ""

# Test 4: Summary and Analysis
echo "=== Test 4: Summary & Analysis ==="
echo "📊 Results Summary:"
echo "   Docker Container:  $([ "$docker_running" = true ] && echo "✅ RUNNING" || echo "❌ NOT RUNNING")"
echo "   DDEV JSON API:     $([ "$ddev_json_running" = true ] && echo "✅ RUNNING" || echo "❌ NOT RUNNING")"
echo "   DDEV Status Cmd:   $([ "$ddev_status_running" = true ] && echo "✅ RUNNING" || echo "❌ NOT RUNNING")"
echo ""

# Analysis
if [ "$docker_running" = true ] && [ "$ddev_json_running" = true ] && [ "$ddev_status_running" = true ]; then
    echo "🎉 ANALYSIS: All checks report project as RUNNING"
    echo "   If you still get 'Project is not running' messages, this might be a cache issue."
    echo "   Try: Clear cache manually or restart the dev script."
    
elif [ "$docker_running" = true ] && [ "$ddev_json_running" = false ]; then
    echo "⚠️  ANALYSIS: Docker container is running but DDEV JSON API reports not running"
    echo "   This is the likely cause of your issue!"
    echo "   Possible causes:"
    echo "   - DDEV internal state inconsistency"
    echo "   - Container started outside of DDEV"
    echo "   - DDEV configuration issues"
    echo "   Try: ddev restart"
    
elif [ "$docker_running" = false ] && [ "$ddev_json_running" = true ]; then
    echo "⚠️  ANALYSIS: DDEV reports running but Docker container is not running"
    echo "   This indicates a DDEV state inconsistency"
    echo "   Try: ddev restart"
    
else
    echo "ℹ️  ANALYSIS: Project appears to be genuinely not running"
    echo "   The 'Project is not running - starting now' message is correct."
fi

echo ""
echo "=== Recommendations ==="
if [ "$docker_running" != "$ddev_json_running" ]; then
    echo "🔧 Status mismatch detected. Recommended actions:"
    echo "   1. Run: ddev restart"
    echo "   2. Clear dev script cache (if applicable)"
    echo "   3. Check for multiple DDEV projects with same name"
else
    echo "✅ Status checks are consistent"
    echo "   If you still experience issues, please share this debug output"
fi

echo ""
echo "=== Debug Complete ==="
echo "Please share this output when reporting the issue."
