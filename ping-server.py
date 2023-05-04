import time
import requests
import socket

nitriding_url = "http://127.0.0.1:8080/enclave/ready"
num_retries = 5
retry_delay_seconds = 1


def signal_ready():
    r = requests.get(url=nitriding_url)
    if r.status_code != requests.status_codes.codes.ok:
        raise Exception("Expected status code %d but got %d" %
                        (requests.status_codes.codes.ok, r.status_code))

def is_port_running(port):
    # Create a TCP/IP socket
    sock = socket.socket(socket.AF_INET, socket.SOCK_STREAM)

    # Set a timeout of 1 second
    sock.settimeout(1)

    try:
        # Attempt to connect to the specified port
        result = sock.connect_ex(('localhost', port))
        if result == 0:
            # Port is running
            return True
        else:
            # Port is not running
            return False
    except Exception:
        # An error occurred while attempting to connect to the port
        return False
    finally:
        # Close the socket
        sock.close()


def main():
    for i in range(num_retries):
        if is_port_running(5000):
            print("Minecraft is running")
            signal_ready()
            return
        time.sleep(retry_delay_seconds)
    raise Exception("minecraft server didn't respond")
if __name__ == "__main__":
    main()