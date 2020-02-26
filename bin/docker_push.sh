#!/bin/bash
echo "$DOCKER_PASSWORD" | docker login -u "$DOCKER_USERNAME" --password-stdin

docker images

if [[ -z "${TRAVIS_TAG}" ]]; then
    docker tag $DOCKER_USERNAME/deploy-expressapp-to-k8s:$TRAVIS_BUILD_NUMBER $DOCKER_USERNAME/deploy-expressapp-to-k8s:latest
    docker push $DOCKER_USERNAME/deploy-expressapp-to-k8s:$TRAVIS_BUILD_NUMBER
else
    echo "travis tag set"
    docker tag $DOCKER_USERNAME/deploy-expressapp-to-k8s:$TRAVIS_BUILD_NUMBER $DOCKER_USERNAME/deploy-expressapp-to-k8s:$TRAVIS_TAG
    docker push $DOCKER_USERNAME/deploy-expressapp-to-k8s:$TRAVIS_TAG
fi