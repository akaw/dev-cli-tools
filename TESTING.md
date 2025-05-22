# Test-Strategie für Dev-CLI-Tools

Dieses Dokument beschreibt unsere Test-Strategie für die Dev-CLI-Tools. Wir verwenden einen mehrstufigen Ansatz:

1. **Lokale Tests vor Commits und Pushs**: Git Hooks führen Tests automatisch aus
2. **Code-Qualitätsprüfungen** werden automatisch auf GitHub durchgeführ
3. **Detaillierte Funktionstests** werden bei Bedarf lokal durchgeführ

## Lokale Git Hooks

Das Repository enthält vorkonfigurierte Git Hooks, die automatisch ausgeführt werden:

### Pre-Commit Hook

Vor jedem Commit werden folgende Prüfungen durchgeführt:
- Versionskonsistenz zwischen README.md und Skrip
- Bash-Syntax-Prüfung
- Ausführbarkeits-Check für das Skrip
- Formatierungsprüfungen:
  - Keine Tabs (nur Spaces)
  - Kein Trailing Whitespace
  - Code-Zeilen kürzer als 120 Zeichen

### Pre-Push Hook

Vor jedem Push werden umfassendere Tests durchgeführt:
- ShellCheck-Prüfung (wenn installiert)
- BATS-Tests (wenn installiert)
- Versionskonsistenz (wird bereits im pre-commit geprüft)

Diese Hooks stellen sicher, dass nur getesteter Code ins Repository gepusht wird.

### Einrichtung der Git Hooks

Um die Git Hooks zu aktivieren, führe folgende Befehle aus:

```bash
# Im Projektverzeichnis
cp hooks/pre-commit .git/hooks/
cp hooks/pre-push .git/hooks/
chmod +x .git/hooks/pre-commit .git/hooks/pre-push
```

Alternativ kannst du auch den Hooks-Pfad direkt auf das hooks-Verzeichnis setzen:

```bash
git config core.hooksPath hooks
```

## GitHub-Workflows für Code-Qualitä

Der automatisierte Workflow `.github/workflows/code-quality.yml` führt folgende Prüfungen bei jedem Push und Pull Request durch:

### 1. ShellCheck

Überprüft Bash-Skripte auf häufige Fehler, Stilprobleme und potenzielle Bugs. Probleme werden als Warnungen behandelt.

### 2. Versionskonsistenz

Stellt sicher, dass die Version im README.md mit der im Skript deklarierten Version übereinstimmt.

### 3. Formatierungsprüfungen

- Zeilenlänge (max. 120 Zeichen)
- Keine Tabs für Einrückungen
- Keine Leerzeichen am Zeilenende

### 4. Bash-Syntax

Überprüft die Syntax der Bash-Skripte ohne sie auszuführen.

### 5. Ausführbarkeits-Check

Stellt sicher, dass die Skripte über die entsprechenden Ausführungsrechte verfügen.

## Lokale Funktionstests

Da für vollständige Funktionstests Abhängigkeiten wie DDEV, Docker/OrbStack und ein bestimmtes Betriebssystemumfeld erforderlich sind, werden diese Tests lokal durchgeführt.

### Unit Tests

Wir verwenden [Bats](https://github.com/bats-core/bats-core) für Unit Tests:

```bash
# Testmodus aktivieren, um Docker-Prüfungen zu überspringen
DEV_TEST_MODE=true bats tests/test_dev.bats
```

### Voraussetzungen für lokale Tests

- Bash
- ShellCheck installiert (`brew install shellcheck`)
- DDEV installier
- Docker oder OrbStack installier
- Bats-Core installiert (`brew install bats-core`)

### Hinzufügen neuer Tests

Neue Unit Tests können in `tests/` hinzugefügt werden. Bestehende Tests können als Vorlage dienen.
Jeder Test sollte eine spezifische Funktion überprüfen und möglichst unabhängig von anderen Tests sein.

## Test-Workflow für Entwickler

1. Lokale Entwicklung und Tests
2. Commit - Pre-Commit-Hook prüft grundlegende Bedingungen
3. Push - Pre-Push-Hook führt umfassendere Tests aus
4. GitHub Actions - Führt die CI-Tests für Code-Qualität aus
5. Manueller Test - Bei größeren Änderungen zusätzliche manuelle Tests

## Best Practices für Tests

- Alle neuen Funktionen sollten durch Unit Tests abgedeckt sein
- Bugs sollten mit Tests reproduziert und die Behebung durch Tests bestätigt werden
- Komplexe Logik sollte besonders gründlich getestet werden
- Tests sollten die tatsächliche Nutzung der CLI simulieren

## Manuelle Tests

Du kannst die Tests auch manuell ausführen:

```bash
# Bash-Syntax prüfen
bash -n src/dev

# ShellCheck ausführen
shellcheck src/dev

# BATS-Tests ausführen (wenn vorhanden)
DEV_TEST_MODE=true bats tests/test_dev.bats
```