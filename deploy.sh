#!/bin/bash

#
# Quick deployment script for Partner PowerUp BizObs ACE-Box Extension
#

set -e

echo "🚀 Partner PowerUp BizObs ACE-Box Extension - Quick Deploy"
echo "=========================================================="

# Check if running in ACE-Box environment
if ! command -v ace &> /dev/null; then
    echo "❌ Error: 'ace' command not found. This script must run in an ACE-Box environment."
    exit 1
fi

# Get current directory
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
echo "📁 Extension directory: $SCRIPT_DIR"

# Validate required files exist
REQUIRED_FILES=(
    "main.yml"
    "ace-ext.config.yml" 
    "roles/my-use-case/tasks/main.yml"
    "roles/my-use-case/templates/dashboard-groundhog.html.j2"
)

echo "✅ Validating extension structure..."
for file in "${REQUIRED_FILES[@]}"; do
    if [[ ! -f "$SCRIPT_DIR/$file" ]]; then
        echo "❌ Error: Required file missing: $file"
        exit 1
    fi
done
echo "✅ All required files present"

# Check if this is a git repository
if [[ -d "$SCRIPT_DIR/.git" ]]; then
    echo "📝 Git repository detected"
    
    # Check for uncommitted changes
    if ! git diff --quiet 2>/dev/null; then
        echo "⚠️  Warning: Uncommitted changes detected. Consider committing before deployment."
        read -p "Continue anyway? (y/N): " -n 1 -r
        echo
        if [[ ! $REPLY =~ ^[Yy]$ ]]; then
            echo "❌ Deployment cancelled"
            exit 1
        fi
    fi
    
    # Get git remote URL
    GIT_URL=$(git config --get remote.origin.url 2>/dev/null || echo "")
    if [[ -n "$GIT_URL" ]]; then
        echo "🔗 Git URL: $GIT_URL"
        echo ""
        echo "To deploy from git repository, run:"
        echo "ace enable $GIT_URL"
        echo ""
        read -p "Deploy from git repository now? (Y/n): " -n 1 -r
        echo
        if [[ ! $REPLY =~ ^[Nn]$ ]]; then
            echo "🚀 Deploying from git repository..."
            ace enable "$GIT_URL"
            exit 0
        fi
    fi
fi

# Local deployment option
echo "📦 Deploying from local directory..."
cd "$SCRIPT_DIR"

# Run the main playbook
echo "🎯 Executing main.yml playbook..."
if ansible-playbook main.yml; then
    echo ""
    echo "🎉 Partner PowerUp BizObs deployment completed successfully!"
    echo ""
    echo "📊 Access your services:"
    echo "   Dashboard: https://dashboard.<your-domain>/"
    echo "   BizObs App: https://bizobs.<your-domain>/"
    echo "   Mattermost: https://mattermost.<your-domain>/"
    echo ""
    echo "🔧 The dashboard has been automatically fixed for OneAgent compatibility"
    echo "✅ All services are ready for business observability demonstrations"
else
    echo ""
    echo "❌ Deployment failed. Check the logs above for details."
    exit 1
fi