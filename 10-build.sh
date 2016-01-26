#!/bin/bash

image_tag='webxor/websrv'

echo 'START: Build image '$image_tag

docker build --tag=$image_tag ./

echo 'FINISH: Build image '$image_tag
