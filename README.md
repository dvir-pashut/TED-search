# TED-search

TED Search
==========

The TED Search Application
--------------------------
- TED Search is a search engine for TED Talks.
- The team writing this search engine uses feature branches and a shippable master branch.
- Up to now they did everything manually, and deployed on a clunky machine. It's time that they up their game - and you are going to do it for them!

The application has two components:
1. The main process - a spring boot "fat jar" application.
2. [BONUS] The cache layer - a Memcached server (or cluster).
   Note: While the application CAN work without memcached - it will work much more slowly...


Application documentation
-------------------------
1. To build use `mvn verify`. The artifact is a jar file in the `target` folder.
2. To execute: `java -jar <the-jar-file> --spring.config.location=./application.properties`.
   Note: Configuration is done in the "application.properties" file.


Work plan
---------
1. Build & Test:
   - Build the jar.
   - Dockerize it.
   - Execute from within Docker, and see functionality.
   - Integrate dockerization into maven build by adding docker plugin to `pom.xml`.

2. E2E Tests:
   - Write an E2E test using python or bash (`curl`).

3. Reverse proxy and FE server:
   - Create compose file that adds an nginx reverse proxy.
   - Package all static files in nginx and serve them directly.
   - Update build so that static files are NOT saved inside the jar.
   - Send me a micro service architecture (write on paper).
   - Bonus: Add Memcached to the docker-compose, enable it on the tedsearch app, connect between the Memcached & the app, and recognize the difference between the performance with or without the Memcached.

4. Dynamic environments:
   - Implement a Terraform script that provisions a machine for an “all-in-one” docker-compose environment. A `t2.micro` should be sufficient.
   - Implement the deployment using either bash and the AWS CLI, or terraform with a `null_resource` or `remote_exec` resources (look for examples in the documentation).

5. Implement CI with tests using Jenkins MBP:
   - Deploy Jenkins server.
   - on any branch:
     - Build
     - Test (unit test)

6. Enhanced CI:
   - Each branch with #test in commit message will:
     - Provision dynamic environment you wrote on stage 4.
     - Deploy using `docker-compose` & the deployment script from stage 4.
     - Run the E2E test you wrote on stage 2.

7. Cleanup and cost maintenance:
   - Implement a job that runs every 15 minutes and sends you a list of all active environments by mail.
   - Implement a Jenkins job that fully removes any TEST environment that is older than 15 minutes and sends a report to you by mail.

