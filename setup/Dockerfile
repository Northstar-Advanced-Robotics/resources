FROM docker.io/ubuntu:26.04

ENV DEBIAN_FRONTEND=noninteractive \
    CMAKE_EXPORT_COMPILE_COMMANDS=ON \
    CMAKE_GENERATOR=Ninja

RUN apt-get update && apt-get install -y --no-install-recommends \
    xz-utils \
    curl \
    ninja-build \
    cmake \
    clang \
    clangd \
    libboost-log-dev \
  && rm -rf /var/lib/apt/lists/*
