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
        "$ProjectName/docs/00_overview",
        "$ProjectName/docs/01_strategy/prd",
        "$ProjectName/docs/02_architecture",
        "$ProjectName/docs/04_project_management/stories",
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
    
    # Copy North Star template
    Copy-Item "templates/NORTH_STAR.md" "$ProjectName/docs/NORTH_STAR.md"
    
    # Create Vision template
    $visionContent = @"
# System Vision and Strategy

**Last Updated**: $(Get-Date -Format "yyyy-MM-dd")
**Version**: 1.0
**Status**: Draft

## Executive Summary

[Brief overview of the system and its purpose]

## Business Goals

1. [Goal 1]
2. [Goal 2]
3. [Goal 3]

## Target Users

- **Primary**: [Primary user description]
- **Secondary**: [Secondary user description]

## Core Features

1. [Feature 1]
2. [Feature 2]
3. [Feature 3]

## Success Metrics

| Metric | Target | Current |
|--------|--------|---------|
| [Metric 1] | [Target] | - |
| [Metric 2] | [Target] | - |

## Technical Architecture

See `docs/02_architecture/architecture.md` for detailed architecture.

## Implementation Phases

### Phase 1: Foundation
- [Milestone 1]
- [Milestone 2]

### Phase 2: Core Features
- [Milestone 3]
- [Milestone 4]

### Phase 3: Enhancement
- [Milestone 5]
- [Milestone 6]
"@
    Set-Content -Path "$ProjectName/docs/00_System_Vision_and_Strategy.md" -Value $visionContent
    
    # Create PRD index
    $prdContent = @"
# Product Requirements Document

**Version**: 1.0
**Last Updated**: $(Get-Date -Format "yyyy-MM-dd")

## Overview

[Project overview here]

## Goals

[Project goals here]

## Functional Requirements

| ID | Requirement | Priority | Status |
|----|-------------|----------|--------|
| FR-001 | [Requirement] | Must | Pending |

## Non-Functional Requirements

| ID | Requirement | Priority | Status |
|----|-------------|----------|--------|
| NFR-001 | [Requirement] | Must | Pending |

## Epics

- [Epic 1](./epic-1.md)
- [Epic 2](./epic-2.md)
"@
    Set-Content -Path "$ProjectName/docs/01_strategy/prd/index.md" -Value $prdContent
    
    # Create BMAD Single Source of Truth
    $bmadContent = @"
# BMAD Single Source of Truth

**Purpose**: Define the authoritative document hierarchy for BMAD agents.

## Document Hierarchy

1. **PRD**: `docs/01_strategy/prd/index.md`
2. **Architecture**: `docs/02_architecture/architecture.md`
3. **Epics**: `docs/01_strategy/prd/epic-*.md`
4. **Stories**: `docs/04_project_management/stories/`

## Rules

- Always use PRIMARY documents
- IGNORE archived documents
- Use SUPPLEMENT documents for context only
"@
    Set-Content -Path "$ProjectName/docs/01_strategy/BMAD_SINGLE_SOURCE_OF_TRUTH.md" -Value $bmadContent
    
    # Create architecture template
    $archContent = @"
# Architecture

**Version**: 1.0
**Last Updated**: $(Get-Date -Format "yyyy-MM-dd")

## Overview

[Architecture overview]

## Technology Stack

- **Frontend**: [Framework]
- **Backend**: [Framework]
- **Database**: PostgreSQL
- **Authentication**: Clerk
- **Deployment**: Render

## System Components

[Component diagram or description]

## Data Flow

[Data flow description]

## Security

[Security considerations]
"@
    Set-Content -Path "$ProjectName/docs/02_architecture/architecture.md" -Value $archContent
    
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

# Database (PostgreSQL)
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
        "docs/00_overview",
        "docs/01_strategy/prd",
        "docs/02_architecture",
        "docs/04_project_management/stories",
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
    
    # Copy North Star if not exists
    if (-not (Test-Path "docs/NORTH_STAR.md")) {
        Copy-Item "templates/NORTH_STAR.md" "docs/NORTH_STAR.md"
        Write-Host "Added docs/NORTH_STAR.md" -ForegroundColor Green
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
Write-Host "2. Update docs/NORTH_STAR.md with your document locations"
Write-Host "3. Update docs/00_System_Vision_and_Strategy.md with your vision"
Write-Host "4. Update docs/01_strategy/prd/index.md with your requirements"
Write-Host "5. Create intents in bmad/intents/"
Write-Host "6. Copy .env.example to .env and configure"
Write-Host "7. Start with TDD - write tests first!"
