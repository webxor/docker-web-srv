#!/bin/bash

container_name='websrv'

docker kill $container_name
docker rm $container_name
