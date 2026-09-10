FROM docker.io/ros:jazzy-ros-base

# Add packages here
RUN apt-get update && apt-get install -y --no-install-recommends \ 
        clangd \
        bash-completion \
        clang && \
    rm -rf /var/lib/apt/lists/*

