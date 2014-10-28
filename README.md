# TextBench

A simple benchmark for text processing comparing the speeds of Julia, Go, C, and Python, in particular to report
on [this Julia issue](https://github.com/JuliaLang/julia/issues/8826)

The C Code is taken from the [GloVE project](http://nlp.stanford.edu/projects/glove/), covered
under the Apache License, a copy of which is included in the C code.

The example corpus is the [text8](http://mattmahoney.net/dc/text8.zip) corpus from Matt Mahoney [[more info]](http://mattmahoney.net/dc/textdata.html)

To run the benchmarks, it should be enough to issue `make`.

