# Script to clean the commit history

# Create orphan branch
git checkout --orphan temp_branch

# Commit the changes
git commit -am "Initial commit"

# Delete the main branch
git branch -D main

# Rename the current branch to main
git branch -m main

# Clean up everything
git reflog expire --expire=now --all
git gc --prune=now --aggressive
