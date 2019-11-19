#!/bin/bash

set -f

server=$DEPLOY_RESOURCE_SERVER
user=$DEPLOY_USER
branch=$DEPLOY_BRANCH
gittoken=$DEPLOY_GITLAB_TOKEN
gituser=$DEPLOY_GITLAB_USER

echo "Deploying project resources on server ${server} as ${user} from branch ${branch}"

apt-get update && apt-get install -y openssh-client
 
#  rm -rf /home/ubuntu/gablum && \
#  mkdir -p /home/ubuntu/gablum && \
#  cd /home/ubuntu/gablum && \


command="ls -ltr && \
 git clone https://${gituser}:${gittoken}@gitlab.stackroute.in/gablum/gablum_resources.git -b ${branch} && \
 cd /home/ubuntu/gablum_resources && \
 ls -ltr && \
 echo 'Deploying the Gablum Application Resources' && \
 docker-compose -f docker-compose-resources.yml up --build -d --remove-orphans && \
 echo 'DONE DEPLOYING'"

echo "About to run the command: " $command

ssh $user@$server $command
