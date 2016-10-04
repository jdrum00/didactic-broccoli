#!/usr/bin/python
import sys

line = sys.stdin.readline()

while line:
    if line[0] != '@':
      sys.stdout.write(line)
    else:
      e = line.replace('#',':').replace('/',':').strip().split(':')
      sys.stdout.write('%s:9999:99999999XX:%s:%s:%s:%s %s:N:0:%s\n' % (e[0], e[1], e[2], e[3], e[4], e[6], e[5]))
    line = sys.stdin.readline()

