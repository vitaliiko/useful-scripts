#!/bin/sh

# List all docker containers  + volume sizes
#
# Usage: `./docker-size.sh -a` to print all containers
# `./docker-size.sh "-a -f "name=smart""` to filter containers by name

container_filter=$1

volumes=$(docker system df -v | awk '/Local Volumes space usage:/,/Build cache usage:/' | tail -n +4 | head -n $(($Count -2)) | awk '{print "ID: "$1" Size: "$3}') 
containers=$(docker container ls $1 --format "{{.ID}} {{.Names}} :{{.Size}}" | tail -n +1)

echo "$containers" | while IFS= read -r container ; do 
	container_id=$(echo $container | awk '{print $1}')
	container_name=$(echo $container | awk '{print $2}')
	container_size=$(echo $container | awk -F'[:]' '{print $2}')
	container_mounts=$(docker inspect --format "{{.Mounts}}" $container_id)
	
	echo CONTAINER: $container_name $container_size
	echo VOLUMES:
	echo "$volumes" | awk '{print $2}' | while IFS= read -r volume ; do 
		if [ "$(echo $container_mounts | grep $volume)" ] 
		then
			echo "$volumes" | grep $volume
		fi
	done
	echo
done

