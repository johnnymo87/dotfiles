alias dco="docker compose"
alias dps='docker ps -a --format="{{.Names}}~~{{.Status}}~~{{.Image}}~~{{.Ports}}" | column -t -s ~~'
alias dim='docker images --format '{{.Size}}~~{{.Repository}}:{{.Tag}}~~{{.ID}}' | sort -h | column -t -s ~~'
function docker-rmi {
  docker rmi -f $(docker images | grep '<none>' | awk '{ print $3 }')
}
function docker-rmv {
  docker volume rm $(docker volume ls  -q --filter dangling=true)
}

# Set DOCKER_HOST for Colima
export DOCKER_HOST=unix://$HOME/.colima/default/docker.sock
