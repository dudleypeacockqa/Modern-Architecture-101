# Architecture Decision Record (ADR) Template

## ADR [Number]: [Short Title]

**Date:** [YYYY-MM-DD]

**Status:** [Proposed | Accepted | Deprecated | Superseded]

**Context:** [What is the issue that we're seeing that is motivating this decision or change?]

**Decision:** [What is the change that we're proposing and/or doing?]

**Consequences:** [What becomes easier or more difficult to do because of this change?]

---

## Detailed Sections

### Context and Problem Statement

Describe the context and problem statement in detail. This should include:

-   **Background:** What is the current state of the system?
-   **Problem:** What specific problem are we trying to solve?
-   **Constraints:** What are the constraints that we must work within? (e.g., budget, timeline, team expertise)
-   **Assumptions:** What assumptions are we making?

### Considered Options

List all the options that were considered, including the pros and cons of each:

#### Option 1: [Name]

**Description:** [Brief description of this option]

**Pros:**
-   [Pro 1]
-   [Pro 2]

**Cons:**
-   [Con 1]
-   [Con 2]

#### Option 2: [Name]

**Description:** [Brief description of this option]

**Pros:**
-   [Pro 1]
-   [Pro 2]

**Cons:**
-   [Con 1]
-   [Con 2]

### Decision Outcome

**Chosen Option:** [Name of the chosen option]

**Justification:** [Why was this option chosen over the others? How does it align with the core principles of this methodology, particularly the principle of simplicity?]

### Consequences

#### Positive Consequences
-   [What becomes easier or better because of this decision?]

#### Negative Consequences
-   [What becomes more difficult or worse because of this decision?]

#### Mitigation Strategies
-   [How will we mitigate the negative consequences?]

### Related Decisions

-   [Link to related ADRs]

### References

-   [Links to relevant documentation, articles, or discussions]

---

## How to Use This Template

1.  **Create a new ADR file** for each significant architectural decision. Name the file with a number and a short title (e.g., `ADR-001-use-postgresql-for-primary-database.md`).
2.  **Fill in all sections** of the template. Be as detailed as necessary to ensure that future readers understand the context and reasoning behind the decision.
3.  **Review and discuss** the ADR with your team before marking it as "Accepted."
4.  **Store the ADR** in the `decision-frameworks` folder of your project repository and in this ARCHITECTURE-METHOD repository if it represents a reusable pattern.
5.  **Update the ADR** if the decision changes. If a decision is superseded, create a new ADR and link to the old one.
