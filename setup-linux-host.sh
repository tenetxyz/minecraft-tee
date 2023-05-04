#/bin/sh

sudo yum -y install golang

sudo yum -y install docker
sudo systemctl enable docker
sudo systemctl start docker

git submodule update --init --recursive
git pull --recurse-submodules

# now build the nitriding code
cd nitriding
go get # install dependencies
go build cmd/nitriding # the output file is in this nitriding dir

# now install enclave code
sudo amazon-linux-extras install aws-nitro-enclaves-cli -y
sudo yum install aws-nitro-enclaves-cli-devel -y
sudo usermod -aG ne ec2-user
sudo usermod -aG docker ec2-user

echo "Please log out and re-connect to ensure nitro cli installed correctly"
