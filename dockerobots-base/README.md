# dockeRobot Core

A core image containing important core robotic frameworks, libraries, and programming language supports. The packages included are as follows:

## Building the Image
An image may be build with the following command:

```bash
docker build -t <image_name:tag> .
```
Equivalently, you could directly used the prebuilt image on Dockerbub:

```
docker run -it robocaster/dockerobots-base:v1.0
```

## Start the Image

Running the image using the following command starts up a jupyter notebook server that can be accessed through the host browser:

```bash
sudo docker run -it --network host <image_name:tag>
```
