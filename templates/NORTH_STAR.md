# Project North Star - Single Source of Truth

**Last Updated**: YYYY-MM-DD
**Version**: 1.0
**Purpose**: Master index of all authoritative project documents
**Status**: Authoritative Reference Document

> **IMPORTANT**: This document is the single entry point for finding authoritative project documents. Always start here when looking for canonical versions of Vision, PRD, Epics, Architecture, or other core documents.

---

## Quick Reference Table

| Document Type | Primary Location | Status |
|--------------|------------------|--------|
| **Vision & Strategy** | `docs/00_System_Vision_and_Strategy.md` | USE THIS |
| **PRD (Consolidated)** | `docs/01_strategy/prd/index.md` | USE THIS |
| **Epic Index** | `docs/EPIC_INDEX.md` | INDEX |
| **Epics** | `docs/01_strategy/prd/epic-*.md` | USE THIS |
| **Stories** | `docs/04_project_management/stories/` | USE THIS |
| **Architecture** | `docs/02_architecture/architecture.md` | USE THIS |
| **BMAD Methodology** | `docs/01_strategy/BMAD_SINGLE_SOURCE_OF_TRUTH.md` | USE THIS |

---

## Key Highlights

- **Vision**: `docs/00_System_Vision_and_Strategy.md`
- **PRD**: `docs/01_strategy/prd/index.md`
- **Architecture**: `docs/02_architecture/architecture.md`
- **Stories**: `docs/04_project_management/stories/`
- **BMAD Single Source**: `docs/01_strategy/BMAD_SINGLE_SOURCE_OF_TRUTH.md`

---

## Core Documents (USE THESE)

### Vision & Strategy

**PRIMARY**: [`docs/00_System_Vision_and_Strategy.md`](./00_System_Vision_and_Strategy.md)

- **Status**: Authoritative Source of Truth
- **Owner**: Product & Architecture Leadership
- **Purpose**: Defines the single canonical vision for the project, including business goals, customer journey, core workflow, platform architecture, and implementation north star.

---

### Product Requirements Document (PRD)

**PRIMARY**: [`docs/01_strategy/prd/index.md`](./01_strategy/prd/index.md)

- **Status**: PRIMARY DOCUMENT
- **Purpose**: Consolidated PRD with all functional requirements. Single source of truth for implementation.

**PRD Components** (accessed via index.md):

- `goals-and-background-context.md` - Project goals and background
- `requirements.md` - Functional and non-functional requirements
- `epic-*.md` - Epic definitions
- `technical-assumptions.md` - Technical assumptions
- `user-interface-design-goals.md` - UI/UX design goals

---

### Epics & Stories

**PRIMARY EPICS**: [`docs/01_strategy/prd/epic-*.md`](./01_strategy/prd/)

- **Status**: Canonical Epic Definitions
- **Purpose**: Authoritative epic definitions for core scope

**STORIES**: [`docs/04_project_management/stories/`](./04_project_management/stories/)

- **Status**: Active Story Files
- **Format**: `{epic}.{story}.*.md` (e.g., `1.1.*.md`, `2.3.*.md`)
- **Purpose**: Individual user story definitions with acceptance criteria and implementation details

---

### Architecture

**PRIMARY**: [`docs/02_architecture/architecture.md`](./02_architecture/architecture.md)

- **Status**: Active - Main Architecture Document
- **Purpose**: High-level architecture decisions and system design

**SHARDED COMPONENTS**: [`docs/02_architecture/architecture/`](./02_architecture/architecture/)

- **Status**: Supplementary - Component Architecture
- **Purpose**: Detailed architecture components (sharded for maintainability)

---

### BMAD Methodology

**PRIMARY**: [`docs/01_strategy/BMAD_SINGLE_SOURCE_OF_TRUTH.md`](./01_strategy/BMAD_SINGLE_SOURCE_OF_TRUTH.md)

- **Status**: Authoritative - Document Source Hierarchy
- **Purpose**: Defines the mandatory document source hierarchy for all BMAD agents and workflows.

**Key Directives**:

1. **Load PRD from**: `docs/01_strategy/prd/index.md`
2. **Load Architecture from**: `docs/02_architecture/architecture.md`
3. **Load Epics from**: `docs/01_strategy/prd/`
4. **Load Stories from**: `docs/04_project_management/stories/`

---

## Document Status Legend

| Status | Meaning | Action |
|--------|---------|--------|
| **USE THIS** | Authoritative, current document | Use as primary reference |
| **SUPERSEDED** | Replaced by newer version | Do not use - reference superseding document |
| **ARCHIVED** | Historical reference only | Do not use for active work |
| **INDEX** | Navigation/summary document | Use to find authoritative sources |
| **SUPPLEMENT** | Additional context | Use alongside primary documents |

---

## Usage Guidelines

### For Developers

1. **Start with PRD**: `docs/01_strategy/prd/index.md`
2. **Epic context**: `docs/01_strategy/prd/epic-*.md`
3. **Story implementation**: `docs/04_project_management/stories/`
4. **Architecture decisions**: `docs/02_architecture/architecture.md`

### For Product Managers

1. **Product vision**: `docs/00_System_Vision_and_Strategy.md`
2. **Requirements**: `docs/01_strategy/prd/index.md`
3. **Epic planning**: `docs/01_strategy/prd/epic-*.md`

### For Architects

1. **System design**: `docs/02_architecture/architecture.md`
2. **Component details**: `docs/02_architecture/architecture/`

### For BMAD Agents

1. **Always check**: `docs/01_strategy/BMAD_SINGLE_SOURCE_OF_TRUTH.md` first
2. **Follow hierarchy**: Use PRIMARY documents, ignore ARCHIVED
3. **Reference supplements**: Use supplementary documents for context only

---

## Maintenance

### When to Update This Document

This document should be updated whenever:

- A new authoritative document is created
- A document is superseded or archived
- Document locations change
- New document types are introduced
- Document status changes

### Update Process

1. Update "Last Updated" date
2. Increment version number
3. Update relevant sections
4. Verify all links are valid

---

## Project Completion Status

**Current Status**: [STATUS - e.g., "In Progress", "~75% Complete"]
**Confidence**: [LEVEL - e.g., "HIGH", "MEDIUM"]

### Completion Summary

- **Core Epics**: [X/Y Complete]
- **Additional Features**: [Status]
- **Test Coverage**: [X% (target: Y%)]
- **QA Gates**: [X/Y Passing]

---

**Remember**: When in doubt, check `docs/01_strategy/BMAD_SINGLE_SOURCE_OF_TRUTH.md` for the authoritative document hierarchy.

**Last Verified**: YYYY-MM-DD
**Next Review**: When document structure changes or monthly (whichever comes first)
