<#
.SYNOPSIS
    Modern Architecture 101 - Project Initialization Script for Windows PowerShell

.DESCRIPTION
    This script automates the integration of the Modern-Architecture-101
    methodology into both greenfield (new) and brownfield (existing) projects.

.PARAMETER ProjectPath
    The path to your project directory

.PARAMETER ProjectType
    The type of project: 'Greenfield' for new projects or 'Brownfield' for existing projects

.EXAMPLE
    .\Init-Project.ps1 -ProjectPath "C:\Projects\my-new-app" -ProjectType Greenfield

.EXAMPLE
    .\Init-Project.ps1 -ProjectPath "C:\Projects\existing-app" -ProjectType Brownfield

.NOTES
    Author: Manus AI
    Repository: https://github.com/dudleypeacockqa/Modern-Architecture-101
#>

[CmdletBinding()]
param(
    [Parameter(Mandatory=$true, Position=0)]
    [string]$ProjectPath,
    
    [Parameter(Mandatory=$true, Position=1)]
    [ValidateSet('Greenfield', 'Brownfield')]
    [string]$ProjectType
)

# Script configuration
$ErrorActionPreference = "Stop"
$ScriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
$RepoRoot = Split-Path -Parent $ScriptDir

# Color functions for output
function Write-Header {
    Write-Host "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━" -ForegroundColor Cyan
    Write-Host "  Modern Architecture 101 - Project Initialization" -ForegroundColor Cyan
    Write-Host "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━" -ForegroundColor Cyan
    Write-Host ""
}

function Write-Success {
    param([string]$Message)
    Write-Host "✓ $Message" -ForegroundColor Green
}

function Write-ErrorMsg {
    param([string]$Message)
    Write-Host "✗ $Message" -ForegroundColor Red
}

function Write-Warning {
    param([string]$Message)
    Write-Host "⚠ $Message" -ForegroundColor Yellow
}

function Write-Info {
    param([string]$Message)
    Write-Host "ℹ $Message" -ForegroundColor Cyan
}

function Initialize-GreenfieldProject {
    param([string]$Path)
    
    Write-Info "Initializing greenfield project..."
    
    # Create project directory if it doesn't exist
    if (-not (Test-Path $Path)) {
        New-Item -ItemType Directory -Path $Path -Force | Out-Null
        Write-Success "Created project directory"
    }
    
    # Initialize git if not already initialized
    $gitDir = Join-Path $Path ".git"
    if (-not (Test-Path $gitDir)) {
        Push-Location $Path
        try {
            git init 2>&1 | Out-Null
            Write-Success "Initialized git repository"
        }
        catch {
            Write-Warning "Failed to initialize git repository: $_"
        }
        finally {
            Pop-Location
        }
    }
    
    # Create standard project structure
    $directories = @("src", "tests", "docs")
    foreach ($dir in $directories) {
        $dirPath = Join-Path $Path $dir
        if (-not (Test-Path $dirPath)) {
            New-Item -ItemType Directory -Path $dirPath -Force | Out-Null
        }
    }
    Write-Success "Created standard project structure"
}

function Initialize-BrownfieldProject {
    param([string]$Path)
    
    Write-Info "Initializing brownfield project..."
    
    # Verify project exists
    if (-not (Test-Path $Path)) {
        Write-ErrorMsg "Project directory does not exist: $Path"
        exit 1
    }
    
    # Check if it's a git repository
    $gitDir = Join-Path $Path ".git"
    if (-not (Test-Path $gitDir)) {
        Write-Warning "Project is not a git repository"
        $response = Read-Host "Do you want to initialize git? (y/N)"
        if ($response -eq 'y' -or $response -eq 'Y') {
            Push-Location $Path
            try {
                git init 2>&1 | Out-Null
                Write-Success "Initialized git repository"
            }
            catch {
                Write-Warning "Failed to initialize git repository: $_"
            }
            finally {
                Pop-Location
            }
        }
    }
}

function New-BibleDirectory {
    param([string]$ProjectPath)
    
    $biblePath = Join-Path $ProjectPath ".bible"
    
    if (Test-Path $biblePath) {
        Write-Warning ".bible directory already exists"
        $response = Read-Host "Do you want to overwrite existing files? (y/N)"
        if ($response -ne 'y' -and $response -ne 'Y') {
            Write-Info "Skipping .bible directory creation"
            return $false
        }
    }
    
    New-Item -ItemType Directory -Path $biblePath -Force | Out-Null
    Write-Success "Created .bible directory at $biblePath"
    return $true
}

