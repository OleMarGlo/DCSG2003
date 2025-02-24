import subprocess
import time
import requests

def getDownloadtime():
    wget_cmd = ["wget2", "-t", "3", "-T15", "-p", "--max-threads=20", "-p", "http://10.212.172.50/"]
    grep_cmd = ["grep", "real"]

    start = time.time()
    wget_process = subprocess.run(wget_cmd, capture_output=True, text=True)
    end = time.time()
    if(end-start > 5):
        message = f"Time is {end-start}, do something"
        requests.post("https://ntfy.sh/olemgl-DCSG2003",
            data=message.encode(encoding='utf-8'),
            headers={
                "priority": "5",
                "title": "Download is EXTREMLY high, do something"
            })  
    elif(end-start > 2):
        message = f"Time is {end-start}, no speed bonus"
        requests.post("https://ntfy.sh/olemgl-DCSG2003",
            data=message.encode(encoding='utf-8'),
            headers={
                "priority": "4",
                "title": "Download is over 2 seconds"
            })

def main():
    getDownloadtime()

if __name__ == "__main__":
    main()
