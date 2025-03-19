# dev-cli-tools

## Overview

`dev-cli-tools` is a Bash script that provides shortcuts for commonly used commands from ddev, Shopware, and other tools. It simplifies project management and development through easy commands.

## Installation

1. Download the script:
    ```bash
    curl -o ~/.bin https://raw.githubusercontent.com/akaw/dev-cli-tools/refs/heads/main/dev
    ```

2. Make the script executable:
    ```bash
    chmod +x ~/.bin
    ```

## Usage

The script offers a variety of commands and options. Here are some examples:

### General ddev Commands

- Start the project:
    ```bash
    ddev start
    dev up 
    dev u
    ```

- Stop the project:
    ```bash
    dev down
    dev d
    ```

- Open the project in the browser:
    ```bash
    dev open
    dev o
    ```

- Show logs:
    ```bash
    dev logs
    dev l
    ```

### Composer Commands

- Install dependencies:
    ```bash
    ddev composer install
    dev composer install
    dev c install
    dev cin
    ```

- Update dependencies:
    ```bash
    ddev composer update
    dev composer update
    dev c update
    dev cup
    ```

- Add a package:
    ```bash
    ddev composer require symfony/webpack-encore-bundle
    dev composer require symfony/webpack-encore-bundle
    dev c require symfony/webpack-encore-bundle
    dev cre symfony/webpack-encore-bundle
    ```

- Remove a package:
    ```bash
    ddev composer remove symfony/webpack-encore-bundle
    dev composer remove symfony/webpack-encore-bundle
    dev c remove symfony/webpack-encore-bundle
    dev crm symfony/webpack-encore-bundle
    ```

### Database Commands

- Export the database:
    ```bash
    ddev export-db -f .project/db.sql.gz
    ddev e [file]
    dev export
    dev e
    ```

- Import the database:
    ```bash
    ddev import-db -f .project/db.sql.gz
    ddev i [file]
    dev import
    dev i
    ```

### Shopware Commands

- Clear cache:
    ```bash
    ddev exec php bin/console cache:clear
    dev console cache:clear
    dev con cache:clear
    dev ca:cl
    dev cc
    ```

- List plugins:
    ```bash
    dev pl
    ```

- Activate plugin:
    ```bash
    dev plac [plugin]
    ```

### Upgrade the Script

To update the script to the latest version, use the following command:
```bash
dev upgrade
```

## Integration in Your Console

1. Create the `~/.bin` directory if it doesn't exist:
    ```bash
    mkdir -p ~/.bin
    ```

2. Download the script and save it in the `~/.bin` directory:
    ```bash
    curl -o ~/.bin/dev https://raw.githubusercontent.com/akaw/dev-cli-tools/refs/heads/main/dev
    ```

3. Make the script executable:
    ```bash
    chmod +x ~/.bin/dev
    ```

4. Add the following line to your `.bashrc` or `.zshrc` file to add the `~/.bin` directory to your `PATH`:
    ```bash
    export PATH="$PATH:~/.bin"
    ```

5. Reload your shell configuration file to apply the changes:
    ```bash
    source ~/.bashrc
    # or
    source ~/.zshrc
    ```

This will allow you to use the `dev` command from any directory in your terminal.

## Author

andre.witte@freenet.de
