ROOT_DIR:=$(shell dirname $(realpath $(lastword $(MAKEFILE_LIST))))

CONTAINER_CODE_DIR=/opt/code

DOCKER_REGISTRY=index.docker.io/flounderpinto

DOCKER_REPO=runner-bash
DOCKER_BUILD_BRANCH_CMD=dockerBuildStandardBranch -e ${DOCKER_REGISTRY} -r ${DOCKER_REPO} ${ARGS}
DOCKER_BUILD_MAIN_CMD=dockerBuildStandardMain -e ${DOCKER_REGISTRY} -r ${DOCKER_REPO} ${ARGS}
DOCKER_BUILD_TAG_CMD=dockerBuildStandardTag ${TAG} -e ${DOCKER_REGISTRY} -r ${DOCKER_REPO} ${ARGS}
DOCKER_BUILDER_IMAGE=flounderpinto/builder-docker:v0.0.10
DOCKER_BUILDER_PULL_CMD=docker pull ${DOCKER_BUILDER_IMAGE}
DOCKER_BUILDER_RUN_CMD=${DOCKER_BUILDER_PULL_CMD} && \
    docker run \
        --rm \
        -v /var/run/docker.sock:/var/run/docker.sock \
        -v ${HOME}/.docker:/tmp/.docker:ro \
        -v ${ROOT_DIR}:${CONTAINER_CODE_DIR} \
        -w ${CONTAINER_CODE_DIR} \
        ${DOCKER_BUILDER_IMAGE}

.PHONY: docker docker_main docker_tag

docker:
	${DOCKER_BUILDER_RUN_CMD} ${DOCKER_BUILD_BRANCH_CMD}

docker_main:
	${DOCKER_BUILDER_RUN_CMD} ${DOCKER_BUILD_MAIN_CMD}

docker_tag:
	test ${TAG}
	${DOCKER_BUILDER_RUN_CMD} ${DOCKER_BUILD_TAG_CMD}

#Everything right of the pipe is order-only prerequisites.
all: | docker