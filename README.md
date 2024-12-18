# dev-cli-tools

## Übersicht

`dev-cli-tools` ist ein Bash-Skript, das Abkürzungen für häufig verwendete Befehle von ddev, Symfony, Shopware und anderen Tools bietet. Es erleichtert die Verwaltung und Entwicklung von Projekten durch einfache Befehle.

## Installation

1. Lade das Skript herunter:
    ```bash
    curl -o /usr/local/bin/dev https://raw.githubusercontent.com/akaw/dev-cli-tools/refs/heads/main/dev
    ```

2. Mache das Skript ausführbar:
    ```bash
    chmod +x /usr/local/bin/dev
    ```

## Verwendung

Das Skript bietet eine Vielzahl von Befehlen und Optionen. Hier sind einige Beispiele:

### Allgemeine ddev Befehle

- Starte das Projekt:
    ```bash
    dev up
    dev u
    ```

- Stoppe das Projekt:
    ```bash
    dev down
    dev d
    ```

- Öffne das Projekt im Browser:
    ```bash
    dev open
    dev o
    ```

- Zeige Logs an:
    ```bash
    dev logs
    dev l
    ```

### Composer-Befehle

- Installiere Abhängigkeiten:
    ```bash
    dev composer install
    dev cin
    ```

- Aktualisiere Abhängigkeiten:
    ```bash
    dev composer update
    dev cup
    ```

- Füge ein Paket hinzu:
    ```bash
    dev composer require symfony/webpack-encore-bundle
    dev cre symfony/webpack-encore-bundle
    ```

- Entferne ein Paket:
    ```bash
    dev composer remove symfony/webpack-encore-bundle
    dev crm symfony/webpack-encore-bundle
    ```

### Datenbank-Befehle

- Exportiere die Datenbank:
    ```bash
    dev export
    dev e
    ```

- Importiere die Datenbank:
    ```bash
    dev import
    dev i
    ```

### Shopware-Befehle

- Cache leeren:
    ```bash
    dev cc
    dev ca:cl
    ```

- Plugins auflisten:
    ```bash
    dev pl
    ```

- Plugin aktivieren:
    ```bash
    dev plac [plugin]
    ```

### Upgrade des Skripts

Um das Skript auf die neueste Version zu aktualisieren, verwende den folgenden Befehl:
```bash
dev upgrade
```

## Hilfe

Für eine vollständige Liste der verfügbaren Befehle und Optionen, führe den folgenden Befehl aus:
```bash
dev --help
```

## Autor

Andre Witte

