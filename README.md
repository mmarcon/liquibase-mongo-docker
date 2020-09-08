# liquibase-mongo-docker

Attempt at packaging Liquibase and its MongoDB extension inside a Docker image.

## Links
* [Liquibase](https://github.com/liquibase/liquibase)
* [Liquibase official Docker image](https://github.com/liquibase/docker) (without MongoDB extension)
* [Liquibase MongoDB extension](https://github.com/liquibase/liquibase-mongodb)

## How to use it

First, build the Docker image

```bash
$ docker build . --tag "liquibase-mongo:4.0.0"  
```

Then use it like this:

```bash
$ docker run --rm -v \
"`pwd`/example/changelog:/liquibase/changelog" liquibase-mongo:4.0.0 \
--url="mongodb://host.docker.internal:27017/liquibase_test" --changeLogFile=changelog/changelog.xml --logLevel=info update
```
> *Note:* Because Liquibase runs inside the Docker container and I am testing it against a local `mongod` running outside docker, I am pointing to it by
> using `host.docker.internal:27017` as the host.

### Test that it worked

You can use [Compass](https://www.mongodb.com/products/compass) to check that the namespace `liquibase_test.myCollection` exists, has an index on `name` and some schema validation rules.

You can also use [MongoDB for VS Code](https://marketplace.visualstudio.com/items?itemName=mongodb.mongodb-vscode), connect to your local MongoDB Server and run the [verify.mongodb](./example/playgrounds/verify.mongodb) playground.

You can run the same playground file from the new MongoDB Shell:

```bash
$ mongosh
Current sessionID:  6e6edacc4e2d50aa4430fb22
Connecting to:      mongodb://127.0.0.1:27017
Using MongoDB:      4.4.0
Using Mongosh Beta: 0.2.1

For more information about mongosh, please see our docs: https://docs.mongodb.com/mongodb-shell/

> .load ./example/playgrounds/veryfy.mongodb
```

## Known issues
* Does not work with a connection screen that uses the `mongodb+srv://` protocol yet. Looks like Liquibase uses the protocol in the URI to select the extension to use and for MongoDB it only supports `mongodb://`.
* The `generateChangeLog` command is currently not supported for MongoDB.