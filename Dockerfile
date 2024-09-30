FROM liquibase/liquibase:4.29.0

ARG LB_MONGO_VERSION=4.29.2
ARG MDB_JAVA_DRIVER_VERSION=5.1.3
RUN wget -O /liquibase/lib/mongodb.jar https://github.com/liquibase/liquibase-mongodb/releases/download/v${LB_MONGO_VERSION}/liquibase-mongodb-${LB_MONGO_VERSION}.jar
RUN wget -O /liquibase/lib/bson-${MDB_JAVA_DRIVER_VERSION}.jar https://repo1.maven.org/maven2/org/mongodb/bson/${MDB_JAVA_DRIVER_VERSION}/bson-${MDB_JAVA_DRIVER_VERSION}.jar
RUN wget -O /liquibase/lib/mongodb-driver-core-${MDB_JAVA_DRIVER_VERSION}.jar https://repo1.maven.org/maven2/org/mongodb/mongodb-driver-core/${MDB_JAVA_DRIVER_VERSION}/mongodb-driver-core-${MDB_JAVA_DRIVER_VERSION}.jar
RUN wget -O /liquibase/lib/mongodb-driver-sync-${MDB_JAVA_DRIVER_VERSION}.jar https://repo1.maven.org/maven2/org/mongodb/mongodb-driver-sync/${MDB_JAVA_DRIVER_VERSION}/mongodb-driver-sync-${MDB_JAVA_DRIVER_VERSION}.jar