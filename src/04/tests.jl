include("src/04/fns.jl")


# --- instantiate test data ---

# make a card
multiplier = [1 2 7 5 3] 
base = [1 2 3 4 5
        1 2 3 4 5
        1 2 3 4 5
        1 2 3 4 5
        1 2 3 4 5]
card = multiplier .* base
 
row_draws = [1 4 21 20 15]
col_draws = [1 1 1 1 1]
false_draws = [0 0 0 0 0]

# --- check single axis ---

# horizontal axis true / false
@assert is_axis_bingo(card[1, :], row_draws) == true
@assert is_axis_bingo(card[1, :], false_draws) == false

# vertical axis true / false
@assert is_axis_bingo(card[:, 1], col_draws) == true
@assert is_axis_bingo(card[:, 1], false_draws) == false

# diagonals don't count


# --- check entire card ---

@assert check_bingo(card, row_draws)
@assert check_bingo(card, [1 1 1 1 1])
@assert check_bingo(card, [3 6 9 12 15])


# --- bingo round ---

play_bingo_round([card], row_draws)
play_bingo_round([card], col_draws)



# --- test reading data ---

import DelimitedFiles as delim

raw = delim.readdlm("data/04_test.txt")

# grab first row, convert to Ints
using Pipe
draws = @pipe raw[1, :] |> 
    join(_) |>
    split(_, ',') |>
    [parse.(Int, x) for x in _]


# extract boards from the remainder
import BlockArrays as blk

boards_joined = raw[2:end, :]
cuts = repeat([5], div(size(boards_joined, 1), 5))
boards = blk.BlockArray(boards_joined, cuts, [5])

# --- do we get the example answer back? ---
@assert winning_score(play_bingo(blk.blocks(boards), draws)...) == 4512

