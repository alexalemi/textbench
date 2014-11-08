
use std::collections::hashmap::{Occupied, Vacant, HashMap};
use std::io::BufferedReader;
use std::io::File;
use std::os;
use std::str::StrSlice;

fn main()
{
    let args = os::args();
    let path = Path::new(args[1].as_slice());
    let mut file = BufferedReader::new(File::open(&path));
    let mut counter: HashMap<String, uint> = HashMap::new();

    for line_opt in file.lines()
    {
        let line = line_opt.ok().expect("Could not read line");
        for word in line.as_slice().split(' ')
        {
            let key = word.to_string();
            // Update count
            match counter.entry(key) {
                Vacant(entry) => { let _ = entry.set(1u); },
                Occupied(mut entry) => {
                    *entry.get_mut() += 1;
                }
            };
        }
    }

    println!("{}", counter.len());
}
