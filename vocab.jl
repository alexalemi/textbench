counts = Dict{String,Int}()

open(ARGS[1],"r") do f
    for line in eachline(f)
        for word in split(line)
            counts[word] = get(counts,word,0) + 1 
        end
    end
end

cut = 10

guys = collect(counts)
sort!( guys, by=(x)->x[2], rev=true )

for x in guys
    if x[2] > cut
        println(x[1], '\t',  x[2])
    end
end

