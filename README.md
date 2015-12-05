# go-box
This is a Docker container which contains Vim and all the necessary plugins for Go development.

## 1. Setup Docker
### Brew
```bash
brew update
brew upgrade
brew install docker docker-compose docker-machine
```
[Other Install Instructions](https://docs.docker.com/engine/installation/)

## 2. Build Image
### Mac OS
```bash
docker-machine create gobox -d virtualbox
eval $(docker-machine env go-ide)
docker build -t gobox .
```

## 3. Start Container
```bash
docker run -v $(pwd):/project -ti gobox
```

