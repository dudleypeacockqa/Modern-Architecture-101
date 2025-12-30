# Project Initialization Script (Windows PowerShell)
# Usage: .\scripts\init-project.ps1 -ProjectName "new-project" -ProjectType "greenfield"

param(
    [Parameter(Mandatory=$false)]
    [string]$ProjectName = "new-project",
    
    [Parameter(Mandatory=$false)]
    [ValidateSet("greenfield", "brownfield")]
    [string]$ProjectType = "greenfield"
)

$ErrorActionPreference = "Stop"

Write-Host "Initializing $ProjectType project: $ProjectName" -ForegroundColor Cyan
Write-Host "=============================================" -ForegroundColor Cyan

if ($ProjectType -eq "greenfield") {
    Write-Host "Creating greenfield project structure..." -ForegroundColor Yellow
    
    # Create directory structure
    $directories = @(
        "$ProjectName/docs/01_strategy/prd",
        "$ProjectName/docs/02_architecture",
        "$ProjectName/bmad/intents",
        "$ProjectName/src",
        "$ProjectName/tests/unit",
        "$ProjectName/tests/integration",
        "$ProjectName/tests/e2e",
        "$ProjectName/.claude"
    )
    
    foreach ($dir in $directories) {
        New-Item -ItemType Directory -Force -Path $dir | Out-Null
    }
    
    # Copy CLAUDE.md template
    Copy-Item "tool-configs/CLAUDE.md" "$ProjectName/.claude/CLAUDE.md"
    
    # Create PRD template
    $prdContent = @"
# Product Requirements Document

## Overview
[Project overview here]

## Goals
[Project goals here]

## Requirements
[Requirements here]
"@
    Set-Content -Path "$ProjectName/docs/prd.md" -Value $prdContent
    
    # Create intent template
    $intentContent = @"
# Intent 01: Example Feature

## Description
[Feature description]

## Acceptance Criteria
- [ ] Criterion 1
- [ ] Criterion 2

## TDD Scenarios

### Scenario 1: Happy Path
``````gherkin
Given [context]
When [action]
Then [result]
``````
"@
    Set-Content -Path "$ProjectName/bmad/intents/intent-01-example.md" -Value $intentContent
    
    # Create .env.example
    $envContent = @"
# Application Configuration
APP_NAME=YourAppName
ENVIRONMENT=development

# Database
DATABASE_URL=postgresql://user:pass@localhost:5432/db

# Authentication (Clerk)
CLERK_PUBLISHABLE_KEY=pk_test_xxx
CLERK_SECRET_KEY=sk_test_xxx

# Linear Integration (optional)
LINEAR_API_KEY=lin_api_xxx
LINEAR_DEFAULT_TEAM_ID=team-uuid
"@
    Set-Content -Path "$ProjectName/.env.example" -Value $envContent
    
    # Create pytest.ini
    $pytestContent = @"
[pytest]
testpaths = tests
python_files = test_*.py
python_functions = test_*
addopts = -v --tb=short
"@
    Set-Content -Path "$ProjectName/pytest.ini" -Value $pytestContent
    
} else {
    Write-Host "Brownfield project - adding BMAD structure to existing project..." -ForegroundColor Yellow
    
    # Add missing directories
    $directories = @(
        "docs/01_strategy/prd",
        "docs/02_architecture",
        "bmad/intents",
        ".claude",
        "tests/unit",
        "tests/integration",
        "tests/e2e"
    )
    
    foreach ($dir in $directories) {
        if (-not (Test-Path $dir)) {
            New-Item -ItemType Directory -Force -Path $dir | Out-Null
            Write-Host "Created: $dir" -ForegroundColor Green
        }
    }
    
    # Copy Claude config if not exists
    if (-not (Test-Path ".claude/CLAUDE.md")) {
        Copy-Item "tool-configs/CLAUDE.md" ".claude/CLAUDE.md"
        Write-Host "Added .claude/CLAUDE.md" -ForegroundColor Green
    }
    
    # Create env example if not exists
    if (-not (Test-Path ".env.example")) {
        Set-Content -Path ".env.example" -Value "# Add your environment variables here"
        Write-Host "Added .env.example" -ForegroundColor Green
    }
}

Write-Host ""
Write-Host "Project initialized successfully!" -ForegroundColor Green
Write-Host ""
Write-Host "Next steps:" -ForegroundColor Cyan
Write-Host "1. Review and customize .claude/CLAUDE.md"
Write-Host "2. Update docs/prd.md with your requirements"
Write-Host "3. Create intents in bmad/intents/"
Write-Host "4. Copy .env.example to .env and configure"
Write-Host "5. Start with TDD - write tests first!"
