---
name: prepare-pr
description: Prepares for a pull request when the user enters the phrase "Prepare PR"
---

# Prepare PR

Use the prepare-pr skill when the user enters the phrase "Prepare PR" in the chat.

The check consists of two stages.

Step 1. Check for uncommited changes to files already in the repository.

Run the [script](scripts/check_git_modified_uncommited_files.cmd) to determine if there are uncommitted changes.

If the script responds with a value of 0, then print a thumbs up emoji followed by "All Changes Committed"

If the script responds with a value of 1, then print a thumbs down emoji followed by "Uncommitted changes"


Step 2. Check if there are untracked files that the committed files depend on.

Get a list of all the untracked files and iterate over them.

For each untracked file check if there is an include statement or link or mention of the untracked file inside any of the committed files. Any connection to the untracked file is a reference we need to flag.

If you find any references to an untracked file then print a thumbs down emoji followed by "Untracked File Dependencies"

After that output a report on the dependencies according to the [template](assets/untracked_file_dependency.md) to the screen to list both the untracked file and the committed files that appears to depend on it.

If there are no references to any of the untracked files, then print a thumbs up emoji followed by "No Untracked File Dependencies"
