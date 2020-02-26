# deploy-expressapp-to-k8s
## Summary
This repository demostrates CI pipeline for NodeJS app and its deployment to kubernetes

* This app is written in NodeJS
* Developed using expressjs framework
* Travis-ci is used for creating a CI pipeline that gets triggered on each push & tag
* This application is intended to run as docker container

This NodeJS app has following API

API | Response
-----|--------
/version | {"deploy-expressapp-to-k8s":[{"version":"1.0.0","description":"Sample expressjs app to demonstrate CI pipeline and deployment to kubernetes","lastcommitsha":"7fb7302"}]}

## Build, Test and Run on development environment
```npm install``` to install modules

```npm test``` to run tests

```npm run start``` to start development server

## Travis-CI & versioning
* This repository has been configured with Travis CI to build docker images and publish them to docker hub when new code is committed and pushed
* docker images are pushed when code is merged to master branch (latest tag for docker)
* docker images are pushed when a tag is pushed (pushed tag for docker)

Travis undergoes following stages
### Test stage
```
npm install
npm test
```
Installs dependency modules and runs test

### Build & Publish stage
Build and publish stage is handled by deploy section which runs docker_push.sh script. Script, depending on whether build is triggered by tag or push to master branch, decides the docker image tag that will be pushed to docker hub.

To set DOCKER_USERNAME & DOCKER_PASS in travis environment variables, use https://hub.docker.com/r/skandyla/travis-cli/ docker image or install travis gem locally.

To lint .travis.yml
```
docker run -v $(pwd):/project --rm skandyla/travis-cli lint .travis.yml
```

Travis builds can be located here
https://travis-ci.org/saurabhpandit/deploy-expressapp-to-k8s

Published docker images can be located here
https://hub.docker.com/r/saurabhcpandit/deploy-expressapp-to-k8s/tags

To run recently published docker image
```
docker run -p 8080:8080 -t -i saurabhcpandit/deploy-expressapp-to-k8s:latest
```

To run specific version 
```
docker run -p 8080:8080 -t -i saurabhcpandit/deploy-expressapp-to-k8s:<version tag>
```

## Build & Run docker image locally
To build docker image
```
docker build -t deploy-expressapp-to-k8s --build-arg SHA=$(git rev-parse --short HEAD) .
```

To run docker image
```
docker run -p 8080:8080 -t -i deploy-expressapp-to-k8s
```

## Deploy to kubernetes on Docker for Desktop (Windows)
Following script will create technical-test namespace if it doesn't exist and apply service and deployment manifests.

Currently following script will deploy saurabhcpandit/deploy-expressapp-to-k8s:latest. If you wish to deploy a different version, update the image tag in deploy\nodeapi-deployment.yaml manifest and re-run.

```
# Assuming pwd is root directory of the repository
.\deploy\deploy-to-k8s.ps1
```

# Limitations & Risks
1. Authentication mechanism has not been implemented
2. Logging has not been implemented 
3. Use of process managers has not been considered
4. API is exposed over HTTP instead of HTTPS
5. TravisCI is configured to build all branches
6. Recursive copy in Dockerfile which could be avoided
7. Assumes that deployment will occur on Docker for Desktop (Windows).