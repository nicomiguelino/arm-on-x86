### A Simple D-Bus Example (Ping-Pong)

The examples are from the [qtbase](https://github.com/qt/qtbase) repository.

#### Building the Examples

```bash
cd /path/to/arm-on-x86
./scripts/initialize_builder.sh
docker exec -it qt6-builder-container bash
```

Inside the container, run:

```bash
# Build the D-Bus example
$ EXAMPLE=dbus-1 ./scripts/build_examples.sh

# Start the D-Bus session
$ dbus-launch --auto-syntax

# It will output something like:
DBUS_SESSION_BUS_ADDRESS='unix:path=/tmp/dbus-XXXXXXX,guid=XXXXXXX';
export DBUS_SESSION_BUS_ADDRESS;
DBUS_SESSION_BUS_PID=1234;
```

Open a new terminal for the D-Bus server binary and run:

```bash
# Get inside the container.
docker exec -it qt6-builder-container bash

# Initialize the D-Bus session
cd /build/release/pingpong
tar -zxf pingpong-armv7.tar.gz
DBUS_SESSION_BUS_ADDRESS='unix:path=/tmp/dbus-XXXXXXX,guid=XXXXXXX';
export DBUS_SESSION_BUS_ADDRESS;
DBUS_SESSION_BUS_PID=1234;

# Run the D-Bus server binary.
# The program will not terminate until you press Ctrl+C.
./pong
```

Open another terminal for the D-Bus client binary and run:

```bash
# Get inside the container.
docker exec -it qt6-builder-container bash

# Initialize the D-Bus session
cd /build/release/pingpong
tar -zxf pingpong-armv7.tar.gz
DBUS_SESSION_BUS_ADDRESS='unix:path=/tmp/dbus-XXXXXXX,guid=XXXXXXX';
export DBUS_SESSION_BUS_ADDRESS;
DBUS_SESSION_BUS_PID=1234;

# Run the D-Bus client binary.
# You can optionally pass an argument to the client binary.
./ping "Hello, D-Bus!"

# The client will send the message to the server, and the server will reply.
# The server will print the message received from the client.
```
