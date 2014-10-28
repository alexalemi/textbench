import sys

from collections import defaultdict

counter = defaultdict(int)
cut = 10

with open(sys.argv[1]) as f:
    for line in f:
        for word in line.split():
            counter[word] += 1


from operator import itemgetter

for word,count in sorted( counter.iteritems(), key=itemgetter(1), reverse=True ):
    if count > cut:
        print word, count


