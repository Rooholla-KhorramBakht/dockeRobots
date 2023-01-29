if [ -z "$1"] || [-z "$2"]; then echo "Wrong arguments. Usage: ./docker_build.sh image_name:tag base_image_tag" && exit 1;fi

sudo docker build --force-rm --build-arg BASE_TAG=$2 -t $1 .