function Copy-CoreDocuments {
    param([string]$ProjectPath)
    
    $biblePath = Join-Path $ProjectPath ".bible"
    Write-Info "Copying core methodology documents..."
    
    # Copy BMAD integration documents
    $sourceBible = Join-Path $RepoRoot ".bible"
    if (Test-Path $sourceBible) {
        Get-ChildItem -Path $sourceBible -Filter "*.md" | ForEach-Object {
            Copy-Item -Path $_.FullName -Destination $biblePath -Force
        }
        Write-Success "Copied BMAD integration documents"
    }
    
    # Copy core principles
    $corePrinciples = Join-Path $RepoRoot "core-principles"
    if (Test-Path $corePrinciples) {
        Get-ChildItem -Path $corePrinciples -Filter "*.md" | ForEach-Object {
            Copy-Item -Path $_.FullName -Destination $biblePath -Force
        }
        Write-Success "Copied core principles"
    }
    
    # Copy ADR template
    $adrTemplate = Join-Path $RepoRoot "decision-frameworks\01-architecture-decision-record-template.md"
    if (Test-Path $adrTemplate) {
        Copy-Item -Path $adrTemplate -Destination $biblePath -Force
        Write-Success "Copied ADR template"
    }
    
    # Copy PRD template
    $prdTemplate = Join-Path $RepoRoot "prd-templates\01-architecture-aware-prd.md"
    if (Test-Path $prdTemplate) {
        Copy-Item -Path $prdTemplate -Destination $biblePath -Force
        Write-Success "Copied PRD template"
    }
}

function New-ProjectReadme {
    param([string]$ProjectPath)
    
    $biblePath = Join-Path $ProjectPath ".bible"
    $readmePath = Join-Path $biblePath "README.md"
    
    $content = @"
# Project Architecture Bible

This directory contains the architectural principles and methodology for this project, based on the **Modern-Architecture-101** methodology.

## Purpose

The ``.bible`` folder serves as the single source of truth for:
- Architectural principles guiding this project
- Architecture Decision Records (ADRs) documenting key decisions
- Integration guidelines for BMAD-METHOD and TDD practices
- Templates for PRDs and technical documentation

## Core Documents

### Principles
- **01-simplicity-is-the-best-architecture.md** - The foundational principle
- **02-context-over-dogma.md** - Making context-based decisions

### Integration
- **01-bmad-integration.md** - How this integrates with BMAD-METHOD
- **bmad-integration-summary.md** - Detailed integration workflow

### Templates
- **01-architecture-decision-record-template.md** - Template for ADRs
- **01-architecture-aware-prd.md** - Template for PRDs

## How to Use

1. **Read the core principles first** to understand the philosophy
2. **Use the ADR template** when making significant architectural decisions
3. **Reference the integration guide** to align with BMAD-METHOD
4. **Update this folder** as the project evolves with new learnings

## Architecture Decision Records

Create ADRs in this directory using the template. Name them sequentially:
- ``ADR-001-[decision-title].md``
- ``ADR-002-[decision-title].md``
- etc.

## Maintenance

This is a living document. Update it regularly with:
- New ADRs for architectural decisions
- Lessons learned from the project
- Refinements to the methodology based on experience

## Reference

This methodology is based on: https://github.com/dudleypeacockqa/Modern-Architecture-101
"@
    
    Set-Content -Path $readmePath -Value $content -Encoding UTF8
    Write-Success "Created .bible\README.md"
}

function New-AdrDirectory {
    param([string]$ProjectPath)
    
    $biblePath = Join-Path $ProjectPath ".bible"
    $adrPath = Join-Path $biblePath "decisions"
    
    New-Item -ItemType Directory -Path $adrPath -Force | Out-Null
    
    $gitkeepContent = @"
# Architecture Decision Records

Place your ADRs in this directory using the format:
ADR-001-[decision-title].md
"@
    
    $gitkeepPath = Join-Path $adrPath ".gitkeep"
    Set-Content -Path $gitkeepPath -Value $gitkeepContent -Encoding UTF8
    Write-Success "Created ADR directory at $adrPath"
}

function Update-GitIgnore {
    param([string]$ProjectPath)
    
    $gitignorePath = Join-Path $ProjectPath ".gitignore"
    
    # Create .gitignore if it doesn't exist
    if (-not (Test-Path $gitignorePath)) {
        New-Item -ItemType File -Path $gitignorePath -Force | Out-Null
        Write-Success "Created .gitignore"
    }
    
    # Check if .bible is already in .gitignore
    $content = Get-Content -Path $gitignorePath -Raw -ErrorAction SilentlyContinue
    if ($content -notmatch '\.bible') {
        $entry = @"

# Architecture methodology (keep in version control)
# .bible/
"@
        Add-Content -Path $gitignorePath -Value $entry -Encoding UTF8
        Write-Info "Added .bible comment to .gitignore (commented out to keep in version control)"
    }
}

