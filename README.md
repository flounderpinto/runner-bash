# Runner Bash
A simple Docker image that provides an environment to execute bash scripts.

## Description
The image is Ubuntu based and contains the git executable (for accessing remote scripts).

## Docker repo
```bash
index.docker.io/flounderpinto/runner-bash:<VERSION>
```

## Usage

### Makefile Docker example
The commands to run a script via the runner-bash container can be contained in a Makefile.  This examples executes the user's ./src/clone.sh script.

```Makefile
USER=$(shell id -u):$(shell id -g)
ROOT_DIR:=$(shell dirname $(realpath $(lastword $(MAKEFILE_LIST))))

CONTAINER_CODE_DIR=/opt/code
CONTAINER_OUTPUT_DIR=/opt/output

BUILD_CMD=./src/clone.sh

DOCKER_REGISTRY=index.docker.io/flounderpinto

RUNNER_IMAGE=${DOCKER_REGISTRY}/runner-bash:v0.0.4
RUNNER_PULL_CMD=docker pull ${RUNNER_IMAGE}
RUNNER_RUN_CMD=${RUNNER_PULL_CMD} && \
    docker run \
        --rm \
        --user ${USER} \
        -v ${ROOT_DIR}:${CONTAINER_CODE_DIR} \
        -v ${ROOT_DIR}:${CONTAINER_OUTPUT_DIR} \
        -w ${CONTAINER_CODE_DIR} \
        ${RUNNER_IMAGE} /bin/bash -c

.PHONY: build build_local

build:
	${RUNNER_RUN_CMD} "${BUILD_CMD}"

build_local:
	${BUILD_CMD}

all: | build
```

## License
Distributed under the MIT License. See `LICENSE.txt` for more information.