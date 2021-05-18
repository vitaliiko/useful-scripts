#!/usr/bin/env bash

./gradlew --stacktrace sonarqube \
  -Dsonar.projectKey=test-project \
  -Dsonar.host.url=${SONARQUBE_HOST} \
  -Dsonar.login=${SONARQUBE_TOKEN}
