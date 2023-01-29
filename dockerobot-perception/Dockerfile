ARG BASE_IMAGE
FROM ${BASE_IMAGE}

#Install GTSAM
RUN apt-get update && apt-get install -y libboost-all-dev cmake libtbb-dev 
RUN cd ~ && git clone https://github.com/borglab/gtsam.git && cd gtsam && mkdir build && cd build && \
cmake -DGTSAM_BUILD_PYTHON=1 -DGTSAM_PYTHON_VERSION=3.8.10 .. && make -j$(nproc) && make install && cd ~ && rm -r gtsam

# Install Ceres
RUN apt-get install -y libgoogle-glog-dev libgflags-dev libatlas-base-dev libeigen3-dev libsuitesparse-dev 
RUN cd ~ && git clone https://ceres-solver.googlesource.com/ceres-solver && cd ceres-solver && git checkout 2.1.0 && \
 mkdir build && cd build && cmake .. && make -j$(nproc) && make install && cd ~ && rm -r ceres-solver
 
# Install the openCV

RUN sudo apt install -y build-essential cmake git pkg-config libgtk-3-dev \
    libavcodec-dev libavformat-dev libswscale-dev libv4l-dev \
    libxvidcore-dev libx264-dev libjpeg-dev libpng-dev libtiff-dev \
    gfortran openexr libatlas-base-dev python3-dev python3-numpy \
    libtbb2 libtbb-dev libdc1394-22-dev libopenexr-dev \
    libgstreamer-plugins-base1.0-dev libgstreamer1.0-dev

RUN mkdir ~/opencv_build && cd ~/opencv_build \
&& git clone https://github.com/opencv/opencv.git \
&& git clone https://github.com/opencv/opencv_contrib.git

RUN cd ~/opencv_build/opencv && mkdir -p build && cd build 

RUN cd ~/opencv_build/opencv && mkdir -p build && cd build  && \ 
    cmake -D CMAKE_BUILD_TYPE=RELEASE \
    -D CMAKE_INSTALL_PREFIX=/usr/local \
    -D INSTALL_C_EXAMPLES=ON \
    -D INSTALL_PYTHON_EXAMPLES=ON \
    -D OPENCV_GENERATE_PKGCONFIG=ON \
    -D OPENCV_EXTRA_MODULES_PATH=~/opencv_build/opencv_contrib/modules \
    -DPYTHON_DEFAULT_EXECUTABLE=$(which python3) \
    -D BUILD_EXAMPLES=ON .. && make -j8 && make install

# Install CasADi 
RUN python3 -m pip install casadi

# Install librealsense drivers
RUN apt-get install -y python3-sphinx build-essential git libssl-dev libusb-1.0-0-dev pkg-config libgtk-3-dev
RUN python3 -m pip install sphinx
RUN cd ~ && git clone https://github.com/IntelRealSense/librealsense && cd librealsense && mkdir build && cd build && cmake -DCMAKE_BUILD_TYPE=Release -DBUILD_PYTHON_BINDINGS=ON .. && make -j8 && make install 
RUN rm -r ~/librealsense

# Install Velodyne ROS drivers
# RUN cd ~ && mkdir velodyne && cd velodyne && mkdir src && cd src && git clone https://github.com/ros-drivers/velodyne.git && cd velodyne && git checkout origin/ros2 && \
#  cd ../.. && rosdep install -y --from-path src --ignore-src && colcon build
# RUN echo "source ~/velodyne/install/setup.bash" >> ~/.bashrc

RUN cd /opt/ && wget https://github.com/coder/code-server/releases/download/v4.9.1/code-server_4.9.1_amd64.deb
RUN dpkg -i /opt/code-server_4.9.1_amd64.deb && rm /opt/code-server_4.9.1_amd64.deb

CMD code-server  --auth none /root