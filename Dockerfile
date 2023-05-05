#FROM openjdk:17
FROM alpine:latest

# Install OpenJDK and any other required packages
RUN apk add openjdk17-jre

# not sure why this is here?
#RUN mkdir -p /lib64 && ln -sf /lib/libc.musl-x86_64.so.1 /lib64/ld-linux-x86-64.so.2

COPY nitriding-daemon/cmd/nitriding /nitriding
COPY dockerize-mc-server/mc-server-files /server
COPY start-mc-server.sh /

# TODO: I'm not sure if I need to specify -extport 8443 -intport 8080
# TODO: provide a legit fdqn (fully qualified domain name) when we have a legit https certificate
# https://github.com/brave/nitriding-daemon/blob/6ba0e9ed37d945cd9a5030e592bc174fe50009cb/enclave.go#L79

CMD ["/nitriding", "-fqdn", "amazon.com", "-appcmd", "sh start-mc-server.sh"]
