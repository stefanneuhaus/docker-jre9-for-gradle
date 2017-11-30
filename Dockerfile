FROM debian:stretch-slim

RUN set -ex && \
    apt-get update; \
    apt-get install -y wget; \
    wget --header "Cookie: oraclelicense=accept-securebackup-cookie" http://download.oracle.com/otn-pub/java/jdk/9.0.1+11/jdk-9.0.1_linux-x64_bin.tar.gz -O jdk-9.tar.gz; \
    apt-get purge -y wget; \
    apt-get autoremove -y; \
    tar xzf jdk-9.tar.gz; \
    rm jdk-9.tar.gz; \
    /jdk-9.0.1/bin/jlink --module-path /jdk-9.0.1/jmods/ --add-modules java.se,jdk.unsupported --compress=2 --output /jre9-for-gradle; \
    rm -rf /jdk-9.0.1

ENV JAVA_HOME=/jre9-for-gradle \
    PATH=/jre9-for-gradle/bin:$PATH

CMD ["/bin/sh"]
