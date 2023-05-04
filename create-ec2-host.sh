#!/bin/bash
# ami-02238ac43d6385ab3 is the amazon linux 2 ami for intel 
# ami-05502a22127df2492 is the amazon linux 2023 ami (not using cause missing core packages)
aws ec2 run-instances \
--image-id ami-02238ac43d6385ab3 \
--count 1 \
--instance-type m5.xlarge `# NOTE: their documentation lies. enclaves are only available for m5.xlarge and larger. m5.large does not have enclave support` \
--key-name Transistor \
--enclave-options 'Enabled=true'
