CC = gcc
#For older gcc, use -O3 or -O2 instead of -Ofast
CFLAGS = -lm -pthread -Ofast -march=native -funroll-loops -Wno-unused-result


all: tests

tests: ctest pytest juliatest gotest

vocab_count : vocab_count.c
	$(CC) vocab_count.c -o vocab_count $(CFLAGS)

text8:
	wget http://mattmahoney.net/dc/text8.zip
	unzip text8.zip
	rm text8.zip

ctest: vocab_count text8
	echo "\n---Testing C"
	exec time ./vocab_count -min-count 10 -verbose 2 < text8 > vocab.txt

pytest: vocab.py text8
	echo "\n---Testing Python"
	time python vocab.py text8 > vocab.txt

juliatest: vocab.jl text8
	echo "\n---Testing Julia"
	time julia vocab.jl text8 > vocab.txt

gotest: vocab.go text8
	echo "\n---Testing Go"
	time go run vocab.go < text8 > vocab.txt

clean:
	rm -rf vocab_count vocab.txt
