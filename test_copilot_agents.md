# 🤖 Copilot Agents Troubleshooting

## Aktuelle Situation:
- `:CopilotChatModels` funktioniert ✅
- `:Copilot auth` funktioniert ✅  
- `:CopilotChatAgents` zeigt `<none>` an ❌

## Mögliche Ursachen:

### 1. **GitHub Enterprise Beschränkungen**
Firmen-Accounts haben oft eingeschränkte Copilot-Features:
- Extension Agents sind möglicherweise deaktiviert
- Nur Basis-Chat ohne erweiterte Agent-Features

### 2. **Copilot-Plan Limitierungen**
- GitHub Copilot Individual: Begrenzte Agent-Features
- GitHub Copilot Business: Erweiterte Features
- GitHub Copilot Enterprise: Vollständige Agent-Unterstützung

### 3. **Plugin-Version**
Stellen Sie sicher, dass Sie die neueste Version haben:
```
:Lazy update CopilotChat.nvim
```

## Workaround-Lösungen:

### A) **Pseudo-Agents über Sticky Prompts:**
```
> @code_reviewer Acting as a code review specialist
> @go_expert Acting as a Go development expert
> @security_analyst Acting as a security analyst

Wie kann ich diesen Code verbessern?
#buffer
```

### B) **Modell-spezifische "Agents":**
```
$gpt-4o
> You are a Go development expert. Focus on Go best practices.

Refactor this code:
#files:*.go
```

### C) **Kontext-basierte Spezialisierung:**
```
#files:*.go
#git:unstaged

Acting as a Go security expert, review my changes for vulnerabilities.
```

## Debug-Befehle:

1. `:checkhealth copilot` - Copilot-Status prüfen
2. `:CopilotChatToggle` - Chat öffnen/schließen
3. `:lua print(vim.inspect(require("CopilotChat").config))` - Config anzeigen

## Nächste Schritte:

1. **GitHub-Administrator kontaktieren** für Agent-Freischaltung
2. **Workaround mit Sticky Prompts** verwenden
3. **Debug-Logs** prüfen für weitere Hinweise

---

*Erstellt: $(date)*
