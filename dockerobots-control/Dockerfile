FROM robocaster/dockerobots-base:amd64
SHELL ["/bin/bash", "-c"]

# Install some control related Julia packages
RUN /opt/julia-1.8.1/bin/julia -e 'using Pkg; Pkg.add("DifferentiableCollisions"); Pkg.add("StaticArrays")' 
