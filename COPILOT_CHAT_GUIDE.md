# GitHub Copilot Chat in Neovim - Komplette Anleitung

## 🤖 Was ist CopilotChat.nvim?

CopilotChat.nvim bringt die GitHub Copilot Chat-Funktionen direkt in Neovim. Es bietet:

- **AI-gestützten Chat** mit GPT-4o, Claude 3.7 Sonnet, Gemini 2.0 Flash
- **Intelligente Kontexterkennung** durch Smart Embeddings
- **Go-spezifische Prompts** für bessere Entwicklung
- **Interactive UI** mit Diff-Integration
- **Sichere Kontextfreigabe** - nur explizit geteilte Inhalte werden gesendet

## 🔧 Installation (Bereits erledigt!)

Die Installation ist bereits in Ihrer Konfiguration integriert:
- `copilot.vim` - Basis GitHub Copilot Plugin
- `CopilotChat.nvim` - Chat-Erweiterung
- Go-spezifische Prompts und Keybindings

## 🎯 Wichtige Keybindings

### Haupt-Chat-Steuerung:
| Keybinding | Modus | Beschreibung |
|------------|-------|-------------|
| `<space>cc` | Normal/Visual | Chat öffnen / Mit Selection chatten |
| `<space>co` | Normal | Chat-Fenster öffnen |
| `<space>ct` | Normal | Chat-Fenster toggle |
| `<space>cq` | Normal | Chat-Fenster schließen |
| `<space>cs` | Normal | Generation stoppen |
| `<space>cr` | Normal | Chat zurücksetzen |

### Schnelle Code-Aktionen (Visual Mode):
| Keybinding | Beschreibung |
|------------|-------------|
| `<space>ce` | Code erklären |
| `<space>cv` | Code review |
| `<space>cf` | Code reparieren |
| `<space>cd` | Dokumentation hinzufügen |
| `<space>cp` | Code optimieren |

### Go-spezifische Aktionen:
| Keybinding | Beschreibung |
|------------|-------------|
| `<space>cgr` | Go Code refactoring |
| `<space>cge` | Go Error-Handling verbessern |
| `<space>cgp` | Go Performance-Analyse |
| `<space>cgs` | Go Security-Review |

### Chat-Verwaltung:
| Keybinding | Beschreibung |
|------------|-------------|
| `<space>cP` | Verfügbare Prompts anzeigen |
| `<space>cM` | Verfügbare Modelle anzeigen |
| `<space>cA` | Verfügbare Agents anzeigen |
| `<space>ch` | Chat-Historie speichern |
| `<space>cl` | Chat-Historie laden |

## 🎮 Chat-Fenster Steuerung

### Im Chat-Fenster:
| Taste | Modus | Aktion |
|-------|-------|--------|
| `<Tab>` | Insert | Autovervollständigung akzeptieren |
| `<C-s>` | Insert | Prompt senden |
| `<CR>` | Normal | Prompt senden |
| `q` | Normal | Chat schließen |
| `<C-r>` | Normal/Insert | Chat zurücksetzen |
| `gj` | Normal | Zu Diff springen |
| `gd` | Normal | Diff anzeigen |
| `<C-y>` | Normal/Insert | Diff akzeptieren |
| `gy` | Normal | Diff kopieren |
| `gi` | Normal | Chat-Info anzeigen |
| `gc` | Normal | Kontext anzeigen |
| `gh` | Normal | Hilfe anzeigen |

## 📝 Prompt-System

### Vordefinierte Prompts:
Verwenden Sie diese mit `/PromptName` im Chat oder als Befehle:

| Prompt | Befehl | Beschreibung |
|--------|--------|-------------|
| `Explain` | `:CopilotChatExplain` | Code erklären |
| `Review` | `:CopilotChatReview` | Code review |
| `Fix` | `:CopilotChatFix` | Probleme beheben |
| `Optimize` | `:CopilotChatOptimize` | Code optimieren |
| `Docs` | `:CopilotChatDocs` | Dokumentation hinzufügen |
| `Tests` | `:CopilotChatTests` | Tests generieren |
| `Commit` | `:CopilotChatCommit` | Commit-Nachricht erstellen |

### Go-spezifische Prompts:
| Prompt | Beschreibung |
|--------|-------------|
| `GoRefactor` | Refactoring nach Go Best Practices |
| `GoError` | Error-Handling verbessern |
| `GoPerformance` | Performance-Analyse |
| `GoSecurity` | Security-Review |

