#!/bin/bash

function f_home_dirs_main {
    f_out "Creating common home dirs"
    mkdir -p ~/{.build,Projects,.tmp,.local/bin,.bin,bin}
}
