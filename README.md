# dev-cli-tools

## Overview

`dev-cli-tools` is a Bash script that provides shortcuts for commonly used commands from ddev, Shopware, and other tools. It simplifies project management and development through easy commands.

## Installation

1. Download the script:
    ```bash
    curl -o /usr/local/bin/dev https://raw.githubusercontent.com/akaw/dev-cli-tools/refs/heads/main/dev
    ```

2. Make the script executable:
    ```bash
    chmod +x /usr/local/bin/dev
    ```

## Usage

The script offers a variety of commands and options. Here are some examples:

### General ddev Commands

- Start the project:
    ```bash
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
    dev composer install
    dev cin
    ```

- Update dependencies:
    ```bash
    dev composer update
    dev cup
    ```

- Add a package:
    ```bash
    dev composer require symfony/webpack-encore-bundle
    dev cre symfony/webpack-encore-bundle
    ```

- Remove a package:
    ```bash
    dev composer remove symfony/webpack-encore-bundle
    dev crm symfony/webpack-encore-bundle
    ```

### Database Commands

- Export the database:
    ```bash
    dev export
    dev e
    ```

- Import the database:
    ```bash
    dev import
    dev i
    ```

### Shopware Commands

- Clear cache:
    ```bash
    dev cc
    dev ca:cl
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

## Help

For a complete list of available commands and options, run the following command:
```bash
dev --help
```

## Author

Andre Witte

