import logging
import os
import pydbus
import sh

from time import sleep

logging.basicConfig(level=logging.INFO)

def main():
    os.environ['QT_QPA_DEBUG'] = '1'

    # Run `./pong` in the background.
    # subprocess.run in background
    process = sh.Command('./pong')(_bg=True, _err_to_out=True)
    sleep(3)

    # Get the D-Bus session bus.
    bus = pydbus.SessionBus()
    bus_instance = bus.get('sandbox.pingpong', '/')

    # Call the method `ping` on the D-Bus object.
    bus_instance.ping('World')


if __name__ == '__main__':
    try:
        main()
    except Exception:
        logging.error('An error occurred.')
        raise
