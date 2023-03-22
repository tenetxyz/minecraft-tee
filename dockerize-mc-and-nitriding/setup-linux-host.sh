#/bin/sh

sudo yum install golang

git submodule update --init --recursive
git pull --recurse-submodules
make nitriding/cmd/nitriding
