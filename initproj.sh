#!/usr/bin/env bash
set -eu

die() {
    echo -e "\033[1;31mError: \033[m\033[1;38m$1\033[0m" >&2
    exit 1
}

usage() {
    echo "Usage: initproj.sh <project name>"
    exit 1
}

## Make sure we have enough arguments.
test $# -eq 1  || usage

## Error if the project directory already exists and is not empty.
test -d "$1" && test -n "$(ls -A "$1")" && die "Directory $1 already exists and is not empty."

## Create the project directory.
mkdir -p "$1"
cd "$1"
mkdir out

## Copy files from the template directory.
dir="$(dirname "$(realpath "$0")")"
cp -r "$dir"/src src
cp -r "$dir"/idea .idea
cp "$dir"/.gitignore .
cp "$dir"/.clang-format .
cp "$dir"/CMakeLists.txt .

## Replace the project name.
sed -i "s/hello/$1/g" CMakeLists.txt
sed -i "s/hello/$1/g" .gitignore
find .idea -type f -exec grep -q hello {} \; -print0 | xargs -0 sed -i "s/hello/$1/g"

## Initialise a git repository and add fmt and clopts as submodules.
git init
git submodule add https://github.com/fmtlib/fmt libs/fmt
git submodule add https://github.com/Sirraide/clopts libs/clopts
git add .
