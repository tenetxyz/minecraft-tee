FROM openjdk:17
COPY mc-server-files /server
WORKDIR /server
ENTRYPOINT ["java", "-Xmx1024M", "-Xms1024M", "-jar","server-1.18.2.jar", "nogui"]
#ENTRYPOINT ["cat", "server/eula.txt"]