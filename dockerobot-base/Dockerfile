ARG BASE_IMAGE
FROM ${BASE_IMAGE}

#Should ROS1 be also installed?
ARG ROS1
# What python version to build?
ARG PY_VER 

SHELL ["/bin/bash", "-c"]
ENV DEBIAN_FRONTEND=noninteractive

# ROS1
# setup sources.list
RUN echo "deb http://packages.ros.org/ros/ubuntu focal main" > /etc/apt/sources.list.d/ros1-latest.list

# setup keys
RUN apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys C1CF6E31E6BADE8868B172B4F42ED6FBAB17C654

RUN if [ "$ROS1" == "true" ]; then echo 'Installing ROS1 ...' && apt-get update && sleep 2&& apt-get install -y --no-install-recommends ros-noetic-ros-base ;fi 

#Install the prerequisite packages
RUN apt-get update && apt-get install -y --no-install-recommends ros-${ROS_DISTRO}-rosidl-generator-cpp libcereal-dev build-essential libboost-all-dev freeglut3 freeglut3-dev \
libedit-dev libtinyxml2-dev libyaml-cpp-dev ros-${ROS_DISTRO}-ament-cmake-nose python3-pip libglib2.0-dev libxmu-dev libpoco-dev libeigen3-dev python-all-dev\
 curl unzip


# Compile and install python with --enable-shared flag
RUN apt-get install -y --no-install-recommends make build-essential libssl-dev zlib1g-dev libbz2-dev libreadline-dev libsqlite3-dev wget curl llvm libncurses5-dev \
    libncursesw5-dev xz-utils tk-dev liblzma-dev tk-dev libgdbm-dev libc6-dev curl

RUN cd /home/ && curl -O https://www.python.org/ftp/python/${PY_VER}/Python-${PY_VER}.tgz && tar -xvzf Python-${PY_VER}.tgz

RUN cd /home/Python-${PY_VER} &&   ./configure LDFLAGS="-Wl,-rpath /usr/local/lib" --enable-optimizations --enable-shared && make -j "$(nproc)" && make install

RUN cd /home/ && curl -O https://bootstrap.pypa.io/get-pip.py && /bin/python3 get-pip.py && rm -r /home/*


# Install Julia and pycall
RUN cd /opt/ && curl -O https://julialang-s3.julialang.org/bin/linux/x64/1.8/julia-1.8.1-linux-x86_64.tar.gz && tar zxvf julia-1.8.1-linux-x86_64.tar.gz

RUN echo 'export PATH=$PATH:/opt/julia-1.8.1/bin/' >> ~/.bashrc && source ~/.bashrc
 
RUN python3 -m pip install julia

RUN echo 'import julia' > julia_pycall_install.py && echo 'julia.install()' >> julia_pycall_install.py && export PATH=$PATH:/opt/julia-1.8.1/bin/ && python3 julia_pycall_install.py

# Install python and jupyter bridge support
RUN /opt/julia-1.8.1/bin/julia -e 'using Pkg; Pkg.add("IJulia"); Pkg.add("PyCall")' 


# Install important scientifc computation packages and some commonly used requirements
RUN python3 -m pip install --upgrade pip
RUN python3 -m pip install markupsafe
RUN python3 -m pip install scipy pybullet lark catkin_pkg nose==1.3.7 empy symforce pyzmq matplotlib
RUN apt-get install -y --no-install-recommends ros-${ROS_DISTRO}-pinocchio pybind11-dev protobuf-compiler 
 # Compile and Install LCM
RUN cd /home/ && git clone https://github.com/lcm-proj/lcm.git && cd lcm && mkdir build && cd build && cmake .. && make -j"$(nproc)" && make install 

# Clean up and environment setup
RUN echo 'export PYTHONPATH=$PYTHONPATH:/usr/local/lib/python3/dist-packages/' >> ~/.bashrc
RUN echo 'export PATH=$PATH:/opt/julia-1.8.1/bin/' >> ~/.bashrc
RUN rm -rf /var/lib/apt/lists/*

# Entry Point Command
CMD /bin/bash
