# liquibase-mongo-docker

Liquibase and its MongoDB extension conveniently packaged in a Docker image that works out of the box.

## Links
* [Liquibase](https://github.com/liquibase/liquibase)
* [Liquibase official Docker image](https://github.com/liquibase/docker) (without MongoDB extension)
* [Liquibase MongoDB extension](https://github.com/liquibase/liquibase-mongodb)

## How to use it

First, build the Docker image

```bash
$ docker build . --tag "liquibase-mongo:4.2.2"  
```

Then use it as follow.

### Update

```bash
$ docker run --rm -v \
"`pwd`/example/changelog:/liquibase/changelog" liquibase-mongo:4.2.2 \
--url="mongodb://host.docker.internal:27017/liquibase_test" --changeLogFile=changelog/changelog.xml --logLevel=info update
```

### Tag current version

```bash
$ docker run --rm -v \
"`pwd`/example/changelog:/liquibase/changelog" liquibase-mongo:4.2.2 \
--url="mongodb://host.docker.internal:27017/liquibase_test" --logLevel=info tag tagName
```
### Rollback

#### Rollback by count

```bash
$ docker run --rm -v \
"`pwd`/example/changelog:/liquibase/changelog" liquibase-mongo:4.2.2 \
--url="mongodb://host.docker.internal:27017/liquibase_test" --changeLogFile=changelog/changelog.xml --logLevel=info rollbackCount 1
```

#### Rollback to tag

```bash
$ docker run --rm -v \
"`pwd`/example/changelog:/liquibase/changelog" liquibase-mongo:4.2.2 \
--url="mongodb://host.docker.internal:27017/liquibase_test" --changeLogFile=changelog/changelog.xml --logLevel=info rollback tagName
```

> *Note:* Because Liquibase runs inside the Docker container and I am testing it against a local `mongod` running outside docker, I am pointing to it by
> using `host.docker.internal:27017` as the host.

### Test that it worked

* After running `update` You can use [Compass](https://www.mongodb.com/products/compass) to check that the namespace `liquibase_test.myCollection` exists, has an index on `name` and some schema validation rules where the `name` field is required. You can also use [MongoDB for VS Code](https://marketplace.visualstudio.com/items?itemName=mongodb.mongodb-vscode), connect to your local MongoDB Server and run the [verify-update.mongodb](./example/playgrounds/verify-update.mongodb) playground.
* After running `rollbackCount 1` You can use [Compass](https://www.mongodb.com/products/compass) to check that the namespace `liquibase_test.myCollection` exists, has an index on `name` and some schema validation rules where the `name` and `address` fields are required. You can also use [MongoDB for VS Code](https://marketplace.visualstudio.com/items?itemName=mongodb.mongodb-vscode), connect to your local MongoDB Server and run the [verify-rollback.mongodb](./example/playgrounds/verify-rollback.mongodb) playground.

You can run the same playground files from the new MongoDB Shell. For example, to verify the update:

```bash
$ mongosh
Current sessionID:  6e6edacc4e2d50aa4430fb22
Connecting to:      mongodb://127.0.0.1:27017
Using MongoDB:      4.4.0
Using Mongosh Beta: 0.6.1

For more information about mongosh, please see our docs: https://docs.mongodb.com/mongodb-shell/

> .load ./example/playgrounds/verify-update.mongodb
```

## Known issues
* The `generateChangeLog` command is currently not supported for MongoDB.
