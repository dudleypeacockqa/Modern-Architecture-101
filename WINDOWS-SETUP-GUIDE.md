# Windows Setup Guide for Modern-Architecture-101

This guide provides detailed instructions for Windows users to set up and use the automation scripts for the **Modern-Architecture-101** methodology using PowerShell.

---

## The Problem: Bash vs. PowerShell

The errors you encountered were because you were trying to run a **bash script** (`.sh`) in a **Windows PowerShell** terminal. These are two different shell environments with different commands and syntax.

- **Bash** is the standard shell for Linux and macOS.
- **PowerShell** is the standard shell for modern Windows.

To fix this, I have created a dedicated PowerShell script (`Init-Project.ps1`) and this guide to walk you through the correct process on Windows.

---

## Prerequisites

Before you begin, ensure you have the following:

1.  **Windows 10 or 11**
2.  **PowerShell 5.1 or higher** (pre-installed on Windows 10/11)
    -   To check your version, open PowerShell and run: `$PSVersionTable.PSVersion`
3.  **Git for Windows**
    -   If you don't have it, download and install it from: https://git-scm.com/download/win
    -   Verify installation by opening PowerShell and running: `git --version`
4.  **A local clone** of the `Modern-Architecture-101` repository:
    ```powershell
    git clone https://github.com/dudleypeacockqa/Modern-Architecture-101.git
    ```

---

## Step 1: Set Execution Policy

By default, PowerShell has a security feature that prevents the execution of scripts. You may need to change this for your current session.

1.  **Open PowerShell as Administrator:**
    -   Press `Win + X` and select "Windows PowerShell (Admin)" or "Terminal (Admin)".

2.  **Check your current execution policy:**
    ```powershell
    Get-ExecutionPolicy
    ```

3.  **If it says `Restricted`, change it for the current process:**
    ```powershell
    Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope Process
    ```
    -   This policy allows you to run local scripts that you have created. It is a safe and common setting for development.
    -   The `-Scope Process` flag means this change will only last for the current PowerShell session.

---

## Step 2: Navigate to the Scripts Directory

Using PowerShell, navigate to the `scripts` directory inside your local clone of the `Modern-Architecture-101` repository.

```powershell
# Replace "C:\path\to" with the actual path to your repository clone
cd C:\path\to\Modern-Architecture-101\scripts
```

**Example:**
```powershell
cd C:\Users\Dudley\Documents\GitHub\Modern-Architecture-101\scripts
```

---

## Step 3: Run the PowerShell Script

Now you can use the `Init-Project.ps1` script. Remember to use PowerShell syntax for commands and paths.

### For a New (Greenfield) Project

This will create a new directory, initialize a git repository, and set up the methodology.

**Syntax:**
```powershell
.\Init-Project.ps1 -ProjectPath "C:\Path\To\Your\New-Project" -ProjectType Greenfield
```

**Example:**
```powershell
.\Init-Project.ps1 -ProjectPath "C:\Projects\MyNewWebApp" -ProjectType Greenfield
```

### For an Existing (Brownfield) Project

This will add the methodology to your existing project without disturbing the current file structure.

**Syntax:**
```powershell
.\Init-Project.ps1 -ProjectPath "C:\Path\To\Your\Existing-Project" -ProjectType Brownfield
```

**Example:**
```powershell
# This is the correct command for your "Sales Proposals" project
.\Init-Project.ps1 -ProjectPath "C:\Projects\Sales Proposals" -ProjectType Brownfield
```

---

## Corrected Workflow for Your "Sales Proposals" Project

Here is the step-by-step workflow to correctly add the methodology to your existing `Sales Proposals` project.

### 1. Open PowerShell
Open a new PowerShell terminal.

### 2. Set Execution Policy (if needed)
```powershell
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope Process
```

### 3. Navigate to the Scripts Directory
```powershell
# Assuming your clone is in C:\Projects\Modern-Architecture-101
cd "C:\Projects\Modern-Architecture-101\scripts"
```

### 4. Run the Brownfield Initialization
```powershell
.\Init-Project.ps1 -ProjectPath "C:\Projects\Sales Proposals" -ProjectType Brownfield
```

### 5. Navigate to Your Project
```powershell
cd "C:\Projects\Sales Proposals"
```

### 6. Review What Was Added
Use the `Get-ChildItem` (alias `ls` or `gci`) command:
```powershell
# List the contents of the .bible directory
Get-ChildItem -Path .\.bible

# Or, using the alias:
ls .\.bible
```

### 7. Create Your First ADR
Use the `Copy-Item` (alias `cp`) command:
```powershell
# Create the decisions directory if it doesn't exist
New-Item -ItemType Directory -Path .\.bible\decisions -Force

# Copy the template to create your first ADR
Copy-Item -Path .\.bible\01-architecture-decision-record-template.md -Destination .\.bible\decisions\ADR-001-refactor-authentication.md
```

### 8. Commit the Methodology to Git
```powershell
git add .\.bible
git commit -m "Add Modern-Architecture-101 methodology"
```

---

## Common PowerShell Commands vs. Bash

Here is a quick reference for the commands you were trying to use:

| Bash (Linux/macOS) | PowerShell (Windows) | Notes |
| :--- | :--- | :--- |
| `cd ~/projects` | `cd C:\Users\YourUser\projects` | PowerShell uses Windows-style paths. `~` usually works. |
| `ls -la` | `Get-ChildItem` or `ls` or `gci` | The `-la` flags are not used in PowerShell. |
| `cp source dest` | `Copy-Item -Path source -Destination dest` | PowerShell commands are more verbose. |
| `mkdir my-dir` | `New-Item -ItemType Directory -Name my-dir` | |
| `./my-script.sh` | `.\my-script.ps1` | Note the backslash and `.ps1` extension. |

---

## Summary

-   **Use the `Init-Project.ps1` script** in PowerShell on Windows.
-   **Set the execution policy** if you get a security error.
-   **Use PowerShell commands** (`Copy-Item`, `Get-ChildItem`, etc.) when working in your project.

This new script and guide should resolve all the errors you were seeing and provide a smooth setup experience on Windows.
