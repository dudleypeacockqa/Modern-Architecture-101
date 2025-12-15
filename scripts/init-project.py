#!/usr/bin/env python3
"""
Modern Architecture 101 - Project Initialization Script (Python)

This script automates the integration of the Modern-Architecture-101
methodology into both greenfield (new) and brownfield (existing) projects.

Usage:
    python init-project.py [PROJECT_PATH] [--greenfield|--brownfield]

Examples:
    python init-project.py ~/my-new-app --greenfield
    python init-project.py ~/existing-app --brownfield
"""

import os
import sys
import shutil
import argparse
from pathlib import Path
from datetime import datetime
from typing import Optional

# ANSI color codes
class Colors:
    RED = '\033[0;31m'
    GREEN = '\033[0;32m'
    YELLOW = '\033[1;33m'
    BLUE = '\033[0;34m'
    NC = '\033[0m'  # No Color


class ProjectInitializer:
    """Handles the initialization of projects with Modern-Architecture-101 methodology."""
    
    def __init__(self, project_path: str, project_type: str):
        self.project_path = Path(project_path).expanduser().resolve()
        self.project_type = project_type
        self.script_dir = Path(__file__).parent
        self.repo_root = self.script_dir.parent
        self.bible_path = self.project_path / '.bible'
        
    def print_header(self):
        """Print the script header."""
        print(f"{Colors.BLUE}{'━' * 60}{Colors.NC}")
        print(f"{Colors.BLUE}  Modern Architecture 101 - Project Initialization{Colors.NC}")
        print(f"{Colors.BLUE}{'━' * 60}{Colors.NC}\n")
    
    def print_success(self, message: str):
        """Print a success message."""
        print(f"{Colors.GREEN}✓{Colors.NC} {message}")
    
    def print_error(self, message: str):
        """Print an error message."""
        print(f"{Colors.RED}✗{Colors.NC} {message}")
    
    def print_warning(self, message: str):
        """Print a warning message."""
        print(f"{Colors.YELLOW}⚠{Colors.NC} {message}")
    
    def print_info(self, message: str):
        """Print an info message."""
        print(f"{Colors.BLUE}ℹ{Colors.NC} {message}")
    
    def create_bible_directory(self) -> bool:
        """Create the .bible directory."""
        if self.bible_path.exists():
            self.print_warning(".bible directory already exists")
            response = input("Do you want to overwrite existing files? (y/N): ").strip().lower()
            if response != 'y':
                self.print_info("Skipping .bible directory creation")
                return False
        
        self.bible_path.mkdir(parents=True, exist_ok=True)
        self.print_success(f"Created .bible directory at {self.bible_path}")
        return True
    
    def copy_core_documents(self):
        """Copy core methodology documents to the project."""
        self.print_info("Copying core methodology documents...")
        
        # Copy BMAD integration documents
        source_bible = self.repo_root / '.bible'
        if source_bible.exists():
            for file in source_bible.glob('*.md'):
                shutil.copy2(file, self.bible_path)
            self.print_success("Copied BMAD integration documents")
        
        # Copy core principles
        core_principles = self.repo_root / 'core-principles'
        if core_principles.exists():
            for file in core_principles.glob('*.md'):
                shutil.copy2(file, self.bible_path)
            self.print_success("Copied core principles")
        
        # Copy ADR template
        adr_template = self.repo_root / 'decision-frameworks' / '01-architecture-decision-record-template.md'
        if adr_template.exists():
            shutil.copy2(adr_template, self.bible_path)
            self.print_success("Copied ADR template")
        
        # Copy PRD template
        prd_template = self.repo_root / 'prd-templates' / '01-architecture-aware-prd.md'
        if prd_template.exists():
            shutil.copy2(prd_template, self.bible_path)
            self.print_success("Copied PRD template")
    
    def create_project_readme(self):
        """Create the .bible/README.md file."""
        readme_content = """# Project Architecture Bible

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
"""
        
        readme_path = self.bible_path / 'README.md'
        readme_path.write_text(readme_content)
        self.print_success("Created .bible/README.md")
    
    def create_adr_directory(self):
        """Create the ADR directory."""
        adr_path = self.bible_path / 'decisions'
        adr_path.mkdir(exist_ok=True)
        
        gitkeep_content = """# Architecture Decision Records

Place your ADRs in this directory using the format:
ADR-001-[decision-title].md
"""
        (adr_path / '.gitkeep').write_text(gitkeep_content)
        self.print_success(f"Created ADR directory at {adr_path}")
    
    def init_greenfield_project(self):
        """Initialize a greenfield project."""
        self.print_info("Initializing greenfield project...")
        
        # Create project directory if it doesn't exist
        if not self.project_path.exists():
            self.project_path.mkdir(parents=True)
            self.print_success("Created project directory")
        
        # Initialize git if not already initialized
        git_dir = self.project_path / '.git'
        if not git_dir.exists():
            os.system(f"cd {self.project_path} && git init")
            self.print_success("Initialized git repository")
        
        # Create standard project structure
        (self.project_path / 'src').mkdir(exist_ok=True)
        (self.project_path / 'tests').mkdir(exist_ok=True)
        (self.project_path / 'docs').mkdir(exist_ok=True)
        self.print_success("Created standard project structure")
    
    def init_brownfield_project(self):
        """Initialize a brownfield project."""
        self.print_info("Initializing brownfield project...")
        
        # Verify project exists
        if not self.project_path.exists():
            self.print_error(f"Project directory does not exist: {self.project_path}")
            sys.exit(1)
        
        # Check if it's a git repository
        git_dir = self.project_path / '.git'
        if not git_dir.exists():
            self.print_warning("Project is not a git repository")
            response = input("Do you want to initialize git? (y/N): ").strip().lower()
            if response == 'y':
                os.system(f"cd {self.project_path} && git init")
                self.print_success("Initialized git repository")
    
    def create_gitignore_entry(self):
        """Add .bible to .gitignore (commented out)."""
        gitignore_path = self.project_path / '.gitignore'
        
        # Create .gitignore if it doesn't exist
        if not gitignore_path.exists():
            gitignore_path.touch()
            self.print_success("Created .gitignore")
        
        # Check if .bible is already in .gitignore
        content = gitignore_path.read_text()
        if '.bible' not in content:
            with gitignore_path.open('a') as f:
                f.write("\n# Architecture methodology (keep in version control)\n")
                f.write("# .bible/\n")
            self.print_info("Added .bible comment to .gitignore (commented out to keep in version control)")
    
    def create_setup_summary(self):
        """Create a setup summary document."""
        project_name = self.project_path.name
        setup_date = datetime.now().strftime("%Y-%m-%d")
        
        summary_content = f"""# Architecture Setup Summary

**Project:** {project_name}
**Setup Date:** {setup_date}
**Project Type:** {self.project_type}
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

```
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
```

## Methodology Reference

For the complete methodology, see: https://github.com/dudleypeacockqa/Modern-Architecture-101

## Updating the Methodology

As you learn from this project, contribute back to the core methodology:
1. Document new patterns and learnings
2. Create example ADRs
3. Update the core repository with improvements
"""
        
        summary_path = self.bible_path / 'SETUP-SUMMARY.md'
        summary_path.write_text(summary_content)
        self.print_success("Created setup summary")
    
    def print_completion_message(self):
        """Print the completion message."""
        print(f"\n{Colors.GREEN}{'━' * 60}{Colors.NC}")
        print(f"{Colors.GREEN}  ✓ Project Initialization Complete!{Colors.NC}")
        print(f"{Colors.GREEN}{'━' * 60}{Colors.NC}\n")
        print(f"{Colors.BLUE}Project Path:{Colors.NC} {self.project_path}")
        print(f"{Colors.BLUE}Project Type:{Colors.NC} {self.project_type}\n")
        print(f"{Colors.YELLOW}Next Steps:{Colors.NC}")
        print(f"  1. cd {self.project_path}")
        print(f"  2. Review .bible/README.md for guidance")
        print(f"  3. Read the core principles in .bible/")
        print(f"  4. Create your first ADR when making architectural decisions\n")
        print(f"{Colors.BLUE}Reference:{Colors.NC} https://github.com/dudleypeacockqa/Modern-Architecture-101\n")
    
    def run(self):
        """Execute the initialization process."""
        self.print_header()
        
        # Initialize based on project type
        if self.project_type == 'greenfield':
            self.init_greenfield_project()
        else:
            self.init_brownfield_project()
        
        # Common setup steps
        self.create_bible_directory()
        self.copy_core_documents()
        self.create_project_readme()
        self.create_adr_directory()
        self.create_gitignore_entry()
        self.create_setup_summary()
        
        self.print_completion_message()


def main():
    """Main entry point."""
    parser = argparse.ArgumentParser(
        description='Initialize a project with Modern-Architecture-101 methodology',
        formatter_class=argparse.RawDescriptionHelpFormatter,
        epilog="""
Examples:
  python init-project.py ~/my-new-app --greenfield
  python init-project.py ~/existing-app --brownfield
        """
    )
    
    parser.add_argument('project_path', help='Path to your project directory')
    parser.add_argument(
        'project_type',
        choices=['--greenfield', '--brownfield'],
        help='Type of project initialization'
    )
    
    args = parser.parse_args()
    
    # Remove the -- prefix from project_type
    project_type = args.project_type.replace('--', '')
    
    # Create and run the initializer
    initializer = ProjectInitializer(args.project_path, project_type)
    initializer.run()


if __name__ == '__main__':
    main()
