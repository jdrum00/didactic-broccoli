#!/usr/bin/python

import gzip

r1 = gzip.open('raw-170-r1-source.fq.gz', 'rb')
# r1 = open('raw-foo.fq')
r2 = gzip.open('../../r2.reheadered.fq.gz', 'rb')
r2out = open('raw-170-r2-source.fq', 'w')

# First line will be a header line. Start there.
r1line = r1.readline()
r1pattern = r1line.strip().split(' ')[0]
r2line = r2.readline()
r2pattern = r2line.strip().split(' ')[0]

while r1line:
	while r2pattern != r1pattern:
		r2line = r2.readline()
		r2pattern = r2line.strip().split(' ')[0]  # Keep scrolling through r2
	# When you find the match, write out that r2line and the next three lines to r2out, and increment r1.
	r2out.write(r2line)
	r2out.write(r2.readline())
	r2out.write(r2.readline())
	r2out.write(r2.readline())
	r1line = r1.readline()
	r1line = r1.readline()
	r1line = r1.readline()
	r1line = r1.readline() # Fourth line on is the next header
	r1pattern = r1line.strip().split(' ')[0]

r1.close()
r2.close()
r2out.close()
