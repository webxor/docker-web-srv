#!/usr/bin/env bash

dir="$( cd "$( dirname "$0" )" && pwd )"
. $dir/00-config.conf

##	Function for killing container
##
##	Params:
##	$1	$container_name
##
kill_container () {
	echo "START: Killing container '$1'"
	docker kill $1
	echo "DONE: Killing container '$1'"
}

##	Function for removing container
##
##	Params:
##	$1	$container_name
##
remove_container () {
	echo "START: Removing container '$1'"
	docker rm $1
	echo "DONE: Removing container '$1'"
}

kill_container $container_name
remove_container $container_name
