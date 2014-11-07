
function vocab(file)
    cut = 10
    counter = Dict{String, Int}()
    open(file, "r") do io
        for line in eachline(io)
            for word in split(line)
                counter[word] = 1 + get(counter, word, 0)
            end
        end
    end

    # Sort and display
    guys = collect(counter)
    sort!(guys, by=(x) -> x[2], rev=true)

    for x in guys
        if x[2] > cut
            println(x[1], '\t',  x[2])
        end
    end
end


vocab(ARGS[1])
