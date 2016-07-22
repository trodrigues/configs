# Remove all existing containers
docker-rm-ps(){
  docker rm `docker ps -a -q`
}

# Remove containers using the supplied image name
# So if you did `docker build -t company/project .` you can now do
# `docker-rm-ps-name company/project` to remove any containers based on that
docker-rm-ps-name() {
  docker rm `docker ps -a --filter="ancestor=$1" -q`
}

# Remove all untagged images
docker-rmi-untagged(){
  docker rmi `docker images | awk '$$2 ~ /none/ {print $$3}'`
}

# Remove an image tagged with a given name:
# `docker-rmi-untagged company/project`
docker-rmi-tagged() {
  docker rmi `docker images | grep $1 | awk '{print $3}'`
}

# Stop all running contaienrs
docker-stop-all(){
  docker stop `docker ps -q`
}

# Switch to a new environment when using docker-machine
docker-env-eval(){
  eval "$(docker-machine env $1)"
}
