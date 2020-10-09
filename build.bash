#!/bin/bash

echo "SOURCE_COMMIT: $SOURCE_COMMIT"

if [[ -z "$SOURCE_COMMIT" ]]; then
	export SOURCE_COMMIT="${SOURCE_COMMIT:-$(git rev-parse HEAD)}"
	echo "Updating SOURCE_COMMIT from git rev-parse HEAD"
	echo "SOURCE_COMMIT: $SOURCE_COMMIT"
fi
echo "Running build -> docker build -t kube-consult/node-web-app  --build-arg "SOURCE_COMMIT=$SOURCE_COMMIT" ."
docker build -t kube-consult/node-web-app  --build-arg "SOURCE_COMMIT=$SOURCE_COMMIT" .
echo "Stopping container if running -> docker ps --filter label=anz=yes|grep -v CONTAINER|awk '{print $1}'|xargs docker stop"
docker ps --filter label=anz=yes|grep -v CONTAINER|awk '{print $1}'|xargs docker stop
echo "Running -> docker run -p 8080:3000 -d kube-consult/node-web-app:latest"
docker run -p 8080:3000 -d kube-consult/node-web-app:latest    
sleep 10
echo "Running curl localhost:8080/info"
curl localhost:8080/info
echo ""
echo "Check container logs -> docker ps grep kube-consult awk {print $1} xargs docker logs"
docker ps|grep kube-consult|awk '{print $1}'|xargs docker logs
