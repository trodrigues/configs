docker-rm-ps(){
  docker rm `docker ps -a -q`
}

docker-rm-ps-name() {
  docker rm `docker ps -a --filter="ancestor=$1" -q`
}

docker-rmi-untagged(){
  docker rmi `docker images | awk '$$2 ~ /none/ {print $$3}'`
}

docker-rmi-tagged() {
  docker rmi `docker images | grep $1 | awk '{print $3}'`
}

docker-stop-all(){
  docker stop `docker ps -q`
}

docker-env-eval(){
  eval "$(docker-machine env $1)"
}
