#!/bin/bash

pwd
ls -la
swift --version

mkdir docs
cp README.md docs/.
cd docs
touch file.txt
wc -l file.txt >> file.txt
cd ..

ls -R
