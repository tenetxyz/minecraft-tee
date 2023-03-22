build:
	sudo docker image build -t mc-and-nitriding:latest .

run:
	sudo docker run -it -p 25565:25565 mc-and-nitriding:latest

make-enclave:
	nitro-cli build-enclave --docker-uri mc-and-nitriding:latest --output-file mc-and-nitriding.eif

run-enclave:
	nitro-cli run-enclave --cpu-count 2 --memory 512 --enclave-cid 16 --eif-path mc-and-nitriding.eif --debug-mode

create-instance:
	# this ami for intel amazon linux 2
	aws ec2 run-instances \
	--image-id ami-02238ac43d6385ab3 \
	--count 1 \
	--instance-type m5.xlarge \
	--key-name silver2 \
	--enclave-options 'Enabled=true'

setup-host:
	sh setup-linux-host.sh

validate-nitro-cli:
	nitro-cli --version