from __future__ import print_function
import sys
from collections import Counter
from operator import itemgetter


def main():
    cut = 10
    counter = Counter()
    with open(sys.argv[1], 'r') as f:
        for line in f:
            for word in line.split():
                counter[word] += 1

    for word, count in sorted(counter.items(), key=itemgetter(1), reverse=True):
        if count > cut:
            print(word, count)


if __name__ == "__main__":
    main()
