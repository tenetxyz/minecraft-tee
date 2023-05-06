# mc-tee

- Imagine a version of Minecraft where you have the ability to craft various items, such as flying machines, tree-planting mechanisms, and mining equipment, for use in various competitive game modes. The specific blocks employed to construct these items are concealed from other players, but can still be authenticated. Only the creator would know the precise arrangement of blocks used, even the server wouldn't know. We are building a Minecraft server mod hosted on a TEE to enable this. Furthermore, users will be able to export their creations, custody them, and test them verifiably in zkvm based simulations.
- Dockerizing Minecraft code is inspired by: https://github.com/itzg/docker-minecraft-server/blob/f6493892e5fc2fc174993ebf0704560f949eb3b6/scripts/start-utils#L198

### Installation
- `make create-instance`
- ssh into the linux host, create an ssh key, connect your key to github, then clone this repo
- `./setup-linux-host.sh` to download nitriding, its dependencies, compile it and other linux essentials
- `sudo vim /etc/nitro_enclaves/allocator.yaml` then change memory_mib to 3000
- `make start-enclave-service`
- `make build` to build the dockerimage
- `make make-enclave` to make the enclave image
- `make run-enclave`
- `make start-gvproxy`
- `make forward-ports` to forward specific ports to the vsock port, and thus to nitriding


### Useful commands
- `nitro-cli console --enclave-id <your-enclave-id>` To access the enclave
- `kill <enclaive pid>` since the nitro-cli terminate-enclave command sometimes fails

### How to perform attestation
Attestation basically means: "Making sure the Minecraft server is running in an enclave and that the enclave is running the code in this repo".
Without attestation, the Minecraft server could be running untrusted code (i.e. your creations could be stolen)
- `make create-instance` to make a new instance. This instance will perform the attestation
- ssh into the linux host, create an ssh key, connect your key to github, then clone this repo
- `./setup-linux-host.sh` to download nitriding, its dependencies, compile it and other linux essentials
- `make start-enclave-service`. NOTE: I'm 80% sure this is needed (so the attestator can create an enclave). But I didn't test without this.
- `make build` to build your own version of this repo (the code you want to make sure is running in the TEE)
- `make make-enclave` to make the enclave image
- `cd verify-enclave`
- `make verify KANIKO_IMAGE_TAR=../mc-in-enclave-kaniko.tar IMAGE_TAG=mc-in-enclave ENCLAVE=<server_ip_of_the_mc_server_you_want_to_attest>:443/enclave/attestation`


### TODO
- When productionizing this, make sure the enclave isn't in debug mode

