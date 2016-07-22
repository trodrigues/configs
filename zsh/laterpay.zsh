laterpay-stop() {
  docker-stop-all
  tmux kill-session -t laterpay
}

laterpay-build-all-images() {
  for i in * ; do
    if [ -f $i/Dockerfile ] ; then
      pushd $i
      docker build -t laterpay/$i .
      popd
    fi
  done
}

laterpay-postgres-docker() {
  POSTGRES_DOCKER_CONTAINER=$(docker-compose ps | grep postgres | awk '{print $1}')
  docker exec -it -u postgres $POSTGRES_DOCKER_CONTAINER bash
}
