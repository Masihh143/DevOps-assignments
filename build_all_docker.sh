#!/bin/bash
# Master script to build all local Docker images for the DevOps assignment

echo "=== Building Docker Fundamentals Images ==="
(cd DockerFundamentals/Apache-app && docker build -t apache-hello .)
(cd DockerFundamentals/React-app && docker build -t react-hello .)
(cd DockerFundamentals/nginx-app && docker build -t nginx-hello .)
(cd DockerFundamentals/nodejs-app && docker build -t nodejs-hello .)
(cd DockerFundamentals/python-app && docker build -t python-hello .)
(cd DockerFundamentals/java-app && docker build -t java-hello .)

echo ""
echo "=== Building Docker Multi-Stage Image ==="
(cd DockerMultiStage && docker build -t docker-multistage .)

echo ""
echo "=== All Docker Images Built Successfully ==="
docker images | grep -E "apache-hello|react-hello|nginx-hello|nodejs-hello|python-hello|java-hello|docker-multistage"
