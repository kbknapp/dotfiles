# Useful Commands for Linux

## find and delete duplicate files
```bash
find -not -empty -type f -printf "%s\n" | sort -rn | uniq -d | xargs -0 md5sum | sort | uniq -w32 --all-repeated=separate | cut -f3-100 -d '' | tr '\n.' '\t.' | sed 's/\t\t/\n/g' | cut -f2-100 | tr '\t' '\n' | perl -i -pe 's/([ (){}-])/\\$1/g' | perl -i -pe 's/\"/\\'\"/g' | xargs -pr rm -v
```

## print first and last line of output
```bash
awk 'NR==1; END{print}'
```

## print first and last line of file
```bash
(head -n1 && tail -n1)<file
```

## link files link directories symlinks
```bash
ln -s <object> <new link>
```

## change remote git from ssh to https
```bash
git remote set-url origin https://github.com/USERNAME/REPOSITORY2.git
```

## change remote git from https to ssh key
```bash
git remote set-url origin git@github.com:USERNAME/REPOSITORY2.git
```
