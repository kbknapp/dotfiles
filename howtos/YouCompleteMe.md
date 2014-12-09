# YouCompleteMe

## Install
Clone youcompleteme
```bash
$ git clone https://github.com/Valloric/YouCompleteMe.git
```
build youcompleteme
```bash
$ mkdir ~/Builds/ycm_build
$ cd ~/Builds/ycm_build
```
Generate youcompleteme makefiles
```bash
$ cmake -G "Unix Makefiles" . ~/.vim/bundle/YouCompleteMe/third_party/ycmd/cpp
```
OR Generate youcompleteme makefiles for C-Family syntax (require steps prior too)
```bash
cmake -G "Unix Makefiles" -DPATH_TO_LLVM_ROOT=~/ycm_temp/llvm_root_dir . ~/.vim/bundle/YouCompleteMe/third_party/ycmd/cpp
```
Compile youcompleteme
```bash
make ycm_support_libs
```