#!/usr/bin/python

import requests
import json

r = requests.get("http://api.apixu.com/v1/current.json?key=5ee36a0969a64a29b93163935163012&q=Joinville")
resp = json.loads(r.content)

print str(resp["current"]["temp_c"])+":"+str(resp["current"]["feelslike_c"])

