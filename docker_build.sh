if [ -z "$1"] || [-z "$2"] || [-z "$3"]; then echo "No names was provided for the image. Usage: ./docker_build.sh image_name:tag base_image:tag dockerfile_path" && exit 1;fi

#Note: PY_VER and ROS1 paramters are only effective in building the dockerobot-base image
sudo docker build --force-rm --build-arg PY_VER='3.8.0' --build-arg ROS1='true' --build-arg BASE_IMAGE=$2 -t $1 $3