## 🔍 Kontext-System

### Verfügbare Kontexte:
Verwenden Sie `#context[:input]` im Chat:

| Kontext | Beispiel | Beschreibung |
|---------|----------|-------------|
| `#buffer` | `#buffer` | Aktueller Buffer |
| `#buffer:2` | `#buffer:2` | Buffer Nr. 2 |
| `#files` | `#files:*.go` | Dateien (mit Glob-Pattern) |
| `#filenames` | `#filenames` | Nur Dateinamen |
| `#git` | `#git:staged` | Git-Änderungen |
| `#url` | `#url:https://...` | Inhalt von URLs |
| `#system` | `#system:ls -la` | Shell-Befehl Ausgabe |

### Beispiele:
```
Erkläre mir diesen Code
#buffer

Wie kann ich die Performance verbessern?
#files:*.go
#git:unstaged

Generiere Tests für alle Go-Dateien
#files:**/*.go
```

## 🎯 Praktische Beispiele

### 1. Code erklären:
1. Markieren Sie Code im Visual Mode
2. Drücken Sie `<space>ce`
3. Copilot erklärt den markierten Code

### 2. Go-spezifisches Refactoring:
1. Markieren Sie Go-Code
2. Drücken Sie `<space>cgr`
3. Erhalten Sie Go-Best-Practice Vorschläge

### 3. Error-Handling verbessern:
1. Markieren Sie Code mit Error-Handling
2. Drücken Sie `<space>cge`
3. Bekommen Sie bessere Error-Handling Patterns

### 4. Chat mit Kontext:
1. Öffnen Sie Chat mit `<space>cc`
2. Schreiben Sie: `Erkläre mir diese Funktion #buffer`
3. Copilot analysiert den gesamten Buffer

### 5. Performance-Analyse:
1. Markieren Sie kritischen Code
2. Drücken Sie `<space>cgp`
3. Erhalten Sie Performance-Optimierungsvorschläge

## 🛠️ Erweiterte Features

### Sticky Prompts:
Verwenden Sie `>` für persistente Prompts:
```
> @models Using Mistral-small
> #files:*.go

Was ist das Hauptproblem in meinem Code?
```

### Modell-Auswahl:
- `:CopilotChatModels` - Verfügbare Modelle anzeigen
- Im Chat: `$gpt-4o` - Spezifisches Modell verwenden

### Agent-Auswahl:
- `:CopilotChatAgents` - Verfügbare Agents anzeigen
- Im Chat: `@copilot` - Spezifischen Agent verwenden

## 🔧 Fehlerbehebung

### Häufige Probleme:

1. **"Copilot not authenticated"**
   - Lösung: `:Copilot setup` ausführen

2. **Chat öffnet sich nicht**
   - Lösung: `:Lazy sync` ausführen, Neovim neu starten

3. **Keine Autovervollständigung**
   - Lösung: `completeopt` bereits konfiguriert

4. **Tiktoken Fehler (Windows)**
   - Normal: Tiktoken ist optional, funktioniert auch ohne

### Debug-Befehle:
- `:checkhealth copilot` - Copilot Status prüfen
- `:CopilotChatToggle` - Chat toggle testen
- `:Lazy` - Plugin-Status prüfen

## 🎓 Tipps für beste Ergebnisse

1. **Seien Sie spezifisch:** Je genauer Ihre Frage, desto bessere Antworten
2. **Verwenden Sie Kontext:** `#buffer` oder `#files` für besseres Verständnis
3. **Go-spezifische Prompts:** Nutzen Sie die speziellen Go-Prompts
4. **Iterativ arbeiten:** Stellen Sie Nachfragen für Verbesserungen
5. **Diff-Integration:** Verwenden Sie `<C-y>` um Vorschläge zu übernehmen

## 🚀 Nächste Schritte

1. **Setup abschließen:** `:Copilot setup`
2. **Ersten Chat testen:** `<space>cc`
3. **Go-Prompts ausprobieren:** `<space>cgr` mit markiertem Code
4. **Kontext-System lernen:** Experimentieren Sie mit `#buffer`, `#files`
5. **Workflow integrieren:** Nutzen Sie Chat für Code Reviews und Refactoring

Viel Erfolg mit Ihrem neuen AI-Assistant! 🤖✨
