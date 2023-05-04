#FROM openjdk:17
FROM alpine:latest

# Install OpenJDK and any other required packages
RUN apk add openjdk17-jre

RUN mkdir -p /lib64 && ln -sf /lib/libc.musl-x86_64.so.1 /lib64/ld-linux-x86-64.so.2

COPY nitriding-daemon/cmd/nitriding /nitriding
COPY dockerize-mc-server/mc-server-files /server

# TODO: I'm not sure if I need to specify -extport 8443 -intport 8080
CMD ["/nitriding", "-fqdn", "-appcmd", "'java -Xmx1024M -Xms1024M -jar server/server-1.18.2.jar nogui'"]
