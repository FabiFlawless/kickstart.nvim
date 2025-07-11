# Go Development in Neovim - Schnellstart-Anleitung

## Installation und Setup

1. **Neovim neu starten**: Damit alle neuen Plugins installiert werden
2. **Mason öffnen**: `:Mason` um zu sehen, welche Tools installiert werden
3. **Gesundheitscheck**: `:checkhealth` um sicherzustellen, dass alles funktioniert

## Wichtige Keybindings für Go-Entwicklung

### Grundlegende Navigation und Information
- **`K`** - Zeigt Hover-Informationen (Funktionsdefinition, Struct-Inhalte, etc.)
- **`<Space>sk`** - Zeigt alle verfügbaren Keybindings an
- **`<Space>gd`** - Gehe zur Definition
- **`<Space>gi`** - Gehe zur Implementierung  
- **`<Space>gr`** - Zeige alle Referenzen
- **`<Space>gt`** - Gehe zur Typ-Definition

### Go-spezifische Features
- **`<Space>gfs`** - Fülle Struct automatisch aus
- **`<Space>gie`** - Füge `if err != nil` Block hinzu
- **`<Space>gat`** - Füge Tags zu Struct hinzu
- **`<Space>grt`** - Entferne Tags von Struct
- **`<Space>gh`** - Zeige Go-Dokumentation

### Testing
- **`<Space>gtt`** - Führe aktuellen Test aus
- **`<Space>gtf`** - Führe Test-Funktion aus
- **`<Space>gtp`** - Führe alle Tests im Package aus
- **`<Space>gta`** - Führe alle Tests aus
- **`<Space>gtc`** - Zeige Test-Coverage

### Build und Run
- **`<Space>gb`** - Baue Go-Projekt
- **`<Space>gr`** - Führe Go-Programm aus

### Debugging
- **`F5`** - Starte/Fortsetzung Debug
- **`<Space>gdt`** - Debug aktuellen Test
- **`<Space>b`** - Toggle Breakpoint

### Formatting
- **`<Space>gf`** - Formatiere Go-Code
- **`<Space>go`** - Organisiere Imports
- **`<Space>f`** - Allgemeine Formatierung

## Wie du Funktionen und Structs erkunden kannst

1. **Cursor auf Funktion/Struct setzen**
2. **`K` drücken** - Zeigt Definition und Dokumentation
3. **`<Space>gd`** - Springt zur Definition
4. **`<Space>gr`** - Zeigt alle Stellen, wo es verwendet wird

## Weitere nützliche Befehle

- **`:GoDoc <function_name>`** - Zeige Dokumentation für spezifische Funktion
- **`:GoImpl`** - Implementiere Interface-Methoden
- **`:GoFillStruct`** - Fülle Struct mit allen Feldern aus
- **`:GoCoverage`** - Zeige Test-Coverage im Code

## Tipps

1. **Which-Key nutzen**: Drücke `<Space>g` und warte - du siehst alle Go-Befehle
2. **LSP Features**: Die meisten Features funktionieren automatisch wenn du eine .go Datei öffnest
3. **Telescope für Code-Suche**: `<Space>sg` für Live-Grep in deinem Go-Code
4. **Diagnostics**: `<Space>sd` zeigt alle Compiler-Errors und Warnings

## Debugging Setup

Das Debug-Plugin ist bereits konfiguriert für Go:
- Setze Breakpoints mit `<Space>b`
- Starte Debug mit `F5`
- Nutze `F1`, `F2`, `F3` zum Durchsteppen
