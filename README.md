# mc-tee

- Imagine a version of Minecraft where you have the ability to craft various items, such as flying machines, tree-planting mechanisms, and mining equipment, for use in various competitive game modes. The specific blocks employed to construct these items are concealed from other players, but can still be authenticated. Only the creator would know the precise arrangement of blocks used, even the server wouldn't know. We are building a Minecraft server mod hosted on a TEE to enable this. Furthermore, users will be able to export their creations, custody them, and test them verifiably in zkvm based simulations.
- Dockerizing Minecraft code is inspired by: https://github.com/itzg/docker-minecraft-server/blob/f6493892e5fc2fc174993ebf0704560f949eb3b6/scripts/start-utils#L198

### Installation
- `make create-instance`
- ssh into the linux host, create an ssh key, connect your key to github, then clone this repo
- `./setup-linux-host.sh` to download nitriding, its dependencies, compile it and other linux essentials
- `sudo vim /etc/nitro_enclaves/allocator.yaml` then change memory_mib to 1300
- `make start-enclave-service`
- `make build` to build the dockerimage
- `make make-enclave` to make the enclave image
- `make run-enclave`
