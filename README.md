### Running ARM Docker Containers on x86

This project contains experiments involving running ARM-based Docker containers
on x86-based machines.

### Pre-requisites

Install and set up QEMU on your machine. On Ubuntu, you can do this by running:

```bash
sudo apt-get install qemu binfmt-support qemu-user-static
docker run --rm --privileged multiarch/qemu-user-static --reset -p yes
docker run --rm -t arm32v7/debian uname -m # This should return `armv7l`
```

Make sure to create a Docker Buildx instance by running:

```bash
docker buildx create --use
```

### Building the Examples

Start the Docker container by running:

```bash
./scripts/initialize_builder.sh
```

Go inside the container by running:

```bash
docker exec -it qt6-builder-container bash
```

Build the examples by running:

```bash
./scripts/build_examples.sh
```

Outside the container, you can see the build binaries inside the
`build/release` directory.
