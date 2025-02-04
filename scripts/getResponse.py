import requests
import json
from bs4 import BeautifulSoup

url = "http://192.168.130.140:1936"
auth = ('test', 'test')
response = requests.get(url, auth=auth)

html_content = response.text

soup = BeautifulSoup(html_content, "html.parser")
rows = soup.find_all("tr", class_=["active_up", "active_down"])
servers = []

for row in rows:
    server_name = row.find("a", class_="lfsb").text
    status = "UP" if "active_up" in row["class"] else "DOWN"
    active_connections = row.find("th", text="Current active connections:").find_next("td").text
    servers.append([server_name, status, active_connections])

requests.post("https://ntfy.sh/monkeydomonkey",
     json=servers)
