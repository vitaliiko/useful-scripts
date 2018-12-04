
#### Install Docker and docker-compose
apt-cache madison docker-ce  
sudo apt-get install docker-ce=17.09.0~ce-0~ubuntu  

sudo curl -L https://github.com/docker/compose/releases/download/1.16.1/docker-compose-`uname -s`-`uname -m` -o /usr/local/bin/docker-compose  

sudo chmod +x /usr/local/bin/docker-compose  
docker-compose --version  


#### Remove old containers and images
docker ps --filter "status=exited" | grep 'weeks ago' | awk '{print $1}' | xargs --no-run-if-empty docker rm  

docker images | grep 'months ago' | awk '{print $3}' | xargs docker rmi
docker rmi $(docker images -f "dangling=true" -q)  

#### Kill all running containers
docker kill $(docker ps -q)

#### Remove all stopped containers but do not delete volumes
docker rm $(docker ps -aq)

#### Run container and mount current folder to it
docker run -it --rm -w /app -v $(pwd):/app image bash

#### Get the IP for eth0 inside the container
docker inspect --format="{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}"

#### Check size of containers
docker ps -s

#### See last logs
docker logs --since 30s -f <container_name_or_id>
or
docker logs --tail 20 -f <container_name_or_id>

#### Delete log of a container
echo "" > $(docker inspect --format='{{.LogPath}}' <container_name_or_id>)

#### Uninstall Docker
https://stackoverflow.com/questions/31313497/how-to-remove-docker-installed-using-wget  

