build:
	sudo docker image build -t mc-and-nitriding:latest .

run:
	sudo docker run -it -p 25565:25565 mc-and-nitriding:latest

# run this so the server can host enclaves
start-enclave-service:
	sudo systemctl start nitro-enclaves-allocator.service
	sudo systemctl enable nitro-enclaves-allocator.service

# run this if you change /etc/nitro_enclaves/allocator.yaml
restart-enclave-service:
	sudo systemctl stop nitro-enclaves-allocator.service
	sudo systemctl start nitro-enclaves-allocator.service

make-enclave:
	sudo nitro-cli build-enclave --docker-uri mc-and-nitriding:latest --output-file mc-and-nitriding.eif

run-enclave:
	sudo nitro-cli run-enclave --cpu-count 2 --memory 3000 --enclave-cid 16 --eif-path mc-and-nitriding.eif --debug-mode --attach-console

start-gvproxy:
	sudo gvisor-tap-vsock/bin/gvproxy -listen vsock://:1024 -listen unix:///tmp/network.sock

forward-ports:
	sudo curl \
		--unix-socket /tmp/network.sock \
		http:/unix/services/forwarder/expose `# yes it's http:/unix it looks sus but it's legit` \
		-X POST \
		-d '{"local":":443","remote":"192.168.127.2:443"}'
	sudo curl \
		--unix-socket /tmp/network.sock \
		http:/unix/services/forwarder/expose \
		-X POST \
		-d '{"local":":25565","remote":"192.168.127.2:25565"}'

create-instance:
# ami-02238ac43d6385ab3 is the amazon linux 2 ami for intel
# ami-05502a22127df2492 is the amazon linux 2023 ami (not using cause missing core packages)
	aws ec2 run-instances \
	--image-id ami-02238ac43d6385ab3 \
	--count 1 \
	--instance-type m5.2xlarge `# NOTE: their documentation lies. enclaves are only available for m5.xlarge and larger. m5.large does not have enclave support` \
	--key-name Transistor \
	--enclave-options 'Enabled=true'

setup-host:
	sh setup-linux-host.sh

nitro-cli-version:
	nitro-cli --version

list-enclaves:
	nitro-cli describe-enclaves
