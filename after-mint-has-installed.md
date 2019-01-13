### Programs to install
1. Chrome
1. RescueTime
1. [Krusader](https://community.linuxmint.com/software/view/krusader)
1. Slack
1. MySQL Workbench
1. [SQL Workbench](https://www.sql-workbench.eu/downloads.html)
1. Postman
1. [gnome-alsamixer](https://community.linuxmint.com/software/view/gnome-alsamixer)
1. [ngrok](https://dashboard.ngrok.com/get-started)

### Packages to install
#### NVIDIA drivers
```
sudo add-apt-repository ppa:graphics-drivers/ppa
sudo apt update
sudo apt install nvidia-390 nvidia-settings
```

#### Docker and docker-compose
Use [the script](https://github.com/vitaliykobrin/useful-scripts/blob/master/scripts/install-docker.sh)

#### Git
```
sudo apt install git
```

#### Sublime Text
```
wget -qO - https://download.sublimetext.com/sublimehq-pub.gpg | sudo apt-key add -
echo "deb https://download.sublimetext.com/ apt/stable/" | sudo tee /etc/apt/sources.list.d/sublime-text.list
sudo apt-get update
sudo apt-get install sublime-text
```

#### Shutter
```
sudo add-apt-repository ppa:shutter/ppa
sudo apt-get update && sudo apt-get install shutter
```
