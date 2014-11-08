# TextBench

A simple benchmark for text processing comparing the speeds of Julia, Go, C, and Python, in particular to report
on [this Julia issue](https://github.com/JuliaLang/julia/issues/8826).  In all cases, the programs read in `text8` and print
the words that occur at least 10 times in order of number of occurances.

The C Code is taken from the [GloVE project](http://nlp.stanford.edu/projects/glove/), covered
under the Apache License, a copy of which is included in the C code.

The example corpus is the [text8](http://mattmahoney.net/dc/text8.zip) corpus from Matt Mahoney [[more info]](http://mattmahoney.net/dc/textdata.html)

As downloaded, `text8` is a single line, so I do two versions of each test, one on the original `text8` and the second on a `fmt`'ed version of `text8`
with the text broken up into reasonable line widths.  Results on my machine available in [results.txt](results.txt).

To run the benchmarks, it should be enough to issue `make`.

The results in [results.txt](results.txt) were generated on a quad core x86 machine running Ubuntu 13.04.

Thanks to @remusao for the haskell, cpp, and python3 versions as well as general improvements.


