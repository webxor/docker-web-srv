# Docker Web Server

1. Update config file and set your variables
> ./00-config.cfg

2. Create new docker image from Dockerfile
> sh ./10-build.sh

3. Create container by running docker image
> sh ./20-run.sh

4. Execute bash in new container
> sh ./30-exec.sh

5. Kill & remove container from docker
> sh ./80-kill.sh
