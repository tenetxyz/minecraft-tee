#/bin/sh

sudo yum -y install golang

sudo yum -y install docker
sudo systemctl enable docker
sudo systemctl start docker

git submodule update --init --recursive
git pull --recurse-submodules

# install golangci-lint for nitriding
# binary will be $(go env GOPATH)/bin/golangci-lint
curl -sSfL https://raw.githubusercontent.com/golangci/golangci-lint/master/install.sh | sh -s -- -b $(go env GOPATH)/bin 
echo 'export PATH=$PATH:/home/ec2-user/go/bin' >> ~/.bashrc
source ~/.bashrc

# now build the nitriding code
cd nitriding-daemon
go get # install dependencies
make cmd/nitriding # the output file is in this nitriding dir

# now install enclave code
sudo amazon-linux-extras install aws-nitro-enclaves-cli -y
sudo yum install aws-nitro-enclaves-cli-devel -y
sudo usermod -aG ne ec2-user
sudo usermod -aG docker ec2-user

echo "Please log out and re-connect to ensure nitro cli installed correctly"
