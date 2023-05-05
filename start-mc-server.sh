#/bin/sh

# note: we cd to server/ so the java server can see the eula.txt
cd server
java -Xmx1024M -Xms1024M -jar server-1.18.2.jar nogui
