# Modern Architecture 101

A living, updatable methodology for modern software architecture, designed to integrate with BMAD-method and Test-Driven Development (TDD) practices. This repository serves as the **standard reference** for all projects, ensuring consistency and avoiding drift across greenfield and brownfield implementations.

## Philosophy

This methodology is founded on the core principle that **simplicity is the best architecture**. It advocates for a pragmatic approach where the architect acts as a guardian against unnecessary complexity, making informed decisions based on context rather than dogma.

This repository incorporates **proven lessons learned from FloCommand** and is continuously updated with insights from every project.

## Quick Start

### Greenfield Project (Unix/macOS)
```bash
git clone https://github.com/dudleypeacockqa/Modern-Architecture-101.git
cd Modern-Architecture-101
./scripts/init-project.sh my-new-project greenfield
```

### Greenfield Project (Windows PowerShell)
```powershell
git clone https://github.com/dudleypeacockqa/Modern-Architecture-101.git
cd Modern-Architecture-101
.\scripts\init-project.ps1 -ProjectName "my-new-project" -ProjectType "greenfield"
```

### Brownfield Project (Add to Existing)
```bash
# From your existing project root
./path/to/Modern-Architecture-101/scripts/init-project.sh . brownfield
```

## Repository Structure

### Core Methodology
- **/.bible** - BMAD integration and methodology bridge documents
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
  - `cursor-settings.json` - Cursor IDE integration settings
  - `linear-integration.md` - Linear fault management integration

### Templates & Examples
- **/prd-templates** - Standardized PRD templates
- **/technology-stacks** - Language and framework guidance
- **/examples** - Real-world application examples
- **/scripts** - Project initialization scripts

## Key Integrations

| Integration | Purpose | Documentation |
|-------------|---------|---------------|
| **Clerk** | Authentication | [Standard Setup](.bible/03-standard-integrations.md#authentication-clerk) |
| **Linear** | Issue Tracking & Faults | [linear-integration-module](https://github.com/dudleypeacockqa/linear-integration-module) |
| **Supabase** | Database (PostgreSQL) | [Standard Setup](.bible/03-standard-integrations.md#database-supabasepostgresql) |
| **Render** | Deployment | [Standard Setup](.bible/03-standard-integrations.md#deployment-render) |

## BMAD + TDD Workflow

Every task follows this workflow:

1. **Clarify** - Restate the task
2. **Locate Requirements** - Find relevant intents/PRD (BMAD)
3. **Design Tests** - Write tests BEFORE implementation (TDD)
4. **Implement** - Minimum code to pass tests
5. **Verify** - Run tests and report results

See [CLAUDE.md](tool-configs/CLAUDE.md) for complete rules.

## Lessons Learned

The [FloCommand Lessons Learned](.bible/02-flocommand-lessons-learned.md) document captures proven patterns:

- Always mount API routes under `/api` prefix
- Test at API boundaries, not just unit tests
- Verify webhook signatures in production
- Use PKCE for OAuth flows
- Never claim success without test verification

## For Windows Users

See [WINDOWS-SETUP-GUIDE.md](WINDOWS-SETUP-GUIDE.md) for PowerShell-specific instructions.

## Contribution

This is a living methodology. Update it with lessons from each project:

1. Document the lesson in `.bible/02-flocommand-lessons-learned.md`
2. Update relevant guides if patterns change
3. Add new tool configurations as needed
4. Keep examples current with best practices

---

*Inspired by "Modern Architecture 101" by Jerry Nixon at NDC Copenhagen 2025*
