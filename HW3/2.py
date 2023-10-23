#!/usr/bin/python

import os
hostname = "google.com"
response = os.system("ping -c 1 " + hostname + ">/dev/null 2>&1")
if response == 0:
    print("Success!")
else:
    print("Doesn't work!")

