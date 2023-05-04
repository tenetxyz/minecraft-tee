#/bin/sh

function install_docker(){
  echo "[SETUP] installing docker"
  sudo yum -y install docker
  sudo systemctl enable docker
  sudo systemctl start docker
}

function install_golang(){
  echo "[SETUP] installing golang"
  sudo yum -y install golang
  # install golangci-lint for nitriding
  # binary will be $(go env GOPATH)/bin/golangci-lint
  curl -sSfL https://raw.githubusercontent.com/golangci/golangci-lint/master/install.sh | sh -s -- -b $(go env GOPATH)/bin 
  echo 'export PATH=$PATH:/home/ec2-user/go/bin' >> ~/.bashrc
  source ~/.bashrc
}

function build_nitriding_binary(){
  echo "[SETUP] building nitriding binary"
  git submodule update --init --recursive
  git pull --recurse-submodules

  cd nitriding-daemon
  go get # install dependencies
  make cmd/nitriding # the output file is in this nitriding dir
}

function install_nitro_cli(){
  echo "[SETUP] installing nitro cli"
  sudo amazon-linux-extras install aws-nitro-enclaves-cli -y
  sudo yum install aws-nitro-enclaves-cli-devel -y
  sudo usermod -aG ne ec2-user
  sudo usermod -aG docker ec2-user
}

install_docker && install_golang && build_nitriding_binary && install_nitro_cli || {
  echo "[ERROR]: failed to complete setup"
  exit 1
}

echo "[SUCCESS] Please log out and re-connect to ensure nitro cli installed correctly"
