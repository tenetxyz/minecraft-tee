FROM openjdk:17

RUN mkdir -p /lib64 && ln -sf /lib/libc.musl-x86_64.so.1 /lib64/ld-linux-x86-64.so.2

COPY ../nitriding /
COPY ../dockerize-mc-server/mc-server-files /server
COPY start.sh /

CMD ["/start.sh"]