#Note: The following paramters are only effective in building the dockerobot-base image
ROS1='true'
PYTHON_VERSION = '3.8.0'

if [ -z "$1"] || [-z "$2"] || [-z "$3"]; then echo "No names was provided for the image. Usage: ./docker_build.sh image_name:tag base_image:tag dockerfile_path" && exit 1;fi

sudo docker build --force-rm --build-arg PY_VER=$PYTHON_VERSION --build-arg ROS1=$ROS1 --build-arg BASE_IMAGE=$2 -t $1 $3