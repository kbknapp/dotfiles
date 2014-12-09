# Git

A How-To about using the `git` command for version tracking a repository.

## Config

Set the username for all repositories to John Doe.

	$ git config --global user.name "John Doe"

Set the user email for all repositories to jdoe@mail.com.

	$ git config --global user.email "jdoe@mail.com"

Set the `git` output to colorized.

	$ git config --global color.ui true

## Initializing

Create a new repository.

    $ git init

The above is typically preceded by `$ mkdir myproject && cd myproject` which creates a directory called *myproject* and then changes into that directory.

## Status

Check the status of `git` repository

	$ git status

## Tracking Files / Folders

Add a file or folder to be tracked.

	$ git add some_file.txt

`git add` also accepts wildcards (`*`) or the special character `.` meaning all files and folders.

## Displaying Differences

Display the differences between the working directory (example *some_file.py*) and the staging directory 

	$ git diff some_file.py

### Flags

Adding the following flags to `git diff` changes the functionality.

`--staged` compares the staging area to the repository.

`HEAD`  compares the file in your working directory to the most recent commit version of the same file.

## Logging / History

Show a Tk GUI showing commit history

	$ gitk

Show a history of commits on the current repository in the current branch.

	$ git log

### Flags

Adding the following flags changes the output of `git log` or `gitk` respectively

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

Commit all files by showing a status and asking for a commit message.

	$ git commit .

### Flags

Adding the following flags to `git commit` changes the functionality.

`-a` Commits all tracked files with all current changes. Asks for a commit message by showing a status screen.

`-m "a message"` Commits files with the specified message.

## Ignoring

To ignore files create a file named *.gitignore* inside the repository. Add one line per file (or folder) to ignore. Wildcards (`*`) are allowed. A line starting with `!` tels `git` to *include* such files and folders regardless of what other rules are listed in this file. Example:

	$ editor .gitignore
	.DS_Store
	tmp/*.txt
	!tmp/important.txt

## Branches

To see a list of branches as well s the currently selected branch

	$ git branch

To create a branch pass the branch name to `git branch`, i.e.

	$ git branch devel

Switch to a different branch (example switches to the `devel` branch)

	$ git checkout devel

Alternatively use `git checkout` with the `-b` flag to create a new branch and switch to it in a single command.

	$ git checkout -b devel

Delete a branch using the `-d` and the branch name

Another way to merge two branches is using `rebase` which applies changes to the `master` in a linear fashion, then re-applies all other commits and finally removes the branch being merged. Example:

	$ git rebase devel

### Merging

If you have two branches that you'd like to merge `master` and `devel` switch two the branch that will be merged *into* (i.e. example merges the `devel` branch *into* the `master` branch)

	$ git checkout master
	$ git merge devel
