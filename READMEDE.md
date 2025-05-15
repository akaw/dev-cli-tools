# Development CLI Tools

CLI-Tool zur Vereinfachung der täglichen Entwicklungsarbeit mit DDEV, Shopware und Symfony.

## Installation

Das Tool besteht aus einem einzigen Bash-Skript (`src/dev`), das an beliebiger Stelle im System platziert werden kann. Hier sind verschiedene Installationsmöglichkeiten:

### Option 1: Direkter Download

Laden Sie einfach die Skriptdatei herunter und platzieren Sie sie wo Sie möchten, zum Beispiel in Ihrem eigenen bin-Verzeichnis:

```bash
# Skript herunterladen (Beispiel für ~/config/bin Verzeichnis)
mkdir -p ~/config/bin
curl -o ~/config/bin/dev https://raw.githubusercontent.com/akaw/dev-cli-tools/main/src/dev
chmod +x ~/config/bin/dev

# Zum PATH hinzufügen falls nötig (in .zshrc, .bashrc, etc.)
export PATH="$HOME/config/bin:$PATH"
```

### Option 2: Manuelle Kopie

Wenn Sie das Repository geklont haben, können Sie das Skript einfach an den gewünschten Ort kopieren:

```bash
# Skript kopieren (Beispiel für ~/config/bin Verzeichnis)
mkdir -p ~/config/bin
cp src/dev ~/config/bin/
chmod +x ~/config/bin/dev

# Zum PATH hinzufügen falls nötig (in .zshrc, .bashrc, etc.)
export PATH="$HOME/config/bin:$PATH"
```

Das Skript ist eigenständig und kann an jedem beliebigen Ort platziert werden. Stellen Sie nur sicher, dass der Speicherort in Ihrem PATH enthalten ist.

## Voraussetzungen

- DDEV
- Docker oder OrbStack
- PHP 8.2+
- Node.js 20+

## Hauptfunktionen

- Projekt-Management (start, stop, restart)
- Datenbank-Operationen (import, export)
- Entwicklungs-Tools (xdebug, logs, tests)
- Composer-Verwaltung
- Shopware-spezifische Befehle

## Befehlsabkürzungen

### Projekt-Management
- `dev u` - Projekt starten (up)
- `dev d` - Projekt stoppen (down)
- `dev r` - Projekt neu starten
- `dev st` - Status anzeigen
- `dev o` - Im Browser öffnen

### Datenbank
- `dev e` - Datenbank exportieren
- `dev i` - Datenbank importieren
- `dev sq` - Sequel Ace öffnen
- `dev mi` - Migrationen ausführen

### Entwicklung
- `dev x` - Xdebug umschalten
- `dev t` - Tests ausführen
- `dev l` - Logs anzeigen
- `dev ma` - Mailserver starten

### Composer
- `dev c` - Composer-Befehl
- `dev cu` - Abhängigkeiten aktualisieren
- `dev ci` - Abhängigkeiten installieren
- `dev cr` - Paket hinzufügen
- `dev crm` - Paket entfernen
- `dev ca` - Autoloader aktualisieren

### Shopware
- `dev b` - Komponenten bauen
- `dev w` - Komponenten überwachen
- `dev cc` - Cache leeren
- `dev p` - Plugin-Befehle:
  - `dev pr` - Plugins aktualisieren
  - `dev pl` - Plugins auflisten
  - `dev pa` - Plugin aktivieren
  - `dev pd` - Plugin deaktivieren

### Projekt
- `dev n` - Neues Projekt
- `dev bk` - Backup
- `dev rs` - Wiederherstellen

### Direkte Befehlsausführung
Jeder Befehl, der nicht als Kurzform erkannt wird, wird direkt im Container mit `ddev exec` ausgeführt. Das ermöglicht es, jeden beliebigen Befehl auszuführen, ohne explizit `ddev exec` zu verwenden:

```bash
# Diese Befehle sind gleichwertig:
ddev exec php -v
dev php -v

# Führe beliebige Befehle im Container aus
dev node --version
dev composer --version
dev bin/console debug:router
```

## Beispiele

```bash
# Projekt starten
dev u

# Datenbank importieren
dev i

# Abhängigkeiten installieren
dev ci

# Shopware bauen
dev b
```

## Entwicklung

Beiträge sind willkommen! Bitte beachten:

1. Fork des Repositories
2. Feature Branch erstellen
3. Änderungen committen
4. Pull Request erstellen

## Lizenz

Dieses Projekt ist unter der MIT-Lizenz lizenziert.

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
