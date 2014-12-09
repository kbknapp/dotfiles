# Git

A How-To about using the `git` command for version tracking a repository.

## Config

Set `git` username for all repositories to John Doe.
```bash
$ git config --global user.name "John Doe"
```

Set `git` user email for all repositories to jdoe@mail.com.
```bash
$ git config --global user.email "jdoe@mail.com"
```

Set the `git` output to colorized.
```bash
$ git config --global color.ui true
```
## Initializing

Create new `git` repository.
```bash
$ git init
```
Typically preceded by `$ mkdir myproject && cd myproject`

## Status

View `git` repository status
```bash
$ git status
```
## Tracking Files / Folders

Add a file or folder to `git` tracking.
```bash
$ git add some_file.txt
```
`git add` also accepts wildcards (`*`) or the special character `.` meaning all files and folders.

## Displaying Differences

View `git` differences between the working and staging directory 
```bash
$ git diff some_file.py
```

### Flags

`git diff` flags:
`--staged` compares the staging area to the repository.
`HEAD`  compares the file in your working directory to the most recent commit version of the same file.

## Logging / History

Tk GUI of commit history (i.e. gui git log)
```bash
$ gitk
```

View history of commits on the current repository in the current branch.
```bash
$ git log
```
### Flags

`git log` and `gitk` flags:
`--stats` show's the history with some statistics of what was changed.
`--oneline` shows single line version of commits history. (May be combined with the following flags as well)
`--graph` shows branch diagrams
`--all` shows commit history for the current repository from *all* branches.
`--decorate` shows which branch commits were made two along with HEAD information.
`--pretty="%h, %cn, %cr"` shows commit history in a formatted version (example uses abbreviated hash, commiter name, and relative commiter date seperated via commas)

### --pretty Formatter Values
| | | | |
|:----:|:-------------------------|:------|:-------------------------|
| `%H` | Commit Hash              | `%ad` | Author Date              |
| `%h` | Abbreviated Hash         | `%ar` | Author Date, Relative    |
| `%T` | Tree Hash                | `%cn` | Committer Name           |
| `%t` | Abbreviated Tree Hash    | `%ce` | Committer E-mail         |
| `%P` | Parent Hashes            | `%cd` | Committer Date           |
| `%p` | Abbreviated Parent Hashes| `%cr` | Committer Date, Relative |
| `%an`| Author Name              | `%s`  | Subject (Commit Message) |
| `%ae`| Author E-mail            |

## Commiting

Commit all files and prompt for commit message.
```bash
$ git commit .
```
### Flags

`git commit` flags:
`-a` Commits all tracked files with all current changes. Asks for a commit message by showing a status screen.
`-m "a message"` Commits files with the specified message.

## Ignoring

Create a file named *.gitignore* inside the repository.
Add one line per file (or folder) to ignore.
Wildcards (`*`) are allowed.
Lines starting with `!` says to *include* them regardless of other rules in this file.
```bash
$ editor .gitignore
tmp/*.txt
!tmp/important.txt
```

## Branches

List all git branches
```bash
$ git branch
```

Create git branch
```bash
$ git branch devel
```

Switch git branch
```bash
$ git checkout devel
```

Create git branch and switch to it
```bash
$ git checkout -b devel
```

Delete git branch
```bash
$ git checkout -d <name>
```

rebase git branch
```bash
$ git rebase devel
```
`rebase` which applies changes to the `master` in a linear fashion, then re-applies all other commits and finally removes the branch being merged.

### Merging

merge git branch
```bash
$ git checkout master
$ git merge devel
```

## change remote git from ssh to https
```bash
git remote set-url origin https://github.com/USERNAME/REPOSITORY2.git
```

## change remote git from https to ssh key
```bash
git remote set-url origin git@github.com:USERNAME/REPOSITORY2.git
```
