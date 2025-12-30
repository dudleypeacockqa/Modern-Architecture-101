#!/bin/bash
# Project Initialization Script (Unix/macOS/Linux)
# Usage: ./scripts/init-project.sh <project-name> [greenfield|brownfield]

set -e

PROJECT_NAME=${1:-"new-project"}
PROJECT_TYPE=${2:-"greenfield"}

echo "Initializing $PROJECT_TYPE project: $PROJECT_NAME"
echo "============================================="

# Create directory structure
if [ "$PROJECT_TYPE" = "greenfield" ]; then
    echo "Creating greenfield project structure..."
    
    mkdir -p "$PROJECT_NAME"/{docs/{01_strategy/prd,02_architecture},bmad/intents,src,tests/{unit,integration,e2e},.claude}
    
    # Copy templates
    cp tool-configs/CLAUDE.md "$PROJECT_NAME/.claude/CLAUDE.md"
    
    # Create basic files
    cat > "$PROJECT_NAME/docs/prd.md" << 'EOF'
# Product Requirements Document

## Overview
[Project overview here]

## Goals
[Project goals here]

## Requirements
[Requirements here]
EOF

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

    cat > "$PROJECT_NAME/.env.example" << 'EOF'
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
EOF

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
    mkdir -p docs/{01_strategy/prd,02_architecture}
    mkdir -p bmad/intents
    mkdir -p .claude
    mkdir -p tests/{unit,integration,e2e}
    
    # Copy Claude config if not exists
    if [ ! -f ".claude/CLAUDE.md" ]; then
        cp tool-configs/CLAUDE.md .claude/CLAUDE.md
        echo "Added .claude/CLAUDE.md"
    fi
    
    # Create env example if not exists
    if [ ! -f ".env.example" ]; then
        cat > ".env.example" << 'EOF'
# Add your environment variables here
EOF
        echo "Added .env.example"
    fi
fi

echo ""
echo "Project initialized successfully!"
echo ""
echo "Next steps:"
echo "1. Review and customize .claude/CLAUDE.md"
echo "2. Update docs/prd.md with your requirements"
echo "3. Create intents in bmad/intents/"
echo "4. Copy .env.example to .env and configure"
echo "5. Start with TDD - write tests first!"
