#!/usr/bin/python

import requests
import json

r = requests.get("http://api.fixer.io/latest?base=USD;symbols=BRL")
resp = json.loads(r.content)

print str(resp["rates"]["BRL"])
