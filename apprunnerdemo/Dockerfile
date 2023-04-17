FROM azul/zulu-openjdk-alpine:11-jre-headless as build

RUN apk update && \
    apk add --no-cache ca-certificates && \
    update-ca-certificates

# Download the Alpine `ca-certificates` package to get the `cacerts` file
RUN wget https://dl-cdn.alpinelinux.org/alpine/v3.14/main/aarch64/ca-certificates-20220614-r0.apk && \
    mkdir /certs && \
    cd /certs && \
    tar xvf /ca-certificates-20220614-r0.apk && \
    rm /ca-certificates-20220614-r0.apk

# Add Alpine certificates to Java keystore
RUN keytool -importcert -noprompt -storepass changeit -keystore /usr/lib/jvm/zulu11/lib/security/cacerts \
    -alias "Alpine CA" -file /etc/ssl/certs/ca-certificates.crt

# Install Maven
RUN apk add --no-cache curl tar bash procps && \
    curl -fsSL https://apache.osuosl.org/maven/maven-3/3.9.1/binaries/apache-maven-3.9.1-bin.tar.gz | tar xzf - -C /opt && \
    ln -s /opt/apache-maven-3.9.1/bin/mvn /usr/bin/mvn && \
    apk del curl tar bash

WORKDIR /workspace/app
COPY pom.xml .
COPY src src

RUN mvn package -Dmaven.test.skip

EXPOSE 8080
CMD ["java", "-jar", "target/apprunner-0.0.1-SNAPSHOT.jar"]