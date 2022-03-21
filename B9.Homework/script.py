import requests
ith open("urls.txt") as file:
    site = file.read()
    url = site + "favicon.ico"
r = requests.get(url, allow_redirects=True)
open('site.ico', 'wb').write(r.content)
