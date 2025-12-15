#!/bin/bash

################################################################################
# Modern Architecture 101 - Project Initialization Script
#
# This script automates the integration of the Modern-Architecture-101
# methodology into both greenfield (new) and brownfield (existing) projects.
#
# Usage:
#   ./init-project.sh [PROJECT_PATH] [--greenfield|--brownfield]
#
# Examples:
#   ./init-project.sh ~/my-new-app --greenfield
#   ./init-project.sh ~/existing-app --brownfield
################################################################################

set -e  # Exit on error

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Script directory (where this script is located)
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
REPO_ROOT="$(dirname "$SCRIPT_DIR")"

# Default values
PROJECT_PATH=""
PROJECT_TYPE=""

################################################################################
# Helper Functions
################################################################################

print_header() {
    echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    echo -e "${BLUE}  Modern Architecture 101 - Project Initialization${NC}"
    echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    echo ""
}

print_success() {
    echo -e "${GREEN}✓${NC} $1"
}

print_error() {
    echo -e "${RED}✗${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}⚠${NC} $1"
}

print_info() {
    echo -e "${BLUE}ℹ${NC} $1"
}

show_usage() {
    cat << EOF
Usage: $0 [PROJECT_PATH] [--greenfield|--brownfield]

Arguments:
  PROJECT_PATH          Path to your project directory
  --greenfield          Initialize a new (greenfield) project
  --brownfield          Initialize an existing (brownfield) project

Examples:
  $0 ~/my-new-app --greenfield
  $0 ~/existing-app --brownfield

Options:
  -h, --help           Show this help message

EOF
}

################################################################################
# Main Functions
################################################################################

