#/bin/sh

sudo yum install golang

git submodule update --init --recursive
git pull --recurse-submodules

# now build the nitriding code
cd nitriding
go get # install dependencies
go build cmd/main.go

# the output file is in this nitriding dir

