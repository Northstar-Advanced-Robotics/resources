FROM docker.io/ros:jazzy-ros-base

RUN apt-get update && apt-get install -y --no-install-recommends \ 
        clangd \
        clang && \
    rm -r /var/lib/apt/lists/*

