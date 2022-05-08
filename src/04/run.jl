# implement day 4

include("src/04/fns.jl")
import DelimitedFiles as dlm
using Pipe
import BlockArrays as blk

raw = dlm.readdlm("data/04.txt")

# extract stream of pulls off the top row of the text file
stream = @pipe raw[1, :] |>
    join(_) |>
    split(_, ',') |>
    [parse.(Int, x) for x in _]

# divide remaining rows into 5 x 5 sub-arrays
boards = let boards_joined = raw[2:end, :]
    local n_boards = div(size(boards_joined, 1), 5)
    # solve for the number of times we have to "cut" the joined board
    local board_cut_ixs = repeat([5], n_boards) 
    blk.BlockArray(boards_joined, board_cut_ixs, [5])
end

# get the winning board & score
winner, pulls = play_bingo(blk.blocks(boards), stream)
winning_score(winner, pulls)

