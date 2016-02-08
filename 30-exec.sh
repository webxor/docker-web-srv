#!/usr/bin/env bash

dir="$( cd "$( dirname "$0" )" && pwd )"
. $dir/00-config.cfg

##	Function for executing BASH in container
##
exec_docker () {
	echo "START: Executing BASH in container '$container_name'"
	docker exec -it $container_name bash
	echo "DONE: Executing BASH in container '$container_name'"
}

exec_docker
