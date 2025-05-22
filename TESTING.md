# Test-Strategie für Dev-CLI-Tools

Dieses Dokument beschreibt unsere Test-Strategie für die Dev-CLI-Tools. Wir verwenden einen zweistufigen Ansatz:

1. **Code-Qualitätsprüfungen** werden automatisch auf GitHub durchgeführt
2. **Funktionstests** werden lokal durchgeführt, wo alle notwendigen Abhängigkeiten verfügbar sind

## GitHub-Workflows für Code-Qualität

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
bats tests/unit/
```

### Voraussetzungen für lokale Tests

- Bash
- DDEV installiert
- Docker oder OrbStack installiert
- Bats-Core installiert

### Hinzufügen neuer Tests

Neue Unit Tests können in `tests/unit/` hinzugefügt werden. Bestehende Tests können als Vorlage dienen.
Jeder Test sollte eine spezifische Funktion überprüfen und möglichst unabhängig von anderen Tests sein.

## Best Practices für Tests

- Alle neuen Funktionen sollten durch Unit Tests abgedeckt sein
- Bugs sollten mit Tests reproduziert und die Behebung durch Tests bestätigt werden
- Komplexe Logik sollte besonders gründlich getestet werden
- Tests sollten die tatsächliche Nutzung der CLI simulieren 