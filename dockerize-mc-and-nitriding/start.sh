#!/bin/sh

#nitriding_url="http://127.0.0.1:8080/enclave/ready"
echo "[start.sh] Starting"
/nitriding -fqdn example.com  -extport 8443  -intport 8080 &
echo "[sh] Started nitriding."

# in the background, try to ping the server once every 5 seconds for 6 times.
# if the server fails to spin up in that time, then kill the container
# otherwise, call the nitriding url at http://127.0.0.1:8080/enclave/ready

# minecraft servers expect things like the eula and server.properties to be in the same dir
cd server

# spin up the server
java -Xmx1024M -Xms1024M -jar server-1.18.2.jar nogui &
