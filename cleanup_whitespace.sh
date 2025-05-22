#!/usr/bin/env bash

# Cleanup script to remove trailing whitespace from all text files in the repository
# Author: Andre Witte
# Date: 2024-05-29

# Colors for outpu
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
NC='\033[0m' # No Color

echo -e "${YELLOW}Cleaning up trailing whitespace in all repository files...${NC}"

# Counter for statistics
files_checked=0
files_modified=0

# Get all tracked files in the repository
for file in $(git ls-files); do
    # Skip binary files, only process text files
    if [[ -f "$file" ]] && [[ "$(file -b --mime "$file" | cut -d ';' -f1)" == "text/"* ]]; then
        ((files_checked++))

        # Check if file has trailing whitespace
        if grep -q -E '[ \t]+$' "$file"; then
            echo -e "${YELLOW}Cleaning:${NC} $file"

            # Backup the file
            cp "$file" "${file}.bak"

            # Remove trailing whitespace
            sed -i '' 's/[ \t]*$//' "$file"

            # Verify changes
            if ! grep -q -E '[ \t]+$' "$file"; then
                echo -e "  ${GREEN}✓ Successfully cleaned${NC}"
                ((files_modified++))
                rm -f "${file}.bak"
            else
                echo -e "  ${RED}× Failed to clean, restoring backup${NC}"
                mv "${file}.bak" "$file"
            fi
        fi
    fi
done

echo
echo -e "${GREEN}Cleanup completed:${NC}"
echo "Files checked: $files_checked"
echo "Files modified: $files_modified"

if [ "$files_modified" -gt 0 ]; then
    echo
    echo -e "${YELLOW}Don't forget to commit the changes!${NC}"
    echo "git add -u"
    echo "git commit -m 'Remove trailing whitespace from all files'"
fi

exit 0