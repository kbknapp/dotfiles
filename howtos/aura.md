# Aura
An Arch Linux AUR helper

## Common Usage
### Installing Packages
Install an AUR package:
```bash
aura -A (package)
```
Author's favourite. Upgrade all AUR packages, show PKGBUILD diffs, and remove unneeded makedeps after installation:
```bash
aura -Akua
```

Just sync the package database and upgrade all installed AUR packages:
```bash
aura -Ayu
```

Install with makepkg output unsuppressed:
```bash
aura -Ax (package)
```

Install and remove make dependencies afterwards:
```bash
aura -Aa (package)
```

Show a packages recent PKGBUILD changes when installing:
```bash
aura -Ak (package)
```

Look up information on an AUR package:
```bash
aura -Ai (package)
```

Checkout an AUR package's PKGBUILD:
```bash
aura -Ap (package)
```

Only download an AUR package's PKGBUILD:
```bash
aura -Ap package > PKGBUILD
```

Search the AUR with a keyword:
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

Downgrade a package (this is interactive):
```bash
aura -C (package)
```

Search the package cache for package files via a regex:
```bash
aura -Cs (regex)
```

Backup the package cache:
```bash
aura -Cb (/path/to/backup/location/)
```

Reduce the package cache to contain only the 5 most recent versions of each package file:
```bash
aura -Cc 5
```

### Working with the Pacman Log

View the pacman log:
```bash
aura -L
```

View log info on a package:
```bash
aura -Li
```

Search the log via a regex:
```bash
aura -Ls (regex)
```

### Working with Orphan Dependencies

Display orphans:
```bash
aura -O
```

Adopt a package (shorthand for -D --asexplicit):
```bash
aura -O (package)
```

Uninstall all orphans:
```bash
aura -Oj
```