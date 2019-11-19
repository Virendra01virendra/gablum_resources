#!/bin/bash

set -f

server=$DEPLOY_RESOURCE_SERVER
user=$DEPLOY_USER
branch=$DEPLOY_BRANCH
gittoken=$DEPLOY_GITLAB_TOKEN
gituser=$DEPLOY_GITLAB_USER

echo "Deploying project resources on server ${server} as ${user} from branch ${branch}"

apt-get update && apt-get install -y openssh-client
## Rolling Update

# command="ls -ltr && \
#  cd /home/devuser/gablumplatform && \
#  git pull origin ${branch} && \
#  docker-compose up --build -d --remove-orphans && \
#  echo 'DONE DEPLOYING'"

#Complete Build

# docker-compose -f /home/ubuntu/gablum/gablumplatform/docker-compose.yml down && \

# cd /home/ubuntu/gablum/gablum_resources && \
#  docker-compose -f docker-compose-resources.yml down && \ 
 
command="ls -ltr && \
 rm -rf /home/ubuntu/gablum && \
 mkdir -p /home/ubuntu/gablum && \
 cd /home/ubuntu/gablum && \
 git clone https://${gituser}:${gittoken}@gitlab.stackroute.in/gablum/gablum_resources.git -b ${branch} && \
 cd /home/ubuntu/gablum/gablum_resources && \
 echo 'listing things' && \
 ls -ltr && \
 echo 'Deploying the Gablum Application's Resources' && \
 docker-compose -f docker-compose-resources.yml up --build -d --remove-orphans && \
 echo 'DONE DEPLOYING'"

echo "About to run the command: " $command

ssh $user@$server $command