function New-SetupSummary {
    param(
        [string]$ProjectPath,
        [string]$ProjectType
    )
    
    $biblePath = Join-Path $ProjectPath ".bible"
    $summaryPath = Join-Path $biblePath "SETUP-SUMMARY.md"
    $projectName = Split-Path -Leaf $ProjectPath
    $setupDate = Get-Date -Format "yyyy-MM-dd"
    
    $content = @"
# Architecture Setup Summary

**Project:** $projectName
**Setup Date:** $setupDate
**Project Type:** $ProjectType
**Methodology:** Modern-Architecture-101

## What Was Installed

This project has been initialized with the Modern-Architecture-101 methodology, which includes:

- ✅ Core architectural principles
- ✅ BMAD-METHOD integration guidelines
- ✅ Architecture Decision Record (ADR) template
- ✅ Architecture-aware PRD template
- ✅ TDD integration best practices

## Next Steps

1. **Read the core principles** in this directory
2. **Create your first ADR** when making your first architectural decision
3. **Use the PRD template** for your first feature
4. **Update the methodology** with learnings from this project

## Directory Structure

`````
.bible/
├── README.md                                    # This directory's purpose
├── SETUP-SUMMARY.md                             # This file
├── decisions/                                   # Your ADRs go here
├── 01-bmad-integration.md                       # BMAD integration guide
├── bmad-integration-summary.md                  # Detailed integration workflow
├── 01-simplicity-is-the-best-architecture.md    # Core principle #1
├── 02-context-over-dogma.md                     # Core principle #2
├── 01-architecture-decision-record-template.md  # ADR template
└── 01-architecture-aware-prd.md                 # PRD template
`````

## Methodology Reference

For the complete methodology, see: https://github.com/dudleypeacockqa/Modern-Architecture-101

## Updating the Methodology

As you learn from this project, contribute back to the core methodology:
1. Document new patterns and learnings
2. Create example ADRs
3. Update the core repository with improvements
"@
    
    Set-Content -Path $summaryPath -Value $content -Encoding UTF8
    Write-Success "Created setup summary"
}

function Write-CompletionMessage {
    param(
        [string]$ProjectPath,
        [string]$ProjectType
    )
    
    Write-Host ""
    Write-Host "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━" -ForegroundColor Green
    Write-Host "  ✓ Project Initialization Complete!" -ForegroundColor Green
    Write-Host "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━" -ForegroundColor Green
    Write-Host ""
    Write-Host "Project Path: " -NoNewline -ForegroundColor Cyan
    Write-Host $ProjectPath
    Write-Host "Project Type: " -NoNewline -ForegroundColor Cyan
    Write-Host $ProjectType
    Write-Host ""
    Write-Host "Next Steps:" -ForegroundColor Yellow
    Write-Host "  1. cd `"$ProjectPath`""
    Write-Host "  2. Get-Content .bible\README.md"
    Write-Host "  3. Read the core principles in .bible\"
    Write-Host "  4. Create your first ADR when making architectural decisions"
    Write-Host ""
    Write-Host "Reference: " -NoNewline -ForegroundColor Cyan
    Write-Host "https://github.com/dudleypeacockqa/Modern-Architecture-101"
    Write-Host ""
}

# Main execution
try {
    Write-Header
    
    # Resolve the full path
    $ProjectPath = $ExecutionContext.SessionState.Path.GetUnresolvedProviderPathFromPSPath($ProjectPath)
    
    # Initialize based on project type
    if ($ProjectType -eq 'Greenfield') {
        Initialize-GreenfieldProject -Path $ProjectPath
    }
    else {
        Initialize-BrownfieldProject -Path $ProjectPath
    }
    
    # Common setup steps
    $continue = New-BibleDirectory -ProjectPath $ProjectPath
    if ($continue) {
        Copy-CoreDocuments -ProjectPath $ProjectPath
        New-ProjectReadme -ProjectPath $ProjectPath
        New-AdrDirectory -ProjectPath $ProjectPath
        Update-GitIgnore -ProjectPath $ProjectPath
        New-SetupSummary -ProjectPath $ProjectPath -ProjectType $ProjectType
    }
    
    Write-CompletionMessage -ProjectPath $ProjectPath -ProjectType $ProjectType
}
catch {
    Write-ErrorMsg "An error occurred: $_"
    Write-Host $_.ScriptStackTrace -ForegroundColor Red
    exit 1
}
