FROM ros:foxy
SHELL ["/bin/bash", "-c"]

#Install the prerequisite packages
RUN apt-get update && apt-get install -y ros-foxy-rosidl-generator-cpp libcereal-dev build-essential libboost-all-dev freeglut3 freeglut3-dev \
libedit-dev libtinyxml2-dev libyaml-cpp-dev ros-foxy-ament-cmake-nose python3-pip libglib2.0-dev libxmu-dev libpoco-dev libeigen3-dev python-all-dev\
 curl unzip


# Compile and install python with --enable-shared flag
RUN apt-get install -y make build-essential libssl-dev zlib1g-dev libbz2-dev libreadline-dev libsqlite3-dev wget curl llvm libncurses5-dev libncursesw5-dev xz-utils tk-dev liblzma-dev tk-dev libgdbm-dev libc6-dev curl

RUN cd /home/ && curl -O https://www.python.org/ftp/python/3.8.10/Python-3.8.10.tgz && tar -xvzf Python-3.8.10.tgz

RUN cd /home/Python-3.8.10 &&   ./configure LDFLAGS="-Wl,-rpath /usr/local/lib" --enable-optimizations --enable-shared && make -j "$(nproc)" && make install

RUN cd /home/ && curl -O https://bootstrap.pypa.io/get-pip.py && /bin/python3 get-pip.py && rm -r /home/*


# Install Julia and pycall
RUN cd /opt/ && curl -O https://julialang-s3.julialang.org/bin/linux/x64/1.8/julia-1.8.1-linux-x86_64.tar.gz && tar zxvf julia-1.8.1-linux-x86_64.tar.gz

RUN export PATH=$PATH:/opt/julia-1.8.1/bin/ && python3 -m pip install julia

RUN echo 'import julia' > julia_pycall_install.py && echo 'julia.install()' >> julia_pycall_install.py && export PATH=$PATH:/opt/julia-1.8.1/bin/ && python3 julia_pycall_install.py

# Install python and jupyter bridge support
RUN /opt/julia-1.8.1/bin/julia -e 'using Pkg; Pkg.add("IJulia"); Pkg.add("PyCall")' 


# Install important scientifc computation packages and some commonly used requirements
RUN python3 -m pip install numpy scipy pybullet  jupyterlab lark catkin_pkg nose==1.3.7 empy symforce pyzmq pybullet symforce
RUN apt-get install -y ros-foxy-pinocchio pybind11-dev protobuf-compiler 
 # Compile and Install LCM
RUN cd /home/ && git clone https://github.com/lcm-proj/lcm.git && cd lcm && mkdir build && cd build && cmake .. && make -j"$(nproc)" && make install 

# Start the image with a jupyter notebook
# CMD source /opt/ros/foxy/setup.bash && export PATH=$PATH:/opt/julia-1.8.1/bin/ && jupyter notebook -y --no-browser --allow-root --ip='*' --NotebookApp.token='' --NotebookApp.password=''
CMD source /opt/ros/foxy/setup.bash && export PATH=$PATH:/opt/julia-1.8.1/bin/ && /bin/bash
