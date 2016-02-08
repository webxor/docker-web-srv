#!/usr/bin/env bash

dir="$( cd "$( dirname "$0" )" && pwd )"
. $dir/00-config.cfg

##	Function for killing container
##
kill_container () {
	echo "START: Killing container '$container_name'"
	docker kill $container_name
	echo "DONE: Killing container '$container_name'"
}

##	Function for removing container
##
remove_container () {
	echo "START: Removing container '$container_name'"
	docker rm $container_name
	echo "DONE: Removing container '$container_name'"
}

kill_container
remove_container
