# YouCompleteMe

## Install
Clone
```bash
$ git clone https://github.com/Valloric/YouCompleteMe.git
```
Create a build directory
```bash
$ mkdir ~/Builds/ycm_build
$ cd ~/Builds/ycm_build
```
Generate makefiles without C-Family syntax
```bash
$ cmake -G "Unix Makefiles" . ~/.vim/bundle/YouCompleteMe/third_party/ycmd/cpp
```
OR Generate makefiles with C-Family syntax (require steps prior too)
```bash
cmake -G "Unix Makefiles" -DPATH_TO_LLVM_ROOT=~/ycm_temp/llvm_root_dir . ~/.vim/bundle/YouCompleteMe/third_party/ycmd/cpp
```

Compile
```bash
make ycm_support_libs
```