#!/bin/sh

# Check if this is the git repo "Teddy-van-Jerry/ip-doc"
# Quit if it is.
if [ -d .git ]; then
    # check if the remote is "Teddy-van-Jerry/ip-doc"
    if [ "$(git remote get-url origin)" = "https://github.com/Teddy-van-Jerry/ip-doc.git" ]; then
        echo "This is the git repo 'Teddy-van-Jerry/ip-doc'."
        echo "Please do not run this script in the git repo."
        exit 1
    fi
fi

# This script downloads the `ip-doc.cls' file to the current directory.
curl -O https://raw.githubusercontent.com/Teddy-van-Jerry/ip-doc/refs/heads/master/ip-doc.cls
