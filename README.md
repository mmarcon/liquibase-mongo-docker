# liquibase-mongo-docker

Attempt at packaging Liquibase and its MongoDB extension inside a Docker image.

## Links
* [Liquibase](https://github.com/liquibase/liquibase)
* [Liquibase official Docker image](https://github.com/liquibase/docker) (without MongoDB extension)
* [Liquibase MongoDB extension](https://github.com/liquibase/liquibase-mongodb)

## How to use it

When this works, here is how I'd expect to use it.

```bash
$ docker build . --tag "liquibase-mongo:4.0.0"  
$ docker run --rm -v \
"`pwd`/example/changelog:/liquibase/changelog" liquibase-mongo:4.0.0 \
--url="mongodb://host.docker.internal:27017/liquibase_test" --changeLogFile=changelog/changelog.xml --logLevel=info update
```

The [example/playgrounds/seed-db.mongodb](example/playgrounds/seed-db.mongodb) contains a [MongoDB Playground](https://marketplace.visualstudio.com/items?itemName=mongodb.mongodb-vscode#mongodb-playgrounds) file to seed a test DB.