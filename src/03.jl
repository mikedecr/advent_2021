using DelimitedFiles
using StatsBase

# matrix of strings (rows)
# report_raw = readdlm("data/03.txt", String) 
report_raw = readdlm("data/03_test.txt", String) 

# convert to matrix of single chars
report = let A = report_raw
    A = collect.(A)               # explode string to chars
    A = reshape(vcat(A...), :, length(A))  # matrix of chars BY COLUMN
    permutedims(A)
end

# --- pt 1 ---

modes = mode.(eachcol(report))
anti_modes = [Dict('0' => '1', '1' => '0')[key] for key in modes]
modes_as_string = String.([modes, anti_modes])
# bits to ints (Julia greek compatibility, baybee)
γ, ε = parse.(Int, modes_as_string, base=2)

answer_1 = prod([γ, ε])


# --- pt 2 ---
