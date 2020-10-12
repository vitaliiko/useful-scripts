### Programs to install
1. Chrome
1. [Krusader](https://community.linuxmint.com/software/view/krusader)
1. Telegram
1. Slack
1. Skype
1. Intellij IDEA
1. WebStorm
1. Datagrip
1. MySQL Workbench
1. [SQL Workbench](https://www.sql-workbench.eu/downloads.html)
1. Postman
1. [gnome-alsamixer](https://community.linuxmint.com/software/view/gnome-alsamixer)
1. [ngrok](https://dashboard.ngrok.com/get-started)
1. [Peek](https://mintguide.org/tools/682-peek-simple-animated-gif-screen-recorder.html)

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
Install [plugins for Shutter](https://itsfoss.com/shutter-edit-button-disabled/) ([Copy of the page](https://github.com/vitaliykobrin/useful-scripts/blob/master/saved_pages/How%20To%20Fix%20Disabled%20Edit%20Option%20In%20Shutter%20in%20Ubuntu%2018.04%20%26%20Mint%2019.pdf))

#### [ctop](https://github.com/bcicen/ctop)
```
sudo wget https://github.com/bcicen/ctop/releases/download/v0.7.2/ctop-0.7.2-linux-amd64 -O /usr/local/bin/ctop
sudo chmod +x /usr/local/bin/ctop
```

#### [jq](https://stedolan.github.io/jq/)
```
sudo apt-get install jq
```

#### [Wine](https://computingforgeeks.com/how-to-install-wine-4-on-ubuntu-18-04-linux-mint-19/)
```
sudo dpkg --add-architecture i386 
wget -qO - https://dl.winehq.org/wine-builds/winehq.key | sudo apt-key add -
sudo apt-add-repository 'deb https://dl.winehq.org/wine-builds/ubuntu/ bionic main'
sudo apt-get update
sudo apt install --install-recommends winehq-stable
```

#### CodeShip CLI
```
curl -SLO "https://s3.amazonaws.com/codeship-jet-releases/2.11.0/jet-linux_amd64_2.11.0.tar.gz"
sudo tar -xaC /usr/local/bin -f jet-linux_amd64_2.11.0.tar.gz
sudo chmod +x /usr/local/bin/jet
```

#### Enpass
```
echo "deb https://apt.enpass.io/ stable main" > /etc/apt/sources.list.d/enpass.list
wget -O - https://apt.enpass.io/keys/enpass-linux.key | apt-key add -
apt-get update
apt-get install enpass
```

#### [mdless](https://brettterpstra.com/projects/mdless/)
```
sudo gem install mdless
```

