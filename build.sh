#!/bin/bash -e
docker run -it --rm -v "$PWD":/usr/src -w /usr/src maven:3-jdk-8 mvn assembly:assembly
