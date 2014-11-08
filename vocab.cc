
#include <iostream>
#include <unordered_map>
#include <string>
#include <fstream>
#include <iterator>
#include <sstream>
#include <algorithm>
#include <vector>

using namespace std;

int main(int argc, char* argv[])
{
    if (argc == 2)
    {
        unsigned cut = 10;
        unordered_map<string, unsigned> count;

        // Create a lazy iterator on words
        ifstream ifs(argv[1], ifstream::in);
        istream_iterator<string> start(ifs);
        istream_iterator<string> end;

        // Process stream of tokens
        for_each(start, end, [&count](const string& word)
        {
            ++count[word];
        });

        ifs.close();

        // Sort Counter
        vector<pair<string, unsigned>> count_vec(count.begin(), count.end());
        sort(count_vec.begin(), count_vec.end(),
        [](const pair<string, unsigned>& a, const pair<string, unsigned>& b)
        {
            return a.second > b.second;
        });

        for (auto& word: count_vec)
        {
            if (word.second > cut)
            {
                cout << word.first << '\t' << word.second << '\n';
            }
        }
        cout.flush();
    }
}
