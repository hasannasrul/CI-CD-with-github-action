#!/bin/bash

# check if there is already a existing container with t he same label
existing_container=$(docker ps -q -f label=flask-app)
if [ -n "$existing_container" ]; then
    # stopping old running container
    docker stop $existing_container
fi

# removing old images from server
docker images prune -a -f 

# capturing run number and user from argument of workflow
run_number="$1"
docker_user="$2"

echo "============= RUN NUMBER ==========" $run_number
echo "============= user ==========" $docker_user

# deploying container
docker run -p 3000:3000 -d -l flask-app $docker_user/flask-simple-app:$run_number