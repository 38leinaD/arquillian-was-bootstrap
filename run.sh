#!/bin/bash

function cleanup {
    docker stop was9
}

trap cleanup EXIT

# Build WAS 9 container with security disabled
docker build -t was:9.0.0.6 websphere-docker
# Run container and expose ports needed by arquillian (9060 & 8880)
docker run --rm --name was9 -h localhost -e HOST_NAME=localhost -p 9060:9060 -p 9080:9080 -p 8880:8880 -v ~/.m2:/home/was/.m2 -d was:9.0.0.6
# Within container build arquillian-was-adapter
docker exec -w /home/was was9 git clone https://github.com/arquillian/arquillian-container-was.git
docker cp run-in-container.sh was9:/home/was/
docker exec -w /home/was was9 sh run-in-container.sh
# Copy IBM Java 8 out of container to host
rm -rf ibmjava
docker cp was9:/opt/IBM/WebSphere/AppServer/java/8.0 ibmjava/
echo "Add this to your build.gradle!"
echo "******************************************************"
echo "test {"
echo "    executable =\"$(pwd)/ibmjava/bin/java\""
echo "}"
echo "******************************************************"
echo "Press any key to continue..."
pause
docker logs -f was9