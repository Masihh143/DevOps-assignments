# Git / GitHub Assignment

> ### Task 1: `git commit -a -m` vs `git commit -m`

- **`git commit -m "commit message"`**: Creates a new commit using only the files currently staged in the Git index (added via `git add`). Unstaged modifications in tracked files are excluded.
- **`git commit -a -m "commit message"`**: Automatically stages all modified and deleted tracked files, then creates the commit in one single command. (Note: Newly created untracked files are not included and still require `git add`).

---

> ### Task 2: Git Cherry-Pick Practice

**Cherry-pick** applies the changes introduced by a specific commit from another branch onto your current branch, creating a new commit with a new hash without merging the entire source branch.

#### Bash Command Workflow (`git-practice.sh`)

```bash
#!/bin/bash

# Initialize test repository
mkdir git-practice && cd git-practice
git init

# Commits on main branch
echo "Hello" > file.txt
git add file.txt
git commit -m "Initial commit"

echo "Line 2" >> file.txt
git commit -a -m "Add line 2"

echo "Main feature" > main.txt
git add main.txt
git commit -m "Add main feature"

# Create feature branch and make 3 commits
git switch -c feature

echo "Feature 1" > feature.txt
git add feature.txt
git commit -m "Feature commit 1"

echo "Feature 2" >> feature.txt
git add feature.txt
git commit -m "Feature commit 2"

echo "Feature 3" >> feature.txt
git add feature.txt
git commit -m "Feature commit 3"

# Switch back to main
git switch main

# View branch log graph prior to cherry-pick
git log --oneline --graph --all

# Cherry-pick 'Feature commit 1' onto main
git cherry-pick <FEATURE_COMMIT_HASH>

# Verify log graph showing cherry-picked commit on main
git log --oneline --graph --all
```

#### Execution Output Log

```
$ git switch -c feature
Switched to a new branch 'feature'
[feature 8bfc505] Feature commit 1
[feature a56c621] Feature commit 2
[feature 598bfe1] Feature commit 3

$ git log --oneline --graph --all
* 598bfe1 (HEAD -> feature) Feature commit 3
* a56c621 Feature commit 2
* 8bfc505 Feature commit 1
* dbe2306 (main) Add main feature
* 43bf875 Add line 2
* 29fd65f Initial commit

$ git switch main
Switched to branch 'main'

$ git cherry-pick 8bfc505
[main 80ea27f] Feature commit 1
 1 file changed, 1 insertion(+)
 create mode 100644 feature.txt

$ git log --oneline --graph --all
* 80ea27f (HEAD -> main) Feature commit 1
| * 598bfe1 (feature) Feature commit 3
| * a56c621 Feature commit 2
| * 8bfc505 Feature commit 1
|/  
* dbe2306 Add main feature
* 43bf875 Add line 2
* 29fd65f Initial commit
```
