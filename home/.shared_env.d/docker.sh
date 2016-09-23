###############################################################################
# Docker
#
# Environment settings for Docker and Boot2Docker
#
# Docker
#
# Docker is an open-source project that automates the deployment of
# applications inside software containers, by providing an additional layer
# of abstraction and automation of operating-system-level virtualization on
# Linux. Docker uses resource isolation features of the Linux kernel such
# as cgroups and kernel namespaces to allow independent "containers" to run
# within a single Linux instance, avoiding the overhead of starting and
# maintaining virtual machines.
#
# Boot2Docker
#
# Boot2Docker is a lightweight Linux distribution made specifically to run
# Docker containers. It runs completely from RAM, is a small ~24MB download
# and boots in ~5s (YMMV).
#
# Boot2Docker is currently designed and tuned for development. Using it for
# any kind of production workloads at this time is highly discouraged.
#
# https://www.docker.com/
# https://en.wikipedia.org/wiki/Docker_(software)
# https://github.com/docker/docker
# http://boot2docker.io/
# https://github.com/boot2docker/boot2docker
# https://github.com/odewahn/docker-jumpstart/
###############################################################################

# Boot2Docker environment variables.
#
# These environment variables are the equivalent to what it output by
# `boot2docker up`, but generalized to be portable between environments.
if is_macos
then
  export DOCKER_HOST="tcp://$(boot2docker ip 2>/dev/null):2376"
  export DOCKER_CERT_PATH="${HOME}/.boot2docker/certs/boot2docker-vm"
  export DOCKER_TLS_VERIFY=1
fi
