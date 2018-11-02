
#### Install Docker and docker-compose
apt-cache madison docker-ce  
sudo apt-get install docker-ce=17.09.0~ce-0~ubuntu  

sudo curl -L https://github.com/docker/compose/releases/download/1.16.1/docker-compose-`uname -s`-`uname -m` -o /usr/local/bin/docker-compose  

sudo chmod +x /usr/local/bin/docker-compose  
docker-compose --version  


#### Remove old containers and images
docker ps --filter "status=exited" | grep 'weeks ago' | awk '{print $1}' | xargs --no-run-if-empty docker rm  
docker rmi $(docker images -f "dangling=true" -q)  


#### Uninstall Docker
https://stackoverflow.com/questions/31313497/how-to-remove-docker-installed-using-wget  

