build:
	docker image build -t mc-and-nitriding:latest .
run:
	docker run -it -p 25565:25565 mc-and-nitriding:latest

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
