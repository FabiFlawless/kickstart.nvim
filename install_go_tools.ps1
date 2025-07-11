# PowerShell script to install Go tools for Neovim development

Write-Host "Installing Go development tools..." -ForegroundColor Green

# Go language server and basic tools
Write-Host "Installing gopls..." -ForegroundColor Yellow
go install golang.org/x/tools/gopls@latest

Write-Host "Installing gofumpt..." -ForegroundColor Yellow
go install mvdan.cc/gofumpt@latest

Write-Host "Installing delve debugger..." -ForegroundColor Yellow
go install github.com/go-delve/delve/cmd/dlv@latest

# Code generation and manipulation tools
Write-Host "Installing gomodifytags..." -ForegroundColor Yellow
go install github.com/fatih/gomodifytags@latest

Write-Host "Installing gotests..." -ForegroundColor Yellow
go install github.com/cweill/gotests/gotests@latest

Write-Host "Installing impl..." -ForegroundColor Yellow
go install github.com/josharian/impl@latest

# Import management
Write-Host "Installing goimports..." -ForegroundColor Yellow
go install golang.org/x/tools/cmd/goimports@latest

# Error handling
Write-Host "Installing iferr..." -ForegroundColor Yellow
go install github.com/koron/iferr@latest

# Testing tools
Write-Host "Installing gotestsum..." -ForegroundColor Yellow
go install gotest.tools/gotestsum@latest

# Vulnerability checking
Write-Host "Installing govulncheck..." -ForegroundColor Yellow
go install golang.org/x/vuln/cmd/govulncheck@latest

# Other helpful tools
Write-Host "Installing gomvp..." -ForegroundColor Yellow
go install github.com/motemen/gomvp@latest

Write-Host "Installing fillswitch..." -ForegroundColor Yellow
go install github.com/davidrjenni/reftools/cmd/fillswitch@latest

# Linting
Write-Host "Installing golangci-lint..." -ForegroundColor Yellow
go install github.com/golangci/golangci-lint/cmd/golangci-lint@latest

Write-Host "All Go tools installed successfully!" -ForegroundColor Green
Write-Host "Make sure your GOBIN is in your PATH." -ForegroundColor Cyan

$goPath = go env GOPATH
$goBin = Join-Path $goPath "bin"
Write-Host "Your GOBIN should be: $goBin" -ForegroundColor Cyan
Write-Host "Add this to your PATH if it's not already there." -ForegroundColor Cyan
