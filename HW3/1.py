#!/usr/bin/python

line=input("Vvedite Stroky: ")
count = 0
for i in line:
    if i.isupper():
        count+=1
print("Kol-vo propisnyh bukv: ", count)
