if [ -z "$1" ]; then echo "No names was provided for the image. Usage: ./docker_start.sh image_name:tag" && exit 1;fi

sudo docker run -it --network=host $1
