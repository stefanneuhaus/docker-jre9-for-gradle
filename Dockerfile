FROM debian:stretch-slim

RUN set -ex && \
    apt-get update; \
    apt-get install -y wget; \
    wget http://download.java.net/java/GA/jdk9/9.0.1/binaries/openjdk-9.0.1_linux-x64_bin.tar.gz -O jdk-9.tar.gz; \
    apt-get purge -y wget; \
    apt-get autoremove -y; \
    tar xzf jdk-9.tar.gz; \
    rm jdk-9.tar.gz; \
    /jdk-9.0.1/bin/jlink --module-path /jdk-9.0.1/jmods/ --add-modules java.base,java.logging,java.management --compress=2 --output /jre9-for-gradle; \
    rm -rf /jdk-9.0.1

ENV JAVA_HOME /jre9-for-gradle
ENV PATH /jre9-for-gradle/bin:$PATH

CMD ["/bin/sh"]
