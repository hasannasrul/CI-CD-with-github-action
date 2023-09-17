#!/bin/bash

# check if there is already a existing container with t he same label
existing_container=$(docker ps -q -f label=flask-app)
if [ -n "$existing_container" ]; then
    # stopping old running container
    docker stop $existing_container
fi

# removing old images from server
# docker images prune -a -f 

# capturing run number from argument of worflow
run_number="$1"
# echo "*** RUN NUMBER ******* \t" $run_number

# deploying container
docker run -p 3000:3000 -d -l flask-app $user/flask-simple-app:$run_number