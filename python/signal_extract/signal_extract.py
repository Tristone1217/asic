#!/usr/bin/python
import sys
import re
pattern = r'module\s+(\w+)'
pt      = re.compile(pattern)
test = open('file.txt')
for line in test.readlines():
    if pt.findall(line):
        signal_name = pt.findall(line)[0]
        print(signal_name)



