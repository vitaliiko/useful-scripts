
#### Install Docker and docker-compose
Use [the script](https://github.com/vitaliykobrin/useful-scripts/blob/master/scripts/install-docker.sh)


#### Remove old containers and images
docker ps --filter "status=exited" | grep 'weeks ago' | awk '{print $1}' | xargs --no-run-if-empty docker rm  

docker images | grep 'months ago' | awk '{print $3}' | xargs docker rmi
docker rmi $(docker images -f "dangling=true" -q)  

#### Remove images filtered by grep
docker images | grep <word> | awk '{print $3}' | xargs docker rmi

#### Kill all running containers
docker kill $(docker ps -q)

#### Remove all stopped containers but do not delete volumes
docker rm $(docker ps -aq)

#### Remove all images of certain repository
docker rmi $(docker images -q ubuntu)

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

#### Copy data between Docker container and host
docker cp CONTAINER:SRC_PATH DEST_PATH
docker cp SRC_PATH CONTAINER:DEST_PATH

#### Run ctop
docker run --rm -ti --name=ctop -v /var/run/docker.sock:/var/run/docker.sock quay.io/vektorlab/ctop:latest
