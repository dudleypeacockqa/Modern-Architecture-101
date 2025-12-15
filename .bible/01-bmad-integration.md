# 01: Integrating with BMAD-METHOD

## The Goal

This architectural methodology is designed to be a living, breathing extension of the **BMAD-method**. While BMAD provides the core framework for behavior-driven development, this repository provides the architectural guidance needed to build robust, scalable, and maintainable systems that support that behavior.

## How They Complement Each Other

-   **BMAD Defines the "What" and "Why":** The BMAD-method is used to define the desired behavior of the system from the user's perspective. It answers the questions: "What should the system do?" and "Why is that important?"

-   **ARCHITECTURE-METHOD Defines the "How":** This methodology provides the architectural patterns, principles, and decision-making frameworks to answer the question: "How will we build a system that delivers that behavior?"

## The Integrated Workflow

1.  **Start with BMAD:** Every new feature or project should begin with the BMAD process. This will result in a clear, behavior-driven specification of what needs to be built.

2.  **Consult ARCHITECTURE-METHOD:** Once the behavior is defined, use this repository to guide the architectural design. The `decision-frameworks` and `prd-templates` should be used to document the architectural choices made.

3.  **Apply TDD:** With the behavior and the architecture defined, use Test-Driven Development to implement the system. The tests should be based on the behavior defined in the BMAD process, and the code should follow the architectural patterns outlined here.

4.  **Update Both Repositories:** This is a crucial step. As you learn from each project, update both the BMAD-method and this ARCHITECTURE-METHOD repository with your new insights. This ensures that both methodologies evolve and improve over time.

## The `.bible` Folder

This `.bible` folder is the bridge between the two methodologies. It contains the core documents that define how they integrate and should be the first place to look for guidance on the combined workflow. It is a mandatory component of any project that uses this combined approach, powerful approach to software development.
