# Yaourt
An Arch Linux AUR helper

## Common Usage
Search and install:
```bash
$ yaourt search pattern
```

Sync database, upgrade packages, search the AUR and devel (all packages based on cvs, svn, git, bzr(...)-version) upgrades:
```bash
$ yaourt -Syua --devel
```

Build package from source:
```bash
$ yaourt -Sb package
```

Check, edit, merge or remove *.pac* files:
```bash
$ yaourt -C
```

Get a PKGBUILD (support split package):
```bash
$ yaourt -G package
```
Build and export package, its sources to a directory:
```bash
$ yaourt -Sb --export dir package
```
Backup database:
```bash
$ yaourt -B
```
Query backup file:
```bash
$ yaourt -Q --backupfile file
```