parse_arguments() {
    if [[ $# -eq 0 ]] || [[ "$1" == "-h" ]] || [[ "$1" == "--help" ]]; then
        show_usage
        exit 0
    fi

    PROJECT_PATH="$1"
    PROJECT_TYPE="$2"

    if [[ -z "$PROJECT_PATH" ]]; then
        print_error "Project path is required"
        show_usage
        exit 1
    fi

    if [[ "$PROJECT_TYPE" != "--greenfield" ]] && [[ "$PROJECT_TYPE" != "--brownfield" ]]; then
        print_error "Project type must be either --greenfield or --brownfield"
        show_usage
        exit 1
    fi
}

create_bible_directory() {
    local bible_path="$PROJECT_PATH/.bible"
    
    if [[ -d "$bible_path" ]]; then
        print_warning ".bible directory already exists"
        read -p "Do you want to overwrite existing files? (y/N): " -n 1 -r
        echo
        if [[ ! $REPLY =~ ^[Yy]$ ]]; then
            print_info "Skipping .bible directory creation"
            return 0
        fi
    fi

    mkdir -p "$bible_path"
    print_success "Created .bible directory at $bible_path"
}

copy_core_documents() {
    local bible_path="$PROJECT_PATH/.bible"
    
    print_info "Copying core methodology documents..."
    
    # Copy BMAD integration documents
    if [[ -d "$REPO_ROOT/.bible" ]]; then
        cp "$REPO_ROOT/.bible"/*.md "$bible_path/" 2>/dev/null || true
        print_success "Copied BMAD integration documents"
    fi
    
    # Copy core principles
    if [[ -d "$REPO_ROOT/core-principles" ]]; then
        cp "$REPO_ROOT/core-principles"/*.md "$bible_path/" 2>/dev/null || true
        print_success "Copied core principles"
    fi
    
    # Copy ADR template
    if [[ -f "$REPO_ROOT/decision-frameworks/01-architecture-decision-record-template.md" ]]; then
        cp "$REPO_ROOT/decision-frameworks/01-architecture-decision-record-template.md" "$bible_path/" 2>/dev/null || true
        print_success "Copied ADR template"
    fi
    
    # Copy PRD template
    if [[ -f "$REPO_ROOT/prd-templates/01-architecture-aware-prd.md" ]]; then
        cp "$REPO_ROOT/prd-templates/01-architecture-aware-prd.md" "$bible_path/" 2>/dev/null || true
        print_success "Copied PRD template"
    fi
}

create_project_readme() {
    local bible_path="$PROJECT_PATH/.bible"
    local readme_path="$bible_path/README.md"
    
    cat > "$readme_path" << 'EOF'
# Project Architecture Bible

This directory contains the architectural principles and methodology for this project, based on the **Modern-Architecture-101** methodology.

## Purpose

The `.bible` folder serves as the single source of truth for:
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
- `ADR-001-[decision-title].md`
- `ADR-002-[decision-title].md`
- etc.

## Maintenance

This is a living document. Update it regularly with:
- New ADRs for architectural decisions
- Lessons learned from the project
- Refinements to the methodology based on experience

## Reference

This methodology is based on: https://github.com/dudleypeacockqa/Modern-Architecture-101
EOF

    print_success "Created .bible/README.md"
}

create_adr_directory() {
    local bible_path="$PROJECT_PATH/.bible"
    local adr_path="$bible_path/decisions"
    
    mkdir -p "$adr_path"
    
    # Create a sample ADR
    cat > "$adr_path/.gitkeep" << 'EOF'
# Architecture Decision Records

Place your ADRs in this directory using the format:
ADR-001-[decision-title].md
EOF

    print_success "Created ADR directory at $bible_path/decisions"
}

init_greenfield_project() {
    print_info "Initializing greenfield project..."
    
    # Create project directory if it doesn't exist
    if [[ ! -d "$PROJECT_PATH" ]]; then
        mkdir -p "$PROJECT_PATH"
        print_success "Created project directory"
    fi
    
    # Initialize git if not already initialized
    if [[ ! -d "$PROJECT_PATH/.git" ]]; then
        cd "$PROJECT_PATH"
        git init
        print_success "Initialized git repository"
    fi
    
    # Create standard project structure
    mkdir -p "$PROJECT_PATH/src"
    mkdir -p "$PROJECT_PATH/tests"
    mkdir -p "$PROJECT_PATH/docs"
    print_success "Created standard project structure"
}

init_brownfield_project() {
    print_info "Initializing brownfield project..."
    
    # Verify project exists
    if [[ ! -d "$PROJECT_PATH" ]]; then
        print_error "Project directory does not exist: $PROJECT_PATH"
        exit 1
    fi
    
    # Check if it's a git repository
    if [[ ! -d "$PROJECT_PATH/.git" ]]; then
        print_warning "Project is not a git repository"
        read -p "Do you want to initialize git? (y/N): " -n 1 -r
        echo
        if [[ $REPLY =~ ^[Yy]$ ]]; then
            cd "$PROJECT_PATH"
            git init
            print_success "Initialized git repository"
        fi
    fi
}

create_gitignore_entry() {
    local gitignore_path="$PROJECT_PATH/.gitignore"
    
    # Check if .gitignore exists
    if [[ ! -f "$gitignore_path" ]]; then
        touch "$gitignore_path"
        print_success "Created .gitignore"
    fi
    
    # Check if .bible is already in .gitignore
    if ! grep -q "^\.bible" "$gitignore_path" 2>/dev/null; then
        echo "" >> "$gitignore_path"
        echo "# Architecture methodology (keep in version control)" >> "$gitignore_path"
        echo "# .bible/" >> "$gitignore_path"
        print_info "Added .bible comment to .gitignore (commented out to keep in version control)"
    fi
}

create_setup_summary() {
    local summary_path="$PROJECT_PATH/.bible/SETUP-SUMMARY.md"
    local project_name=$(basename "$PROJECT_PATH")
    local setup_date=$(date +"%Y-%m-%d")
    
    cat > "$summary_path" << EOF
# Architecture Setup Summary

**Project:** $project_name
**Setup Date:** $setup_date
**Project Type:** ${PROJECT_TYPE/--/}
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

\`\`\`
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
\`\`\`

## Methodology Reference

For the complete methodology, see: https://github.com/dudleypeacockqa/Modern-Architecture-101

## Updating the Methodology

As you learn from this project, contribute back to the core methodology:
1. Document new patterns and learnings
2. Create example ADRs
3. Update the core repository with improvements
EOF

    print_success "Created setup summary"
}

print_completion_message() {
    echo ""
    echo -e "${GREEN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    echo -e "${GREEN}  ✓ Project Initialization Complete!${NC}"
    echo -e "${GREEN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    echo ""
    echo -e "${BLUE}Project Path:${NC} $PROJECT_PATH"
    echo -e "${BLUE}Project Type:${NC} ${PROJECT_TYPE/--/}"
    echo ""
    echo -e "${YELLOW}Next Steps:${NC}"
    echo "  1. cd $PROJECT_PATH"
    echo "  2. Review .bible/README.md for guidance"
    echo "  3. Read the core principles in .bible/"
    echo "  4. Create your first ADR when making architectural decisions"
    echo ""
    echo -e "${BLUE}Reference:${NC} https://github.com/dudleypeacockqa/Modern-Architecture-101"
    echo ""
}

################################################################################
# Main Execution
################################################################################

main() {
    print_header
    parse_arguments "$@"
    
    # Initialize based on project type
    if [[ "$PROJECT_TYPE" == "--greenfield" ]]; then
        init_greenfield_project
    else
        init_brownfield_project
    fi
    
    # Common setup steps
    create_bible_directory
    copy_core_documents
    create_project_readme
    create_adr_directory
    create_gitignore_entry
    create_setup_summary
    
    print_completion_message
}

# Run main function
main "$@"
