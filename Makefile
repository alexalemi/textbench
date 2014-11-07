# C Compiler
CC = gcc
#For older gcc, use -O3 or -O2 instead of -Ofast
CFLAGS = -lm -pthread -Ofast -march=native -funroll-loops -Wno-unused-result

# C++ Compiler
CXX = g++
CXXFLAGS = -std=c++11 -Ofast -march=native -funroll-loops



all: tests fmttests

tests: ctest cctest py2test py3test pypytest juliatest gotest
fmttests: ctestfmt cctestfmt py2testfmt py3testfmt pypytestfmt juliatestfmt gotestfmt


vocab_count : vocab.c vocab.cc vocab.hs
	$(CC) vocab.c -o vocab_c $(CFLAGS)
	$(CXX) vocab.cc -o vocab_cc $(CXXFLAGS)
	ghc -O2 -Wall vocab.hs

text8:
	wget http://mattmahoney.net/dc/text8.zip
	unzip text8.zip
	rm text8.zip

ctest: vocab_count text8
	@echo -e "\n---Testing C"
	@time ./vocab_c -min-count 10 -verbose 2 < text8 > vocab.txt

cctest: vocab_count text8
	@echo -e "\n---Testing C++"
	@time ./vocab_cc text8 > vocab.txt

hstest: vocab_count text8
	@echo -e "\n---Testing Haskell"
	@time ./vocab text8 > vocab.txt

pypytest: vocab.py text8
	@echo -e "\n---Testing Pypy"
	@time pypy vocab.py text8 > vocab.txt

py2test: vocab.py text8
	@echo -e "\n---Testing Python 2"
	@time python2 vocab.py text8 > vocab.txt

py3test: vocab.py text8
	@echo -e "\n---Testing Python 3"
	@time python3 vocab.py text8 > vocab.txt

juliatest: vocab.jl text8
	@echo -e "\n---Testing Julia"
	@time julia vocab.jl text8 > vocab.txt

gotest: vocab.go text8
	@echo -e "\n---Testing Go"
	@time go run vocab.go < text8 > vocab.txt

text8fmt: text8
	fmt text8 > text8fmt

ctestfmt: vocab_count text8fmt
	@echo -e "\n---Testing C formatted version"
	@time ./vocab_c -min-count 10 -verbose 2 < text8fmt > vocab.txt

cctestfmt: vocab_count text8fmt
	@echo -e "\n---Testing C++ formatted version"
	@time ./vocab_cc text8fmt > vocab.txt

hstestfmt: vocab_count text8fmt
	@echo -e "\n---Testing Haskell formatted version"
	@time ./vocab text8fmt > vocab.txt

pypytestfmt: vocab.py text8fmt
	@echo -e "\n---Testing Pypy formatted version"
	@time pypy vocab.py text8fmt > vocab.txt

py2testfmt: vocab.py text8fmt
	@echo -e "\n---Testing Python 2 formatted version"
	@time python2 vocab.py text8fmt > vocab.txt

py3testfmt: vocab.py text8fmt
	@echo -e "\n---Testing Python 3 formatted version"
	@time python3 vocab.py text8fmt > vocab.txt

juliatestfmt: vocab.jl text8fmt
	@echo -e "\n---Testing Julia formatted version"
	@time julia vocab.jl text8fmt > vocab.txt

gotestfmt: vocab.go text8fmt
	@echo -e "\n---Testing Go formatted version"
	@time go run vocab.go < text8fmt > vocab.txt

clean:
	rm -rf vocab_count vocab.txt
