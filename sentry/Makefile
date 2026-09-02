MAKEFILE_DIR := $(dir $(lastword ${MAKEFILE_LIST}))
-include ${MAKEFILE_DIR}/defaults.mk

# Arguments
IMAGE_NAME ?= northstar/sentry:intro
DOCKER_CMD ?= docker
DOCKER_RUN_ARGS ?= -it --rm -v ${MAKEFILE_DIR}:/ws:Z -w /ws 
COLCON_BUILD_ARGS ?= --symlink-install --event-handlers console_direct+ 
PACKAGE ?=
BUILD_TYPE ?= Debug

BUILD_DIR := ${MAKEFILE_DIR}/build
IMAGE_BUILD_STAMP := ${BUILD_DIR}/image-build-stamp

image-build: ${IMAGE_BUILD_STAMP} ## Build container image
.PHONY: image-build

shell: image-build ## Enter a shell inside container
> @${DOCKER_CMD} run ${DOCKER_RUN_ARGS} ${IMAGE_NAME} bash
.PHONY: shell

compile: ## Compile ROS2 package
> $(if ${PACKAGE} , \
@colcon build ${COLCON_BUILD_ARGS} --packages-up-to ${PACKAGE}, \
@colcon build ${COLCON_BUILD_ARGS})
.PHONY: compile

${IMAGE_BUILD_STAMP}: Dockerfile
> @${DOCKER_CMD} build -t ${IMAGE_NAME} -f Dockerfile 
> @mkdir -p ${BUILD_DIR}
> @touch $@
