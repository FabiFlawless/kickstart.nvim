# 🔧 NerdFont Icons Problem beheben

## Problem: Icons werden als `*` angezeigt

### 🎯 **Lösung 1: Terminal Font einstellen**

**Windows Terminal:**
1. `Ctrl + ,` (Settings öffnen)
2. Profile → Defaults → Appearance 
3. Font face: `"Geist Mono Nerd Font"` oder `"GeistMono NF"`
4. Speichern und Neovim neu starten

**PowerShell/CMD:**
1. Rechtsklick auf Titel → Properties
2. Font: Geist Mono Nerd Font auswählen
3. OK klicken

### 🔍 **Lösung 2: Font-Name überprüfen**

Führe in PowerShell aus:
```powershell
# Installierte NerdFonts anzeigen
Get-ChildItem "C:\Windows\Fonts" | Where-Object {$_.Name -like "*Geist*"} | Select-Object Name
```

Mögliche Namen:
- `GeistMono NF`
- `Geist Mono Nerd Font`
- `GeistMono Nerd Font Mono`

### 🚀 **Lösung 3: Alternative Fonts**

Falls Geist Mono nicht funktioniert, probieren Sie:
- `JetBrainsMono NF`
- `FiraCode NF` 
- `CascadiaCode NF`

### 🛠️ **Lösung 4: Neovim Font-Test**

In Neovim testen:
```vim
KW
```
Sollte Go-, Markdown- und Lua-Icons zeigen.

### 📥 **Lösung 5: Font neu installieren**

1. Download: [Nerd Fonts - Geist Mono](https://github.com/ryanoasis/nerd-fonts/releases)
2. Alle `.ttf` Dateien installieren
3. System neu starten
4. Terminal-Font neu einstellen

## 🔧 **Nach der Behebung:**

Neo-tree sollte zeigen:
- ` main.go` (Go-Icon)
- ` main_test.go` (Go-Test-Icon)  
- ` README.md` (Markdown-Icon)
- ` config.lua` (Lua-Icon)

## 💡 **Extra-Tipp:**

Neo-tree Größe zur Laufzeit ändern:
- `Ctrl + w` dann `>` oder `<` - Breite ändern
- `Ctrl + w` dann `=` - Gleichmäßig verteilen

## 🎯 **Keybindings für längere Dateinamen:**

- `<space>e` - Neo-tree toggle (40 Zeichen breit)
- `h` - Hidden files toggle (in Neo-tree)
- `R` - Refresh (in Neo-tree)
- `Ctrl + x` - Horizontal split (in Neo-tree)
- `Ctrl + v` - Vertical split (in Neo-tree)
