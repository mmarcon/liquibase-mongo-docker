FROM openjdk:11-jre-slim-buster

# Install GPG for package vefification
RUN apt-get update \
	&& apt-get -y install gnupg wget

# Add the liquibase user and step in the directory
RUN addgroup --gid 1001 liquibase
RUN adduser --disabled-password --uid 1001 --ingroup liquibase liquibase

# Make /liquibase directory and change owner to liquibase
RUN mkdir /liquibase && chown liquibase /liquibase
WORKDIR /liquibase

# Change to the liquibase user
USER liquibase

# Latest Liquibase Release Version
ARG LIQUIBASE_VERSION=4.2.1

# Download, verify, extract
ARG LB_SHA256=0bf1c51fc8cbccc482f4902de9c81f313abaa27a1321a9481ef39e1b8e1369bb
RUN set -x \
  && wget -O liquibase-${LIQUIBASE_VERSION}.tar.gz "https://github.com/liquibase/liquibase/releases/download/v${LIQUIBASE_VERSION}/liquibase-${LIQUIBASE_VERSION}.tar.gz" \
  && sha256sum liquibase-${LIQUIBASE_VERSION}.tar.gz \
  && echo "$LB_SHA256  liquibase-${LIQUIBASE_VERSION}.tar.gz" | sha256sum -c - \
  && tar -xzf liquibase-${LIQUIBASE_VERSION}.tar.gz

# Setup GPG
RUN GNUPGHOME="$(mktemp -d)" 

ARG LB_MONGO_VERSION=4.2.1
RUN wget -O /liquibase/lib/mongodb.jar https://github.com/liquibase/liquibase-mongodb/releases/download/liquibase-mongodb-${LB_MONGO_VERSION}/liquibase-mongodb-${LB_MONGO_VERSION}.jar
RUN wget -O /liquibase/lib/mongo-java-driver-3.10.1.jar https://repo1.maven.org/maven2/org/mongodb/mongo-java-driver/3.10.1/mongo-java-driver-3.10.1.jar

COPY docker-entrypoint.sh /usr/local/bin/
ENTRYPOINT ["docker-entrypoint.sh"]
CMD ["--help"]