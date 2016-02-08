#!/usr/bin/env bash

dir="$( cd "$( dirname "$0" )" && pwd )"
. $dir/00-config.cfg

##	Function for building new image from Dockerfile
##
build_docker () {
	echo "START: Build image $image_tag"
	docker build --tag=$image_tag ./
	echo "DONE: Build image $image_tag"
}

build_docker
