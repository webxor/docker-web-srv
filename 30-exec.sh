#!/usr/bin/env bash

dir="$( cd "$( dirname "$0" )" && pwd )"
. $dir/00-config.conf

##	Function for executing BASH in container
##
##	Params:
##	$1	$container_name
##
exec_docker () {
	echo "START: Executing BASH in container '$1'"
	docker exec -it $1 bash
	echo "DONE: Executing BASH in container '$1'"
}

exec_docker $container_name
