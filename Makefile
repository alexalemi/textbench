# C Compiler
CC = gcc
#For older gcc, use -O3 or -O2 instead of -Ofast
CFLAGS = -lm -pthread -Ofast -march=native -funroll-loops -Wno-unused-result

# C++ Compiler
CXX = g++
CXXFLAGS = -std=c++11 -Ofast -march=native -funroll-loops

# Tests all of the languages, if you
# don't have one of these installed, remove them from the list
all: c cpp py2 py3 pypy julia go haskell rust

c: ctest ctestfmt
rust: rstest rstestfmt
haskell: hstest hstestfmt
cpp: cctest cctestfmt
py2: py2test py2testfmt
py3: py3test py3testfmt
pypy: pypytest pypytestfmt
julia: juliatest juliatestfmt
go: gotest gotestfmt


vocab_c : vocab.c 
	$(CC) vocab.c -o vocab_c $(CFLAGS)

vocab_cc: vocab.cc
	$(CXX) vocab.cc -o vocab_cc $(CXXFLAGS)

vocab_hs: vocab.hs
	ghc -O2 -Wall vocab.hs -o vocab_hs

vocab_rs: vocab.rs
	rustc vocab.rs --opt-level 3 -o vocab_rs

text8:
	wget http://mattmahoney.net/dc/text8.zip
	unzip text8.zip
	rm text8.zip

# TESTS

ctest: vocab_c text8
	@echo "\n---Testing C"
	@$(CC) --version
	@time ./vocab_c -min-count 10 -verbose 2 < text8 > vocab.txt

cctest: vocab_cc text8
	@echo "\n---Testing C++"
	@$(CXX) --version
	@time ./vocab_cc text8 > vocab.txt

rstest: vocab_rs text8
	@echo "\n---Testing Rust"
	@rustc --version
	@time ./vocab_rs text8 > vocab.txt

hstest: vocab_hs text8
	@echo "\n---Testing Haskell"
	@ghc --version
	@time ./vocab_hs text8 > vocab.txt

pypytest: vocab.py text8
	@echo "\n---Testing Pypy"
	@pypy --version
	@time pypy vocab.py text8 > vocab.txt

py2test: vocab.py text8
	@echo "\n---Testing Python 2"
	@python2 --version
	@time python2 vocab.py text8 > vocab.txt

py3test: vocab.py text8
	@echo "\n---Testing Python 3"
	@python3 --version
	@time python3 vocab.py text8 > vocab.txt

juliatest: vocab.jl text8
	@echo "\n---Testing Julia"
	@julia --version
	@time julia vocab.jl text8 > vocab.txt

gotest: vocab.go text8
	@echo "\n---Testing Go"
	@go version
	@time go run vocab.go < text8 > vocab.txt


# FMT TESTS

text8fmt: text8
	fmt text8 > text8fmt

ctestfmt: vocab_c text8fmt
	@echo "\n---Testing C formatted version"
	@$(CC) --version
	@time ./vocab_c -min-count 10 -verbose 2 < text8fmt > vocab.txt

cctestfmt: vocab_cc text8fmt
	@echo "\n---Testing C++ formatted version"
	@$(CXX) --version
	@time ./vocab_cc text8fmt > vocab.txt

rstestfmt: vocab_rs text8fmt
	@echo "\n---Testing Rust formatted version"
	@rustc --version
	@time ./vocab_rs text8fmt > vocab.txt

hstestfmt: vocab_hs text8fmt
	@echo "\n---Testing Haskell formatted version"
	@ghc --version
	@time ./vocab_hs text8fmt > vocab.txt

pypytestfmt: vocab.py text8fmt
	@echo "\n---Testing Pypy formatted version"
	@pypy --version
	@time pypy vocab.py text8fmt > vocab.txt

py2testfmt: vocab.py text8fmt
	@echo "\n---Testing Python 2 formatted version"
	@python2 --version
	@time python2 vocab.py text8fmt > vocab.txt

py3testfmt: vocab.py text8fmt
	@echo "\n---Testing Python 3 formatted version"
	@python3 --version
	@time python3 vocab.py text8fmt > vocab.txt

juliatestfmt: vocab.jl text8fmt
	@echo "\n---Testing Julia formatted version"
	@julia --version
	@time julia vocab.jl text8fmt > vocab.txt

gotestfmt: vocab.go text8fmt
	@echo "\n---Testing Go formatted version"
	@go version
	@time go run vocab.go < text8fmt > vocab.txt

clean:
	rm -rf vocab_* vocab.txt
