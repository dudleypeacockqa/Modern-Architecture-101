# Automation Scripts for Modern-Architecture-101

This directory contains automation scripts to streamline the integration of the **Modern-Architecture-101** methodology into your projects.

---

## Purpose

The goal of these scripts is to provide a consistent, one-command setup for initializing both new (greenfield) and existing (brownfield) projects with the core principles and templates from this methodology. This ensures that every project starts with the same architectural foundation.

## Scripts

1.  **`init-project.sh`** - A bash script for Unix-like systems (Linux, macOS).
2.  **`init-project.py`** - A Python script that is cross-platform and offers more robust argument parsing.

Both scripts perform the same actions, so you can use whichever you prefer.

---

## What the Scripts Do

When you run either script, it will perform the following actions on your target project directory:

1.  **Detects Project Type:** Initializes differently for greenfield (new) vs. brownfield (existing) projects.
2.  **Initializes Git:** For greenfield projects, it runs `git init`. For brownfield, it checks for an existing `.git` directory.
3.  **Creates `.bible` Directory:** A `.bible` folder is created at the root of your project. This folder will house all the core architectural documents.
4.  **Copies Core Documents:** It copies the following essential documents from the `Modern-Architecture-101` repository into your project's `.bible` folder:
    -   All BMAD integration guides from `/.bible`
    -   All core principles from `/core-principles`
    -   The ADR template from `/decision-frameworks`
    -   The architecture-aware PRD template from `/prd-templates`
5.  **Creates a `.bible/README.md`:** A README file is generated inside the `.bible` folder to explain its purpose to your team.
6.  **Creates a `decisions` Directory:** A dedicated folder at `.bible/decisions` is created to store your project-specific Architecture Decision Records (ADRs).
7.  **Creates a Setup Summary:** A `SETUP-SUMMARY.md` file is generated in the `.bible` folder, documenting what was installed and providing next steps.

---

## Prerequisites

-   **Git:** You must have `git` installed and available in your system's PATH.
-   **Python 3:** Required for the `init-project.py` script.
-   **A local clone** of the `Modern-Architecture-101` repository.

## How to Use

First, navigate to the `scripts` directory within your local clone of the `Modern-Architecture-101` repository.

```bash
cd /path/to/Modern-Architecture-101/scripts
```

### Using the Bash Script (`init-project.sh`)

Make sure the script is executable:
```bash
chmod +x init-project.sh
```

**For a new (greenfield) project:**
```bash
./init-project.sh /path/to/your/new-project --greenfield
```

**For an existing (brownfield) project:**
```bash
./init-project.sh /path/to/your/existing-project --brownfield
```

### Using the Python Script (`init-project.py`)

**For a new (greenfield) project:**
```bash
python3 init-project.py /path/to/your/new-project --greenfield
```

**For an existing (brownfield) project:**
```bash
python3 init-project.py /path/to/your/existing-project --brownfield
```

---

## Example Walkthrough (Greenfield)

1.  **Run the command:**
    ```bash
    ./init-project.sh ~/dev/my-new-app --greenfield
    ```

2.  **The script will output:**
    ```
    ✓ Created project directory
    ✓ Initialized git repository
    ✓ Created standard project structure
    ✓ Created .bible directory at /home/user/dev/my-new-app/.bible
    ✓ Copied BMAD integration documents
    ✓ Copied core principles
    ✓ Copied ADR template
    ✓ Copied PRD template
    ✓ Created .bible/README.md
    ✓ Created ADR directory at /home/user/dev/my-new-app/.bible/decisions
    ✓ Created setup summary
    ```

3.  **Your new project structure will be:**
    ```
    my-new-app/
    ├── .git/
    ├── .bible/
    │   ├── README.md
    │   ├── SETUP-SUMMARY.md
    │   ├── decisions/
    │   │   └── .gitkeep
    │   ├── 01-bmad-integration.md
    │   ├── bmad-integration-summary.md
    │   ├── 01-simplicity-is-the-best-architecture.md
    │   ├── 02-context-over-dogma.md
    │   ├── 01-architecture-decision-record-template.md
    │   └── 01-architecture-aware-prd.md
    ├── src/
    ├── tests/
    └── docs/
    ```

Your new project is now ready, with the architectural foundation in place.
