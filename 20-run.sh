#!/usr/bin/env bash

dir="$( cd "$( dirname "$0" )" && pwd )"

. $dir/00-config.conf
. $dir/00-helper.sh

create_container
clean_images
