package main

import (
    "fmt"
    "sort"
    "log"
    "bufio"
    "os"
)

const minCount = 10

// Word is a struct holding the count of the word and the word itself
type Word struct {
	Count uint64
	Word  string
}

// WordList is a list of words, and implements the sort interface
type WordList []Word

func (w WordList) Swap(i, j int) {
	w[i], w[j] = w[j], w[i]
}
func (w WordList) Len() int {
	return len(w)
}
func (w WordList) Less(i, j int) bool {
	if w[i].Count == w[j].Count {
		return w[i].Word < w[j].Word
	}
	return w[i].Count > w[j].Count
}

// mapToList converts a map to a WordList
func mapToList(m map[string]uint64) WordList {
	p := make(WordList, len(m))
	i := 0
	for k, v := range m {
		p[i] = Word{Word: k, Count: v}
		i++
	}
	sort.Sort(p)
	return p
}

func main() {
	log.Println("Reading new corpus from stdin", )

	counts := make(map[string]uint64)
	scanner := bufio.NewScanner(os.Stdin)
	scanner.Split(bufio.ScanWords)
	i := 0
	for scanner.Scan() {
		word := scanner.Text()
		if c, ok := counts[word]; ok {
			counts[word] = c + 1
		} else {
			counts[word] = 1
		}
		i++
		if i%100000 == 0 {
			fmt.Printf("Processed %vk tokens\r", i/100000)
		}
	}
	fmt.Printf("\n")
	log.Printf("Finished. Found %v words\n", len(counts))

	if err := scanner.Err(); err != nil {
		log.Fatal("Error scanning corpus", err)
	}

	// purge low counts
	for k, v := range counts {
		if v < minCount {
			delete(counts, k)
		}
	}
	log.Printf("%v words made the cut\n", len(counts))

	wordList := mapToList(counts)

	for _, w := range wordList {
		fmt.Printf("%v\t%v\n", w.Word, w.Count)
	}

}
