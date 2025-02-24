import subprocess
import requests

def get_servers():
    result = subprocess.run(
        ["openstack", "server", "list", "--format", "value", "--column", "Name", "--column", "Status"],
        capture_output=True, text=True
        )
    servers = result.stdout.strip().split("\n")

    for server in servers:
        parts = server.split()
        if len(parts) >= 2:
            server_name, status = parts[0], parts[1]
            if server_name = "backup":
                continue
            if status == "SHUTOFF":
                subprocess.run(["openstack", "server", "start", server_name])
                message = f"Server {server_name} has been restarted"
                requests.post("https://ntfy.sh/olemgl-DCSG2003", data=message.encode(encoding='utf-8'),
                        headers={"Title": "Server has been started"})

def main():
    get_servers()

if __name__ == "__main__":
    main()

