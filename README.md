# Modern Architecture 101

A living, updatable methodology for modern software architecture, designed to integrate with BMAD-method and Test-Driven Development (TDD) practices. This repository serves as the **standard reference** for all projects, ensuring consistency and avoiding drift across greenfield and brownfield implementations.

## Philosophy

This methodology is founded on the core principle that **simplicity is the best architecture**. It advocates for a pragmatic approach where the architect acts as a guardian against unnecessary complexity, making informed decisions based on context rather than dogma.

This repository incorporates **proven lessons learned from FloCommand** and is continuously updated with insights from every project.

## Quick Start

### Greenfield Project (Windows PowerShell)
```powershell
git clone https://github.com/dudleypeacockqa/Modern-Architecture-101.git
cd Modern-Architecture-101
.\scripts\init-project.ps1 -ProjectName "my-new-project" -ProjectType "greenfield"
```

### Brownfield Project (Add to Existing)
```powershell
# From your existing project root
.\path\to\Modern-Architecture-101\scripts\init-project.ps1 -ProjectName "." -ProjectType "brownfield"
```

### Using Git Bash / WSL
```bash
git clone https://github.com/dudleypeacockqa/Modern-Architecture-101.git
cd Modern-Architecture-101
./scripts/init-project.sh my-new-project greenfield
```

## What Gets Created

The initialization scripts create:

```
my-new-project/
├── .claude/
│   └── CLAUDE.md              # Claude Code BMAD+TDD rules
├── docs/
│   ├── NORTH_STAR.md          # Single source of truth index
│   ├── 00_System_Vision_and_Strategy.md
│   ├── 01_strategy/
│   │   ├── prd/
│   │   │   └── index.md       # PRD entry point
│   │   └── BMAD_SINGLE_SOURCE_OF_TRUTH.md
│   └── 02_architecture/
│       └── architecture.md
├── bmad/
│   └── intents/
│       └── intent-01-example.md
├── tests/
│   ├── unit/
│   ├── integration/
│   └── e2e/
├── .env.example
└── pytest.ini
```

## Repository Structure

### Core Methodology
- **/.bible** - BMAD integration and methodology bridge documents
  - `01-bmad-integration.md` - How BMAD and Architecture work together
  - `02-flocommand-lessons-learned.md` - Proven patterns from production
  - `03-standard-integrations.md` - Standard tech stack (Clerk, Linear, PostgreSQL, Render)
- **/core-principles** - Foundational architectural beliefs
- **/architecture-patterns** - Common architectural patterns analysis
- **/decision-frameworks** - ADR templates and decision tools

### TDD & Testing
- **/tdd-integration** - TDD workflow guides and best practices
  - `01-tdd-and-modern-architecture.md` - TDD synergy with architecture
  - `02-tdd-workflow-guide.md` - Practical TDD workflow (Red-Green-Refactor)

### Tool Configurations
- **/tool-configs** - Standardized AI assistant and IDE configurations
  - `CLAUDE.md` - Claude Code system rules (BMAD + TDD)
  - `claude-code-capabilities.md` - Claude Code skills and MCP servers
  - `cursor-settings.json` - Cursor IDE integration settings
  - `linear-integration.md` - Linear fault management integration

### Templates
- **/templates** - Project templates
  - `NORTH_STAR.md` - Single source of truth template
- **/prd-templates** - Standardized PRD templates
- **/scripts** - Project initialization scripts (Windows PowerShell + Bash)

## Key Integrations

| Integration | Purpose | Documentation |
|-------------|---------|---------------|
| **Clerk** | Authentication | [Standard Setup](.bible/03-standard-integrations.md#authentication-clerk) |
| **Linear** | Issue Tracking & Faults | [linear-integration-module](https://github.com/dudleypeacockqa/linear-integration-module) |
| **PostgreSQL** | Database | [Standard Setup](.bible/03-standard-integrations.md#database-postgresql-direct-or-via-render) |
| **Render** | Deployment | [Standard Setup](.bible/03-standard-integrations.md#deployment-render) |

## Claude Code Capabilities

See [claude-code-capabilities.md](tool-configs/claude-code-capabilities.md) for:

- Core file/shell/web operations
- Required MCP server configurations
- Skill definitions (Code Analysis, TDD Implementation, Git Operations)
- Capability restrictions and best practices

## BMAD + TDD Workflow

Every task follows this workflow:

1. **Clarify** - Restate the task
2. **Locate Requirements** - Find relevant intents/PRD (BMAD)
3. **Design Tests** - Write tests BEFORE implementation (TDD)
4. **Implement** - Minimum code to pass tests
5. **Verify** - Run tests and report results

See [CLAUDE.md](tool-configs/CLAUDE.md) for complete rules.

## North Star Document

Every project should have a `docs/NORTH_STAR.md` file that serves as the single source of truth for finding authoritative documents. See [templates/NORTH_STAR.md](templates/NORTH_STAR.md) for the template.

The North Star defines:
- Document status legend (USE THIS, SUPERSEDED, ARCHIVED, INDEX, SUPPLEMENT)
- Quick reference table for all core documents
- Usage guidelines for different roles
- Maintenance procedures

## Lessons Learned

The [FloCommand Lessons Learned](.bible/02-flocommand-lessons-learned.md) document captures proven patterns:

- Always mount API routes under `/api` prefix
- Test at API boundaries, not just unit tests
- Verify webhook signatures in production
- Use PKCE for OAuth flows
- Never claim success without test verification

## For Windows Users

All development is standardized on Windows with PowerShell. See [WINDOWS-SETUP-GUIDE.md](WINDOWS-SETUP-GUIDE.md) for setup instructions.

## Contribution

This is a living methodology. Update it with lessons from each project:

1. Document the lesson in `.bible/02-flocommand-lessons-learned.md`
2. Update relevant guides if patterns change
3. Add new tool configurations as needed
4. Keep examples current with best practices

---

*Inspired by "Modern Architecture 101" by Jerry Nixon at NDC Copenhagen 2025*
