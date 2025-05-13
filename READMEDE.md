# Development CLI Tools

CLI-Tool zur Vereinfachung der täglichen Entwicklungsarbeit mit DDEV, Shopware und Symfony.

## Installation

```bash
# Clone Repository
git clone https://github.com/akaw/dev-cli-tools.git

# Symbolischen Link erstellen
ln -s /pfad/zu/dev-cli-tools/dev /usr/local/bin/dev

# Ausführbar machen
chmod +x /pfad/zu/dev-cli-tools/dev
```

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

## Beispiele

```bash
# Projekt starten
dev up

# Datenbank importieren
dev import

# Abhängigkeiten installieren
dev composer install

# Shopware bauen
dev build storefront
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
