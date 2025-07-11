#!/bin/bash
# Script to install Go tools for Neovim development

echo "Installing Go development tools..."

# Go language server and basic tools
go install golang.org/x/tools/gopls@latest
go install mvdan.cc/gofumpt@latest
go install github.com/go-delve/delve/cmd/dlv@latest

# Code generation and manipulation tools
go install github.com/fatih/gomodifytags@latest
go install github.com/cweill/gotests/gotests@latest
go install github.com/josharian/impl@latest

# Import management
go install golang.org/x/tools/cmd/goimports@latest

# Error handling
go install github.com/koron/iferr@latest

# Testing tools
go install github.com/rakyll/gotest@latest
go install gotest.tools/gotestsum@latest

# Vulnerability checking
go install golang.org/x/vuln/cmd/govulncheck@latest

# Other helpful tools
go install github.com/motemen/gomvp@latest
go install github.com/davidrjenni/reftools/cmd/fillswitch@latest

echo "All Go tools installed successfully!"
echo "Make sure your GOBIN is in your PATH:"
echo "export PATH=\$PATH:\$(go env GOPATH)/bin"
