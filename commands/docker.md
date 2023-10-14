## Docker

### Install Docker and docker-compose
Use [the script](https://github.com/vitaliykobrin/useful-scripts/blob/master/scripts/install-docker.sh)

### Login
```
docker login -u $username -p $password
```

### Clean up

Remove old non-running containers
```
docker ps --filter "status=exited" | grep 'weeks ago' | awk '{print $1}' | xargs --no-run-if-empty docker rm  
```

Remove old not bound with containers images
```
docker images | grep 'months ago' | awk '{print $3}' | xargs docker rmi
```

Remove dangling images
```
docker rmi $(docker images -f "dangling=true" -q)  

or 

docker image prune
```

Remove non-used volumes
```
docker volume prune
```

Remove images filtered by grep
```
docker images | grep <word> | awk '{print $3}' | xargs docker rmi
```

Remove containers filtered by grep
```
docker ps -a | grep <word> | awk '{print $1}' | xargs docker rm
```

Kill all running containers
```
docker kill $(docker ps -q)
```

Remove all stopped containers but do not delete volumes
```
docker rm $(docker ps -aq)
```

Remove all images of certain repository
```
docker rmi $(docker images -q ubuntu)
```

### Images

Build an image
```
docker build -t image-name .
```

Build an image without cache
```
docker build -t image-name . --no-cache
```

### Containers

Run container and mount current folder to it
```
docker run -it --rm -w /app -v $(pwd):/app image bash
```

Mount SSH Keys into a Docker Container
```
docker run --rm -it -v ~/.ssh:/root/.ssh:ro alpine
```

Get names of running containers
```
docker ps --format '{{.Names}}'
```

Run container with ulimit parameter in case "file-descriptors limit is too low" or something similar happened
```
docker run --ulimit nofile=65535:65535 image_name
```

Update restart policy of a container 
```
docker update --restart always <container>
```

Attach a running container to a network
```
docker network connect <network> <container>
```

Check size of containers
```
docker ps -s
```

Copy data between Docker container and host
```
docker cp CONTAINER:SRC_PATH DEST_PATH
docker cp SRC_PATH CONTAINER:DEST_PATH
```

#### Inspect a container

Inspect mounts of a container
```
docker inspect -f "{{ .Mounts }}" <container>
```

Check restart policy of a container
```
docker inspect -f "{{ .HostConfig.RestartPolicy }}" <container>
```

Get the IP of eth0 inside the container
```
docker inspect --format="{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}" <container>
```

List all networks a container belongs to
```
docker inspect -f '{{range $key, $value := .NetworkSettings.Networks}}{{$key}} {{end}}' <container>
```

List all containers belonging to a network by name
```
docker network inspect -f '{{range .Containers}}{{.Name}} {{end}}' <network>
```

Get ICC setting for a specific network
```
docker inspect -f '{{index .Options "com.docker.network.bridge.enable_icc"}}' <network>
```

#### Logs

See last logs
```
docker logs --since 30s -f <container_name_or_id>
or
docker logs --tail 20 -f <container_name_or_id>
```

Find container log file
```
docker inspect --format='{{.LogPath}}' container
```

Delete log of a container
```
echo "" > $(docker inspect --format='{{.LogPath}}' <container_name_or_id>)
```

### Tools

#### Resolve `vm.max_map_count` issue in Windows
```
wsl -d docker-desktop
sysctl -w vm.max_map_count=262144
```

#### Run ctop
```
docker run --rm -ti --name=ctop -v /var/run/docker.sock:/var/run/docker.sock quay.io/vektorlab/ctop:latest
```

#### Check size occupied by containers and their volumes
Use [the script](https://github.com/vitaliykobrin/useful-scripts/blob/master/scripts/docker-size.sh)
