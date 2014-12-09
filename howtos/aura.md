# Aura
An Arch Linux AUR helper

## Common Usage
### Installing Packages
Install an AUR package:
```bash
aura -A (package)
```
Upgrade all AUR packages, show PKGBUILD diffs, and remove unneeded makedeps after installation:
```bash
aura -Akua
```

Sync aur package database and upgrade all AUR packages:
```bash
aura -Ayu
```

Install aur package with makepkg output unsuppressed:
```bash
aura -Ax (package)
```

Install aur package and remove make dependencies afterwards:
```bash
aura -Aa (package)
```

Show an aur packages recent PKGBUILD changes when installing:
```bash
aura -Ak (package)
```

AUR package info:
```bash
aura -Ai (package)
```

View AUR package PKGBUILD:
```bash
aura -Ap (package)
```

Only download AUR package PKGBUILD:
```bash
aura -Ap package > PKGBUILD
```

Search AUR with a keyword:
```bash
aura -As (keyword)
```

### Saving/Restoring the Global Package State

Save the global package state:
```bash
aura -B
```

Restore a saved state. Downgrades upgraded packages, removes recently installed:
```bash
aura -Br
```

Remove old saved states. Saves number states and removes the rest.
```bash
aura -Bc (number)
```

### Working with the Package Cache

Downgrade package (this is interactive):
```bash
aura -C (package)
```

Search package cache with regex:
```bash
aura -Cs (regex)
```

Backup package cache:
```bash
aura -Cb (/path/to/backup/location/)
```

Reduce package cache to contain only the 5 most recent versions of each package file:
```bash
aura -Cc 5
```

### Working with the Pacman Log

View the pacman log:
```bash
aura -L
```

View pacman log info on a package:
```bash
aura -Li
```

Search pacman log via a regex:
```bash
aura -Ls (regex)
```

### Working with Orphan Dependencies

View orphan packages:
```bash
aura -O
```

Adopt orphan package (shorthand for -D --asexplicit):
```bash
aura -O (package)
```

Remove all orphan packages:
```bash
aura -Oj
```