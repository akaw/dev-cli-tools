# Development CLI Tools

CLI tool to simplify daily development work with DDEV, Shopware and Symfony.

[![Version](https://img.shields.io/badge/version-1.1.3-blue.svg)](https://github.com/akaw/dev-cli-tools/releases)
[![Build Status](https://github.com/akaw/dev-cli-tools/actions/workflows/test.yml/badge.svg)](https://github.com/akaw/dev-cli-tools/actions)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![Shellcheck](https://img.shields.io/badge/shellcheck-passing-brightgreen.svg)](https://www.shellcheck.net/)

## **Installation**

The tool consists of a single bash script (`src/dev`) that can be placed anywhere in your system. Here are different ways to install it:

### Option 1: Direct Download

Download just the script file and place it wherever you want, for example in your custom bin directory:

```bash
# Download script (example for ~/config/bin directory)
mkdir -p ~/config/bin
curl -o ~/config/bin/dev https://raw.githubusercontent.com/akaw/dev-cli-tools/main/src/dev
chmod +x ~/config/bin/dev

# Add to PATH if needed (add to .zshrc, .bashrc, etc.)
export PATH="$HOME/config/bin:$PATH"
```

### Option 2: Manual Copy

If you've cloned the repository, you can simply copy the script to your preferred location:

```bash
# Copy script (example for ~/config/bin directory)
mkdir -p ~/config/bin
cp src/dev ~/config/bin/
chmod +x ~/config/bin/dev

# Add to PATH if needed (add to .zshrc, .bashrc, etc.)
export PATH="$HOME/config/bin:$PATH"
```

The script is self-contained and can be placed in any location of your choice. Just make sure the location is in your PATH.

## Requirements

- DDEV
- Docker or OrbStack
- PHP 8.2+
- Node.js 20+

## Main Features

- Project management (start, stop, restart)
- Database operations (import, export)
- Development tools (xdebug, logs, tests)
- Composer management
- Shopware specific commands

## Command Shortcuts

### Project Management
- `dev u` - Start project (up)
- `dev d` - Stop project (down)
- `dev r` - Restart project
- `dev st` - Show status
- `dev o` - Open in browser

### Database
- `dev e` - Export database
- `dev i` - Import database
- `dev sq` - Open Sequel Ace
- `dev mi` - Run migrations

### Development
- `dev x` - Toggle xdebug
- `dev t` - Run tests
- `dev l` - Show logs
- `dev ma` - Mail server

### Composer
- `dev c` - Composer command
- `dev cu` - Update dependencies
- `dev ci` - Install dependencies
- `dev cr` - Add package (require)
- `dev crm` - Remove package
- `dev ca` - Dump autoloader

### Shopware
- `dev b` - Build components
- `dev w` - Watch components
- `dev cc` - Clear cache
- `dev p` - Plugin commands:
  - `dev pr` - Refresh plugins
  - `dev pl` - List plugins
  - `dev pa` - Activate plugin
  - `dev pd` - Deactivate plugin

### Project
- `dev n` - New project
- `dev bk` - Backup
- `dev rs` - Restore

## Examples

```bash
# Start project
dev u

# Import database
dev i

# Install dependencies
dev i

# Build Shopware
dev b s
```

## Development

Contributions are welcome! Please note:

1. Fork the repository
2. Create feature branch
3. Commit changes
4. Create pull request

### Development Setup Tip

```bash
# Install shellcheck (macOS)
brew install shellcheck

# Configure git hooks
git config core.hooksPath .githooks
```

## License

This project is licensed under the MIT License.

```text
MIT License

Copyright (c) 2024 Andre Witte

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
```

## Author

Andre Witte
