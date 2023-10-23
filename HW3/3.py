#!/usr/bin/python

from datetime import date
from datetime import datetime

today = date.today()
print("Today's date: ", today)
d1 = today.strftime("%d/%m/%Y")
print("Day format1 = ", d1)
d2 = today.strftime("%B %d, %Y")
print("Day format2 = ", d2)
d3 = today.strftime("%m/%d/%y")
print("Day format3 = ", d3)
d4 = today.strftime("%b-%d-%Y")
print("Day format4 = ", d4)

now = datetime.now()
print("Time now is: ", now.strftime("%H:%M:%S"))
