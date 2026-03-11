---
name: prepare-pr
description: Prepares the repository for a pull request when the user enters the phrase "Prepare PR".
---

# Prepare PR Skill

## Overview

The **prepare-pr** skill is triggered when the user types **"Prepare PR"** in the chat.  
Its purpose is to verify that the repository is clean, consistent, and ready for a pull request.

The validation process consists of **two stages**:

1. **Check for uncommitted modified files**
2. **Check for untracked file dependencies**

---

## Stage 1 — Check for Uncommitted Modified Files

### 1. Determine the Operating System

Identify the user's operating system and run the appropriate script:

- **Windows:**  
  `scripts/check_git_modified_uncommited_files.cmd`

- **Linux / Unix / macOS:**  
  `scripts/check_git_modified_uncommited_files.sh`

These scripts behave as follows:

- Return **0** → No modified but uncommitted files
- Return **1** → Modified but uncommitted files exist

### 2. Output the Result

- If the script returns **0**, output:  
  **👍 All Changes Committed**

- If the script returns **1**, output:  
  **👎 Uncommitted Changes**

Continue to Stage 2 regardless of the result.

---

## Stage 2 — Check for Untracked File Dependencies

### 1. Identify Untracked Files

Use Git to obtain a list of all untracked files in the repository.

### 2. Scan for References in Committed Files

For each untracked file:

- Search all committed files for any reference to that untracked file.  
  A reference includes (but is not limited to):
  - `include` or `import` statements
  - hyperlinks
  - relative or absolute file paths
  - textual mentions of the filename

If any committed file references an untracked file, it is considered a dependency issue.

### 3. Output the Result

- If **any dependencies are found**, output:  
  **👎 Untracked File Dependencies**

  Then generate a dependency report using the template at:  
  `assets/untracked_file_dependency.md`

  The report must include:
  - A list of untracked files that were referenced
  - For each untracked file, the committed files that reference it
  - The template must be followed exactly, with placeholders replaced by actual values

- If **no dependencies are found**, output:  
  **👍 No Untracked File Dependencies**

---

## Summary of Expected Outputs

| Condition                         | Output                                             |
| --------------------------------- | -------------------------------------------------- |
| No modified uncommitted files     | 👍 All Changes Committed                           |
| Modified uncommitted files exist  | 👎 Uncommitted Changes                             |
| Untracked file dependencies exist | 👎 Untracked File Dependencies + dependency report |
| No untracked file dependencies    | 👍 No Untracked File Dependencies                  |

---
