#!/bin/bash
# Project Initialization Script (Windows Git Bash / WSL)
# Usage: ./scripts/init-project.sh <project-name> [greenfield|brownfield]

set -e

PROJECT_NAME=${1:-"new-project"}
PROJECT_TYPE=${2:-"greenfield"}
DATE=$(date +%Y-%m-%d)

echo "Initializing $PROJECT_TYPE project: $PROJECT_NAME"
echo "============================================="

# Create directory structure
if [ "$PROJECT_TYPE" = "greenfield" ]; then
    echo "Creating greenfield project structure..."
    
    mkdir -p "$PROJECT_NAME"/{docs/{00_overview,01_strategy/prd,02_architecture,04_project_management/stories},bmad/intents,src,tests/{unit,integration,e2e},.claude}
    
    # Copy templates
    cp tool-configs/CLAUDE.md "$PROJECT_NAME/.claude/CLAUDE.md"
    cp templates/NORTH_STAR.md "$PROJECT_NAME/docs/NORTH_STAR.md"
    
    # Create Vision template
    cat > "$PROJECT_NAME/docs/00_System_Vision_and_Strategy.md" << EOF
# System Vision and Strategy

**Last Updated**: $DATE
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

See \`docs/02_architecture/architecture.md\` for detailed architecture.
EOF

    # Create PRD index
    cat > "$PROJECT_NAME/docs/01_strategy/prd/index.md" << EOF
# Product Requirements Document

**Version**: 1.0
**Last Updated**: $DATE

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
EOF

    # Create BMAD Single Source of Truth
    cat > "$PROJECT_NAME/docs/01_strategy/BMAD_SINGLE_SOURCE_OF_TRUTH.md" << 'EOF'
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
EOF

    # Create architecture template
    cat > "$PROJECT_NAME/docs/02_architecture/architecture.md" << EOF
# Architecture

**Version**: 1.0
**Last Updated**: $DATE

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
EOF

    # Create intent template
    cat > "$PROJECT_NAME/bmad/intents/intent-01-example.md" << 'EOF'
# Intent 01: Example Feature

## Description
[Feature description]

## Acceptance Criteria
- [ ] Criterion 1
- [ ] Criterion 2

## TDD Scenarios

### Scenario 1: Happy Path
```gherkin
Given [context]
When [action]
Then [result]
```
EOF

    # Create .env.example
    cat > "$PROJECT_NAME/.env.example" << 'EOF'
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
EOF

    # Create pytest.ini
    cat > "$PROJECT_NAME/pytest.ini" << 'EOF'
[pytest]
testpaths = tests
python_files = test_*.py
python_functions = test_*
addopts = -v --tb=short
EOF

else
    echo "Brownfield project - adding BMAD structure to existing project..."
    
    # Add missing directories
    mkdir -p docs/{00_overview,01_strategy/prd,02_architecture,04_project_management/stories}
    mkdir -p bmad/intents
    mkdir -p .claude
    mkdir -p tests/{unit,integration,e2e}
    
    # Copy Claude config if not exists
    if [ ! -f ".claude/CLAUDE.md" ]; then
        cp tool-configs/CLAUDE.md .claude/CLAUDE.md
        echo "Added .claude/CLAUDE.md"
    fi
    
    # Copy North Star if not exists
    if [ ! -f "docs/NORTH_STAR.md" ]; then
        cp templates/NORTH_STAR.md docs/NORTH_STAR.md
        echo "Added docs/NORTH_STAR.md"
    fi
    
    # Create env example if not exists
    if [ ! -f ".env.example" ]; then
        echo "# Add your environment variables here" > .env.example
        echo "Added .env.example"
    fi
fi

echo ""
echo "Project initialized successfully!"
echo ""
echo "Next steps:"
echo "1. Review and customize .claude/CLAUDE.md"
echo "2. Update docs/NORTH_STAR.md with your document locations"
echo "3. Update docs/00_System_Vision_and_Strategy.md with your vision"
echo "4. Update docs/01_strategy/prd/index.md with your requirements"
echo "5. Create intents in bmad/intents/"
echo "6. Copy .env.example to .env and configure"
echo "7. Start with TDD - write tests first!"
