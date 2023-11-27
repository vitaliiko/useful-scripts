## Docker

### Login
```bash
docker login -u $username -p $password
```

### Clean up
Remove old non-running containers
```bash
docker ps --filter "status=exited" | grep 'weeks ago' | awk '{print $1}' | xargs --no-run-if-empty docker rm  
```

Remove old not bound with containers images
```bash
docker images | grep 'months ago' | awk '{print $3}' | xargs docker rmi
```

Remove dangling images
```bash
docker rmi $(docker images -f "dangling=true" -q)  
```
or 
```bash
docker image prune
```

Remove non-used volumes
```bash
docker volume prune
```

Remove images filtered by grep
```bash
docker images | grep <word> | awk '{print $3}' | xargs docker rmi
```

Remove containers filtered by grep
```bash
docker ps -a | grep <word> | awk '{print $1}' | xargs docker rm
```

Kill all running containers
```bash
docker kill $(docker ps -q)
```

Remove all stopped containers but do not delete volumes
```bash
docker rm $(docker ps -aq)
```

Remove all images of certain repository
```bash
docker rmi $(docker images -q ubuntu)
```

### Images
Build an image
```bash
docker build -t image-name .
```

Build an image without cache
```bash
docker build -t image-name . --no-cache
```

### Containers
Run container and mount current folder to it
```bash
docker run -it --rm -w /app -v $(pwd):/app image bash
```

Mount SSH Keys into a Docker Container
```bash
docker run --rm -it -v ~/.ssh:/root/.ssh:ro alpine
```

Get names of running containers
```bash
docker ps --format '{{.Names}}'
```

Run container with ulimit parameter in case "file-descriptors limit is too low" or something similar happened
```bash
docker run --ulimit nofile=65535:65535 image_name
```

Update restart policy of a container 
```bash
docker update --restart always <container>
```

Attach a running container to a network
```bash
docker network connect <network> <container>
```

Check size of containers
```bash
docker ps -s
```

Copy data between Docker container and host
```bash
docker cp CONTAINER:SRC_PATH DEST_PATH
docker cp SRC_PATH CONTAINER:DEST_PATH
```

### Inspect a container
Inspect mounts of a container
```bash
docker inspect -f "{{ .Mounts }}" <container>
```

Check restart policy of a container
```bash
docker inspect -f "{{ .HostConfig.RestartPolicy }}" <container>
```

Get the IP of eth0 inside the container
```bash
docker inspect --format="{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}" <container>
```

List all networks a container belongs to
```bash
docker inspect -f '{{range $key, $value := .NetworkSettings.Networks}}{{$key}} {{end}}' <container>
```

List all containers belonging to a network by name
```bash
docker network inspect -f '{{range .Containers}}{{.Name}} {{end}}' <network>
```

Get ICC setting for a specific network
```bash
docker inspect -f '{{index .Options "com.docker.network.bridge.enable_icc"}}' <network>
```

### Logs
See last logs
```bash
docker logs --since 30s -f <container_name_or_id>
or
docker logs --tail 20 -f <container_name_or_id>
```

Find container log file
```bash
docker inspect --format='{{.LogPath}}' container
```

Delete log of a container
```bash
echo "" > $(docker inspect --format='{{.LogPath}}' <container_name_or_id>)
```

### Tools
#### Resolve `vm.max_map_count` issue in Windows
```bash
wsl -d docker-desktop
sysctl -w vm.max_map_count=262144
```

#### Run ctop
```bash
docker run --rm -ti --name=ctop -v /var/run/docker.sock:/var/run/docker.sock quay.io/vektorlab/ctop:latest
```
