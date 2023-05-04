#FROM openjdk:17
FROM alpine:latest
# Install OpenJDK and any other required packages
RUN apk add openjdk17-jre

RUN mkdir -p /lib64 && ln -sf /lib/libc.musl-x86_64.so.1 /lib64/ld-linux-x86-64.so.2

COPY nitriding /nitriding
COPY dockerize-md-server/mc-server-files /server
COPY start.sh /

CMD ["sh","/start.sh"]
