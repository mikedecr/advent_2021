using DelimitedFiles
using StatsBase

report_raw = readdlm("data/03.txt", String) # matrix of strings (rows)
report = [parse.(Int, x) for x in collect.(report_raw)] # matrix of int vectors

reshape(vcat(report...), (length(report), length(report[1])))


reshape(report, length(report), length(report[1]))

A

A = [1 2
     3 4]

A

maximum.(eachcol(A))


parse.(report, Char)

parse.(Int, report_raw)

collect.(report_raw)

for i in eachrow(report_raw)
    print(parse(Char, i))
end

report_raw[1]

report = 

function add_spaces(x::SubArray{String})
    print(x)
    output = ""
    for c in x
        output += c * " "
    end
    return output
    # x = c * ' ' for c in x
    # # print(x)
    # return x
end

first(eachrow(test_data))
add_spaces(first(eachrow(test_data))[1])



γ
ε

power = γ * ε


test_raw = ["00100"
             "11110"
             "10110"
             "10111"
             "10101"
             "01111"
             "00111"
             "11100"
             "10000"
             "11001"
             "00010"
             "01010"]
test_array = [parse.(Int, x) for x in collect.(test_raw)] # matrix of ints

test_data = permutedims(reshape(hcat(test_array...), (length(test_array[1]), length(test_array))))
# test_data = reshape(vcat(test_array...), (length(test_array), length(test_array[1])))

test_data

ints = mode.(eachcol(test_data))
parse(Int, bitstring(BitArray(ints)), base=2)

parse(Int, "110101"; base=2)




first(eachrow(test_data))